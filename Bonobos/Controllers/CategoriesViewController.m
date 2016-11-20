//
//  CategoriesViewController.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoriesViewController.h"

#import "CategoriesService.h"
#import "CategoryModel.h"

#import "SubCategoryViewController.h"
#import "CategoryTableViewCell.h"
#import "LoadingView.h"

#import "Masonry.h"

NSString * const CategoryCellReuseIdentifier = @"CategoryCellReuseIdentifier";

@interface CategoriesViewController () <UITableViewDataSource, CategoryTableViewCellDelegate>
@property (nonatomic, strong, readonly) CategoriesService *categoriesService;
@property (nonatomic, strong, readonly) NSArray *categoryPathNames;
@property (nonatomic, strong, readonly) NSMutableArray *categories;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger completedRequests;
@property (nonatomic, strong) NSMutableArray *activeRequests;
@property (nonatomic, assign) BOOL loading;

@property (nonatomic, strong) LoadingView *loadingView;
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startLoading];
    [self styleNavigationBar];
    [self setupCategoryService];
    [self setupTableView];
    
    [self fetchCategories];
}

- (void)styleNavigationBar {
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bonobos_logo"]];

    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"briefcase"]]];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)setupCategoryService {
    _categoriesService = [[CategoriesService alloc] init];
    
    // This is only necessary because we don't have an endpoint that returns all categories. We're hardcoding them here based on the categories shown on the site.
    _categoryPathNames = @[
                           @"holiday",
                           @"sale",
                           @"goodsport",
                           @"bottoms",
                           @"tops",
                           @"tailored",
                           @"outerwear",
                           @"golf",
                           @"accessories",
                           @"shoes"
                           ];
    _categories = [NSMutableArray arrayWithArray:_categoryPathNames];
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:CategoryCellReuseIdentifier];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark - Network Operations

- (void)fetchCategories {
    self.activeRequests = [NSMutableArray new];
    
    for (NSString *path in self.categoryPathNames) {
        __weak typeof (self) weakSelf = self;
        NSURLSessionTask *task = [self.categoriesService getCategory:path success:^(CategoryModel *category, NSURLSessionTask *task) {
            [weakSelf handleCategoryFetchSuccess:category task:task];
        } failure:^(NSError *error) {
            [self handleCategoryFetchFailure:error];
        }];
        
        [self.activeRequests addObject:task];
    }
}

- (void)handleCategoryFetchSuccess:(CategoryModel *)category task:(NSURLSessionTask *)task {
    self.completedRequests++;
    
    NSInteger index = [self.activeRequests indexOfObject:task];
    [self.categories replaceObjectAtIndex:index withObject:category];
    
    if (self.completedRequests == self.categoryPathNames.count) [self endLoading];
}

- (void)handleCategoryFetchFailure:(NSError *)error {
    self.completedRequests++;
    NSLog(@"%@", error.localizedDescription);
    
    if (self.completedRequests == self.categoryPathNames.count) [self endLoading];
}

#pragma mark - Loading

- (void)startLoading {
    if (self.loadingView != nil) return;
    
    self.loading = YES;
    
    self.loadingView = [[LoadingView alloc] init];
    [self.navigationController.view addSubview:self.loadingView];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.view);
    }];
}

- (void)endLoading {
    if (self.loadingView == nil) return;
    
    self.loading = NO;
    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.loading ? 0 : self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:CategoryCellReuseIdentifier forIndexPath:indexPath];
    categoryCell.delegate = self;
    categoryCell.categoryModel = [self.categories objectAtIndex:indexPath.row];
    return categoryCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryModel *categoryModel = [self.categories objectAtIndex:indexPath.row];
    return CategoryCellImageHeight + (CategoryCellSubCategoryCellHeight * categoryModel.subCategories.count) + CategoryCellFooterHeight;
}

#pragma mark - CategoryTableViewCellDelegate

- (void)categoryTableViewCell:(CategoryTableViewCell *)cell didSelectCategory:(CategoryModel *)category {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SubCategoryViewController * subcategoryVC = (SubCategoryViewController *)[sb instantiateViewControllerWithIdentifier:@"SubCategoryViewController"];
    subcategoryVC.category = category;
    
    [self.navigationController pushViewController:subcategoryVC animated:YES];
}

@end

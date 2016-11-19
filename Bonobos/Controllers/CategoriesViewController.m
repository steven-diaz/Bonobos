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

#import "CategoryTableViewCell.h"
#import "LoadingView.h"

#import "Masonry.h"

NSString * const CategoryCellReuseIdentifier = @"CategoryCellReuseIdentifier";

@interface CategoriesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readonly) CategoriesService *categoriesService;
@property (nonatomic, strong, readonly) NSArray *categoryPathNames;
@property (nonatomic, strong, readonly) NSArray *categories;

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger completedRequests;

@property (nonatomic, strong) LoadingView *loadingView;
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startLoading];
    [self styleNavigationBar];
    [self setupCategoryService];
    [self setupTableView];
    
    _categories = [NSArray new];
    [self fetchCategories];
}

- (void)styleNavigationBar {
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bonobos_logo"]];
}

- (void)setupCategoryService {
    _categoriesService = [[CategoriesService alloc] init];
    
    // This is only necessary because we don't have an endpoint that returns all categories. We're hardcoding them here based on the categories shown on the site.
    _categoryPathNames = @[
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
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:CategoryCellReuseIdentifier];
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark - Network Operations

- (void)fetchCategories {
    for (NSString *path in self.categoryPathNames) {
        __weak typeof (self) weakSelf = self;
        [self.categoriesService getCategory:path success:^(CategoryModel *category) {
            [weakSelf handleCategoryFetchSuccess:category];
        } failure:^(NSError *error) {
            [self handleCategoryFetchFailure:error];
        }];
    }
}

- (void)handleCategoryFetchSuccess:(CategoryModel *)category {
    self.completedRequests++;
    
    NSMutableArray *mutableCategories = [NSMutableArray arrayWithArray:self.categories];
    [mutableCategories addObject:category];
    
    _categories = mutableCategories.copy;
    
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
    
    self.loadingView = [[LoadingView alloc] init];
    [self.navigationController.view addSubview:self.loadingView];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.navigationController.view);
    }];
}

- (void)endLoading {
    if (self.loadingView == nil) return;
    
    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.loadingView removeFromSuperview];
        self.loadingView = nil;
    }];
}

//- (void)insertCellForCategory:(CategoryModel *)category {
//    NSMutableArray *mutableCategories = [NSMutableArray arrayWithArray:self.categories];
//    [mutableCategories addObject:category];
//
//    _categories = mutableCategories.copy;
//
//    [self.tableView beginUpdates];
//    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.categories.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableView endUpdates];
//}

#pragma mark - UICollectionViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryTableViewCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:CategoryCellReuseIdentifier forIndexPath:indexPath];
    categoryCell.categoryModel = [self.categories objectAtIndex:indexPath.row];
    return categoryCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryModel *categoryModel = [self.categories objectAtIndex:indexPath.row];
    return 170 + (64 * categoryModel.subCategories.count);
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

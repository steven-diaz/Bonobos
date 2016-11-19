//
//  CategoriesViewController.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoriesViewController.h"

#import "CategoriesService.h"
#import "CategoryTableViewCell.h"
#import "CategoryModel.h"

NSString * const CategoryCellReuseIdentifier = @"CategoryCellReuseIdentifier";

@interface CategoriesViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong, readonly) CategoriesService *categoriesService;
@property (nonatomic, strong, readonly) NSArray *categoryPathNames;
@property (nonatomic, strong, readonly) NSArray *categories;

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, assign) NSInteger categoryRequestIndex;
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleNavigationBar];
    [self setupCategoryService];
    [self setupTableView];
    
    _categories = [NSArray new];
    [self fetchNextCategory];
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
    
    self.categoryRequestIndex = 0;
}

- (void)setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:CategoryCellReuseIdentifier];
    //self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView setContentInset:UIEdgeInsetsZero];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark - Network Operations

- (void)fetchNextCategory {
    if (self.categoryRequestIndex == self.categoryPathNames.count) return;
    
    NSString *categoryToFetch = [self.categoryPathNames objectAtIndex:self.categoryRequestIndex];
    __weak typeof (self) weakSelf = self;
    [self.categoriesService getCategory:categoryToFetch success:^(CategoryModel *category) {
        [weakSelf insertCellForCategory:category];
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}

#pragma mark - Cell Insertion

- (void)insertCellForCategory:(CategoryModel *)category {
    NSMutableArray *mutableCategories = [NSMutableArray arrayWithArray:self.categories];
    [mutableCategories addObject:category];
    
    _categories = mutableCategories.copy;
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.categories.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
    
    self.categoryRequestIndex++;
    [self fetchNextCategory];
}

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

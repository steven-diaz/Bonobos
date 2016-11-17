//
//  CategoriesViewController.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoriesViewController.h"

#import "CategoriesService.h"
#import "CategoryCollectionViewCell.h"

NSString * const CategoryCellReuseIdentifier = @"CategoryCellReuseIdentifier";

@interface CategoriesViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong, readonly) CategoriesService *categoriesService;
@property (nonatomic, strong, readonly) NSArray *categoryPathNames;
@property (nonatomic, strong, readonly) NSArray *categories;

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleNavigationBar];
    [self setupCategoryService];
    [self setupCollectionView];
    
    _categories = [NSArray new];
    [self fetchCategories];
}

- (void)styleNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
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

- (void)setupCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:CategoryCellReuseIdentifier];
    [self.collectionView setContentInset:UIEdgeInsetsMake(10, 0, 0, 0)];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

#pragma mark - Network Operations

- (void)fetchCategories {
    for (NSString *path in self.categoryPathNames) {
        __weak typeof (self) weakSelf = self;
        [self.categoriesService getCategory:path success:^(CategoryModel *category) {
            [weakSelf insertCellForCategory:category];
        } failure:^(NSError *error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    }
}

#pragma mark - Cell Insertion

- (void)insertCellForCategory:(CategoryModel *)category {
    NSMutableArray *mutableCategories = [NSMutableArray arrayWithArray:self.categories];
    [mutableCategories addObject:category];
    
    _categories = mutableCategories.copy;
    
    [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.categories.count - 1 inSection:0]]];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, 200);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 50;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *categoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellReuseIdentifier forIndexPath:indexPath];
    categoryCell.categoryModel = [self.categories objectAtIndex:indexPath.row];
    return categoryCell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end

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

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCategoryService];
    [self setupCollectionView];
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
    
    for (NSString *path in self.categoryPathNames) {
        [self.categoriesService getCategory:path success:^(CategoryModel *category) {
            int i = 0;
        } failure:^(NSError *error) {
            int i = 0;
        }];
    }
}

- (void)setupCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CategoryCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:CategoryCellReuseIdentifier];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(100, 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 50;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 50;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryPathNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCollectionViewCell *categoryCell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryCellReuseIdentifier forIndexPath:indexPath];
    return categoryCell;
}

@end

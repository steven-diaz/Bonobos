//
//  ProductsViewController.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "ProductsViewController.h"

#import "ImageCacheService.h"

#import "CategoryModel.h"
#import "ProductModel.h"

#import "ProductCollectionViewCell.h"
#import "ProductCollectionViewFlowLayout.h"

#import "UIColor+Extended.h"

NSString * const ProductCollectionViewCellReuseIdentifier = @"ProductCollectionViewCell";

@interface ProductsViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) IBOutlet UIImageView *categoryImageView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *categoryImageViewHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *categoryDescriptionView;
@property (nonatomic, strong) IBOutlet UILabel *categoryNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryDescriptionLabel;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;
@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleNavigationBar];
    [self styleUI];
    [self setupCollectionView];
    [self populateUI];
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)styleNavigationBar {
    self.navigationItem.title = self.category.name.uppercaseString;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.collectionView.collectionViewLayout = [[ProductCollectionViewFlowLayout alloc] init];
}

- (void)styleUI {
    self.categoryDescriptionView.layer.borderWidth = 8;
    self.categoryDescriptionView.layer.borderColor = [UIColor bonobosLightGrey].CGColor;
    
    [self.collectionView setContentInset:UIEdgeInsetsZero];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void)setupCollectionView {
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:NULL];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ProductCollectionViewCellReuseIdentifier];
}

- (void)populateUI {
    self.categoryNameLabel.text = self.category.name.uppercaseString;
    self.categoryDescriptionLabel.text = self.category.categoryDescription;
    
    if (self.category.imageURL != nil) {
        __weak typeof (self) weakSelf = self;
        [[ImageCacheService instance] asyncImageForURL:self.category.imageURL completion:^(UIImage *image) {
            [weakSelf.categoryImageView setImage:image];
        }];
    } else {
        self.categoryImageViewHeightConstraint.constant = 0;
    }
}

- (void)setCategory:(CategoryModel *)category {
    _category = category;
    
    [self populateUI];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.category.products.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollectionViewCell *cell = (ProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ProductCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    cell.product = [self.category.products objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if(object == self.collectionView && [keyPath isEqualToString:@"contentSize"]) {
        self.collectionViewHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
    }
}

@end

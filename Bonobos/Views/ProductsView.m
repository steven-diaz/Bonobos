//
//  ProductsViewController.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "ProductsView.h"

#import "ImageCacheService.h"
#import "UIColor+Extended.h"

#import "CategoryModel.h"
#import "ProductModel.h"

#import "LoadingImageView.h"
#import "ProductCollectionViewCell.h"
#import "ProductCollectionViewFlowLayout.h"

#import "Masonry.h"

NSString * const ProductCollectionViewCellReuseIdentifier = @"ProductCollectionViewCell";
NSString * const ContentSizeKeyPath = @"contentSize";

@interface ProductsView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) IBOutlet UIView *productsView;
@property (nonatomic, strong) IBOutlet LoadingImageView *categoryImageView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *categoryImageViewHeightConstraint;
@property (nonatomic, strong) IBOutlet UIView *categoryDescriptionView;
@property (nonatomic, strong) IBOutlet UILabel *categoryNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoryDescriptionLabel;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@property (nonatomic, strong) CategoryModel *category;
@end

@implementation ProductsView

- (instancetype)initWithCategory:(CategoryModel *)category {
    self = [super init];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ProductsView class]) owner:self options:nil];
        [self addSubview:self.productsView];
        
        [self.productsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        _category = category;
        
        [self styleUI];
        [self setupCollectionView];
        [self populateUI];
    }
    return self;
}

- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:ContentSizeKeyPath];
}

- (void)styleUI {
    self.categoryDescriptionView.layer.borderWidth = 8;
    self.categoryDescriptionView.layer.borderColor = [UIColor bonobosLightGrey].CGColor;
    
    [self.collectionView setContentInset:UIEdgeInsetsZero];
}

- (void)setupCollectionView {
    self.collectionView.collectionViewLayout = [[ProductCollectionViewFlowLayout alloc] init];
    [self.collectionView addObserver:self forKeyPath:ContentSizeKeyPath options:NSKeyValueObservingOptionNew context:NULL];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ProductCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:ProductCollectionViewCellReuseIdentifier];
}

- (void)populateUI {
    self.categoryNameLabel.text = self.category.name.uppercaseString;
    
    if (self.category.categoryDescription == nil) {
        [self.categoryDescriptionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.categoryNameLabel).offset(30);
        }];
    } else {
        self.categoryDescriptionLabel.text = self.category.categoryDescription;
        [self.categoryDescriptionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.categoryDescriptionLabel).offset(30);
        }];
    }
    
    if (self.category.imageURL != nil) {
        [self.categoryImageView setImageURL:self.category.imageURL];
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
    if(object == self.collectionView && [keyPath isEqualToString:ContentSizeKeyPath]) {
        self.collectionViewHeightConstraint.constant = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.collectionView);
        }];
    }
}

@end

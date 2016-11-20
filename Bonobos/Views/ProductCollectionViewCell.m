//
//  ProductCollectionViewCell.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "ProductCollectionViewCell.h"

#import "ProductModel.h"

#import "LoadingImageView.h"

#import "ImageCacheService.h"

@interface ProductCollectionViewCell ()
@property (nonatomic, strong) IBOutlet LoadingImageView *productImage;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;
@end

@implementation ProductCollectionViewCell

- (void)setProduct:(ProductModel *)product {
    _product = product;
    
    [self.productImage setImage:nil];
    [self.productImage setImageURL:product.imageURL];
    
    self.nameLabel.text = product.name;
    self.descriptionLabel.text = product.productDescription;
    self.priceLabel.text = product.displayPrice;
}

@end

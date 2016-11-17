//
//  CategoryCollectionViewCell.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

#import "CategoryModel.h"

#import "ImageCacheService.h"

@interface CategoryCollectionViewCell()
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@end

@implementation CategoryCollectionViewCell

- (void)setCategoryModel:(CategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    self.nameLabel.text = categoryModel.name;
    self.descriptionLabel.text = categoryModel.categoryDescription;
    
    __weak typeof (self) weakSelf = self;
    [[ImageCacheService instance] imageForURL:categoryModel.imageURL completion:^(UIImage *image) {
        [weakSelf.backgroundImage setImage:image];
    }];
}

@end

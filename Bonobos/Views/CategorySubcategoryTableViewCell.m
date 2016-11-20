//
//  CategorySubcategoryTableViewCell.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategorySubcategoryTableViewCell.h"

#import "CategoryModel.h"

@interface CategorySubcategoryTableViewCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@end

@implementation CategorySubcategoryTableViewCell

- (void)setCategoryModel:(CategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    self.nameLabel.text = categoryModel.name.capitalizedString;
    self.accessibilityIdentifier = categoryModel.name.lowercaseString;
}

@end

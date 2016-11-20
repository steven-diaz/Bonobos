//
//  CategoryTableViewCell.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoryTableViewCell.h"

#import "LoadingImageView.h"

#import "CategoryModel.h"
#import "CategorySubcategoryTableViewCell.h"

#import "ImageCacheService.h"

NSInteger const CategoryCellImageHeight = 170;
NSInteger const CategoryCellSubCategoryCellHeight = 64;
NSInteger const CategoryCellFooterHeight = 14;

NSString * const CategorySubcategoryCellReuseIdentifier = @"CategorySubcategoryCellReuseIdentifier";

@interface CategoryTableViewCell () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet LoadingImageView *backgroundImage;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UITableView *subcategoryTableView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@end

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.subcategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategorySubcategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:CategorySubcategoryCellReuseIdentifier];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableViewHeightConstraint.constant = self.subcategoryTableView.contentSize.height;
}

- (void)setCategoryModel:(CategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    [self.subcategoryTableView reloadData];
    self.nameLabel.text = categoryModel.name;
    self.descriptionLabel.text = categoryModel.categoryDescription;
    
    [self.backgroundImage setImage:nil];
    [self.backgroundImage setImageURL:categoryModel.imageURL];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryModel.subCategories.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategorySubcategoryTableViewCell *subcategoryCell = [tableView dequeueReusableCellWithIdentifier:CategorySubcategoryCellReuseIdentifier forIndexPath:indexPath];
    subcategoryCell.categoryModel = [self.categoryModel.subCategories objectAtIndex:indexPath.row];
    return subcategoryCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryModel *category = [self.categoryModel.subCategories objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(categoryTableViewCell:didSelectCategory:)]) [self.delegate categoryTableViewCell:self didSelectCategory:category];
}

@end

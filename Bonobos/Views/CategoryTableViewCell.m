//
//  CategoryCollectionViewCell.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoryTableViewCell.h"

#import "CategoryModel.h"
#import "CategorySubcategoryTableViewCell.h"

#import "ImageCacheService.h"

NSString * const CategorySubcategoryCellReuseIdentifier = @"CategorySubcategoryCellReuseIdentifier";

@interface CategoryTableViewCell () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;
@property (nonatomic, strong) IBOutlet UITableView *subcategoryTableView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@end

@implementation CategoryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.backgroundImage setImage:nil];
    [self.subcategoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CategorySubcategoryTableViewCell class]) bundle:nil] forCellReuseIdentifier:CategorySubcategoryCellReuseIdentifier];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"%@%f", @"Setting height to ", self.subcategoryTableView.contentSize.height);
    self.tableViewHeightConstraint.constant = self.subcategoryTableView.contentSize.height;
}

- (void)setCategoryModel:(CategoryModel *)categoryModel {
    _categoryModel = categoryModel;
    
    [self.subcategoryTableView reloadData];
    self.nameLabel.text = categoryModel.name;
    self.descriptionLabel.text = categoryModel.categoryDescription;
    
    __weak typeof (self) weakSelf = self;
    [[ImageCacheService instance] asyncImageForURL:categoryModel.imageURL completion:^(UIImage *image) {
        [weakSelf.backgroundImage setImage:image];
    }];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

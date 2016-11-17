//
//  CategoryCollectionViewCell.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

#import "CategoryCellViewModel.h"

@interface CategoryCollectionViewCell()
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@end

@implementation CategoryCollectionViewCell

- (void)setCategoryCellViewModel:(CategoryCellViewModel *)categoryCellViewModel {
    _categoryCellViewModel = categoryCellViewModel;
    
    self.nameLabel.text = @"Something";
}

@end

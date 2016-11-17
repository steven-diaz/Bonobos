//
//  CategoryCollectionViewCell.h
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryCellViewModel;

@interface CategoryCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong, readonly) CategoryCellViewModel *categoryCellViewModel;

@end
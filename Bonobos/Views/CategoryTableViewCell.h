//
//  CategoryCollectionViewCell.h
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryModel;

@interface CategoryTableViewCell : UITableViewCell
@property (nonatomic, strong) CategoryModel *categoryModel;

@end

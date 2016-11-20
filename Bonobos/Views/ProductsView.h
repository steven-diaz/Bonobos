//
//  ProductsViewController.h
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryModel;

@interface ProductsView : UIView

- (instancetype)initWithCategory:(CategoryModel *)category;

@end

//
//  SubCategoryViewController.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "SubCategoryViewController.h"

#import "CategoryModel.h"

#import "ProductsView.h"

#import "Masonry.h"

@interface SubCategoryViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *productViews;
@end

@implementation SubCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self styleNavigationBar];
    [self populateUI];
}

- (void)styleNavigationBar {
    self.navigationItem.title = self.category.name.uppercaseString;
    
    self.navigationController.navigationBar.topItem.title = @"";
}

- (void)populateUI {
    self.productViews = [NSMutableArray new];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSArray *categoriesArray = self.category.subCategories.count > 0 ? self.category.subCategories : @[self.category];
    MASViewAttribute *lastMostConstraint = self.scrollView.mas_top;
    for (CategoryModel *subCategory in categoriesArray) {
        ProductsView * productsView = [[ProductsView alloc] initWithCategory:subCategory];
        [self.scrollView addSubview:productsView];
        [productsView layoutSubviews];
        
        [productsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastMostConstraint);
            make.left.right.equalTo(self.view);
        }];
        lastMostConstraint = productsView.mas_bottom;
        [self.productViews addObject:productsView];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    ProductsView *lastView = [self.productViews lastObject];
    [self.scrollView setContentSize:CGSizeMake(0, lastView.frame.origin.y + lastView.frame.size.height)];
}

@end

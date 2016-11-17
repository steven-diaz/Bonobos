//
//  CategoryModel.h
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductModel;

@interface CategoryModel : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *categoryDescription;
@property (nonatomic, strong, readonly) NSURL *imageURL;
@property (nonatomic, strong, readonly) NSArray <CategoryModel *> *subCategories;
@property (nonatomic, strong, readonly) NSArray <ProductModel *> *products;

+ (instancetype)objectFromJSON:(NSDictionary *)json;

@end

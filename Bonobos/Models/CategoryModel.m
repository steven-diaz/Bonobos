//
//  CategoryModel.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoryModel.h"

#import "ProductModel.h"

#import "NSDictionary+SafeExtract.h"

@implementation CategoryModel

+ (instancetype)objectFromJSON:(NSDictionary *)json {
    if (![json isKindOfClass:[NSDictionary class]]) return  nil;
    
    NSString *name = [json safeStringForKey:@"name"];
    NSString *description = [json safeStringForKey:@"meta_title"];
    
    NSDictionary *imageDIct = [json safeObjectForKey:@"primary_image"];
    if (imageDIct == nil) imageDIct = [json safeObjectForKey:@"secondary_image"];
    NSURL *imageURL = nil;
    if (imageDIct != nil) imageURL = [NSURL URLWithString:[imageDIct safeObjectForKey:@"large_url"]];
    
    NSMutableArray *subCategories = [NSMutableArray new];
    NSArray *childrenDict = [json safeObjectForKey:@"children"];
    for (NSDictionary *child in childrenDict) {
        CategoryModel *subcategory = [CategoryModel objectFromJSON:child];
        if (subcategory != nil) [subCategories addObject:subcategory];
    }
    
    NSMutableArray *products = [NSMutableArray new];
    NSArray *productsDict = [json safeObjectForKey:@"category_items"];
    for (NSDictionary *productDict in productsDict) {
        ProductModel *product = [ProductModel objectFromJSON:productDict];
        if (product != nil) [products addObject:product];
    }
    
    if (subCategories.count == 0 && products.count == 0) return nil;
    
    return [[CategoryModel alloc] initWithName:name description:description imageURL:imageURL subCategories:subCategories products:products];
}

- (instancetype)initWithName:(NSString *)name description:(NSString *)description imageURL:(NSURL *)imageURL subCategories:(NSArray <CategoryModel *> *)subCategories products:(NSArray <ProductModel *> *)products {
    self = [super init];
    if (self) {
        _name = name;
        _categoryDescription = description;
        _imageURL = imageURL;
        _subCategories = subCategories;
        _products = products;
    }
    return self;
}

@end

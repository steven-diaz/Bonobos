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
    
    NSString *name = [json objectForKey:@"name"];
    NSString *description = [json objectForKey:@"meta_title"];
    
    NSDictionary *imageDIct = [json safeObjectForKey:@"primary_image"];
    NSURL *imageURL = nil;
    if (imageDIct != nil) imageURL = [NSURL URLWithString:[imageDIct objectForKey:@"large_url"]];
    
    NSMutableArray *subCategories = [NSMutableArray new];
    NSArray *childrenDict = [json objectForKey:@"children"];
    for (NSDictionary *child in childrenDict) {
        CategoryModel *subcategory = [CategoryModel objectFromJSON:child];
        if (subcategory != nil) [subCategories addObject:subcategory];
    }
    
    return [[CategoryModel alloc] initWithName:name description:description imageURL:imageURL subCategories:subCategories];
}

- (instancetype)initWithName:(NSString *)name description:(NSString *)description imageURL:(NSURL *)imageURL subCategories:(NSArray <CategoryModel *> *)subCategories {
    self = [super init];
    if (self) {
        _name = name;
        _categoryDescription = description;
        _imageURL = imageURL;
        _subCategories = subCategories;
    }
    return self;
}

@end

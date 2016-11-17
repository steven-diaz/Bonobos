//
//  ProductModel.m
//  Bonobos
//
//  Created by Steven Diaz on 11/17/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "ProductModel.h"

#import "NSDictionary+SafeExtract.h"

@implementation ProductModel

+ (instancetype)objectFromJSON:(NSDictionary *)json {
    if (![json isKindOfClass:[NSDictionary class]]) return  nil;
    
    NSString *name = [json safeStringForKey:@"name"];
    NSString *displayPrice = [json safeStringForKey:@"display_price"];
    
    NSString *description;
    NSDictionary *descriptionDict = [[json safeObjectForKey:@"flat_preselected_options"] firstObject];
    if (descriptionDict != nil) {
        description = [descriptionDict safeStringForKey:@"option_value_presentation"];
    }
    
    NSDictionary *imageDIct = [json safeObjectForKey:@"primary_image"];
    NSURL *imageURL = nil;
    if (imageDIct != nil) imageURL = [NSURL URLWithString:[imageDIct objectForKey:@"large_url"]];
    
    return [[ProductModel alloc] initWithName:name description:description displayPrice:displayPrice imageURL:imageURL];
}

- (instancetype)initWithName:(NSString *)name description:(NSString *)description displayPrice:(NSString *)displayPrice imageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _name = name;
        _productDescription = description;
        _displayPrice = displayPrice;
        _imageURL = imageURL;
    }
    return self;
}

@end

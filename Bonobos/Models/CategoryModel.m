//
//  CategoryModel.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (instancetype)objectFromJSON:(NSDictionary *)json {
    if (![json isKindOfClass:[NSDictionary class]]) return  nil;
    
    NSString *name = [json objectForKey:@"name"];
    NSString *description = [json objectForKey:@"meta_title"];
    NSDictionary *imageDIct = [json objectForKey:@"primary_image"];
    NSURL *imageURL = nil;
    
    if (imageDIct != nil) imageURL = [NSURL URLWithString:[imageDIct objectForKey:@"large_url"]];
    
    return [[CategoryModel alloc] initWithName:name description:description imageURL:imageURL];
}

- (instancetype)initWithName:(NSString *)name description:(NSString *)description imageURL:(NSURL *)imageURL {
    self = [super init];
    if (self) {
        _name = name;
        _categoryDescription = description;
        _imageURL = imageURL;
    }
    return self;
}

@end

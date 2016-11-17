//
//  CategoriesService.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "CategoriesService.h"

#import "AFNetworking.h"

#import "CategoryModel.h"

NSString * const CategoryAPIPath = @"https://api.bonobos.com/api/categories/";

@implementation CategoriesService

- (void)getCategory:(NSString *)categoryName
            success:(void (^)(CategoryModel *))success
            failure:(FailureBlock)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *path = [NSString stringWithFormat:@"%@%@", CategoryAPIPath, categoryName];
    
    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        if (success != nil) success([CategoryModel objectFromJSON:responseObject]);
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        if (failure != nil) failure(error);
    }];
}

@end

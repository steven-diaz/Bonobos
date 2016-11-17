//
//  CategoriesService.h
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FailureBlock) (NSError *error);

@class CategoryModel;

@interface CategoriesService : NSObject

- (void)getCategory:(NSString *)categoryName
            success:(void (^)(CategoryModel *category))success
            failure:(FailureBlock)failure;

@end

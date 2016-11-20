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

/**
 *  Attempts a GET request for a category with the supplied name.
 *
 *  @param categoryName The category name to request. Gets appended to the Category API Path.
 *
 *  @param success A block that gets called on success alongside the deserialized CategoryModel and the NSURLSessionTask associated with the request.
 *
 *  @param failure A block that gets called when the request fails alongside an NSError.
 *
 *  @return The NSURLSessionTask associated with the request.
 */
- (NSURLSessionTask *)getCategory:(NSString *)categoryName
                          success:(void (^)(CategoryModel *category, NSURLSessionTask *task))success
                          failure:(FailureBlock)failure;

@end

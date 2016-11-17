//
//  ImageCacheService.h
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCacheService : NSObject

+ (instancetype)instance;
- (void)imageForURL:(NSURL *)url
         completion:(void (^)(UIImage *image))completion;

@end

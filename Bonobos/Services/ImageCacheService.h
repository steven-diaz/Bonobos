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

- (UIImage *)imageForURL:(NSURL *)url;

- (void)addImage:(UIImage *)image forURL:(NSURL *)url;

- (void)asyncImageForURL:(NSURL *)url
         completion:(void (^)(UIImage *image))completion;

@end

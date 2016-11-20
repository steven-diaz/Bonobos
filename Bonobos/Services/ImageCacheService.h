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

/**
 *  Retrieves the shared instance.
 */
+ (instancetype)instance;

/**
 *  Attemps to return an image stored in cache associated with a url.
 *
 *  @param url The url used to locate the image in cache.
 *
 *  @return The image if found within cache. Nil if not found.
 */
- (UIImage *)imageForURL:(NSURL *)url;

/**
 *  Adds an image to the cache associated with a url.
 *
 *  @param image The image to add to the cache.
 *
 *  @param url The url associated with the image.
 */
- (void)addImage:(UIImage *)image forURL:(NSURL *)url;

/**
 *  Downloads an image from url asynchronously in a background thread and then adds it to the cache.
 *
 *  @param url The url to download the image from.
 *
 *  @param completion A block that gets called on the main thread when the image is downloading and converted into a UIImage.
 */
- (void)asyncImageForURL:(NSURL *)url
              completion:(void (^)(UIImage *image))completion;

@end

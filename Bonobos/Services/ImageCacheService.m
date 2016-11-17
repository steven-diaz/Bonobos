//
//  ImageCacheService.m
//  Bonobos
//
//  Created by Steven Diaz on 11/16/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "ImageCacheService.h"

@interface ImageCacheService()
@property (nonatomic, strong, readonly) NSMutableDictionary *imageCache;
@end

@implementation ImageCacheService

+ (instancetype)instance {
    static ImageCacheService *imageCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[ImageCacheService alloc] init];
    });
    
    return imageCache;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageCache = [NSMutableDictionary new];
    }
    return self;
}

- (void)imageForURL:(NSURL *)url
         completion:(void (^)(UIImage *image))completion {
    UIImage *cachedImage = [self.imageCache objectForKey:url.absoluteString];
    if (cachedImage != nil && completion != nil) {
        completion(cachedImage);
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *downloadedImage = [UIImage imageWithData:imageData];
        [self.imageCache setObject:downloadedImage forKey:url.absoluteString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) completion(downloadedImage);
        });
    });
}

@end

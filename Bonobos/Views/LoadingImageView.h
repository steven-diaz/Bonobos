//
//  LoadingImageView.h
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingImageView : UIView

/**
 *  Sets the imageView with an image without loading.
 *
 *  @param image The image to set
 */
- (void)setImage:(UIImage *)image;

/**
 *  Sets the imageView with an image from url. Performed asynchronously with the ImageCache.
 *
 *  @param url The url to download an image from.
 */
- (void)setImageURL:(NSURL *)url;

@end

//
//  LoadingImageView.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "LoadingImageView.h"

#import "ImageCacheService.h"

#import "UIColor+Extended.h"

#import "Masonry.h"
#import "LLARingSpinnerView.h"

@interface LoadingImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) LLARingSpinnerView *spinner;

@end

@implementation LoadingImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor bonobosLightGrey];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.alpha = 0;
    [self addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.spinner = [[LLARingSpinnerView alloc] init];
    self.spinner.alpha = 0;
    self.spinner.tintColor = [UIColor colorWithWhite:0.9 alpha:0.5];
    [self addSubview:self.spinner];
    
    [self.spinner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@40);
        make.center.equalTo(self);
    }];
}

- (void)setImage:(UIImage *)image {
    if (image != nil) {
        self.imageView.alpha = 1;
        self.spinner.alpha = 0;
    }
    [self.imageView setImage:image];
}

- (void)setImageURL:(NSURL *)url {
    if (url == nil) return;
    
    self.spinner.alpha = 1;
    [self.spinner startAnimating];
    if (url != nil) {
        __weak typeof (self) weakSelf = self;
        [[ImageCacheService instance] asyncImageForURL:url completion:^(UIImage *image) {
            [weakSelf handleImageLoadingSuccessWithImage:image];
        }];
    }
}

- (void)handleImageLoadingSuccessWithImage:(UIImage *)image {
    if (image != nil) [self.imageView setImage:image];
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.alpha = 1;
        self.spinner.alpha = 0;
    }];
}

@end

//
//  LoadingView.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "LoadingView.h"

#import "Masonry.h"
#import "LLARingSpinnerView.h"

#import "UIColor+Extended.h"

@interface LoadingView ()
@property (nonatomic, strong) IBOutlet UIView *loadingView;
@property (nonatomic, strong) IBOutlet LLARingSpinnerView *spinnerView;
@end

@implementation LoadingView

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LoadingView class]) owner:self options:nil];
        [self addSubview:self.loadingView];
        
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.spinnerView.tintColor = [UIColor bonobosBlue];
        [self.spinnerView startAnimating];
    }
    return self;
}

@end

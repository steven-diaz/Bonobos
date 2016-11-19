//
//  UIColor+Extended.m
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import "UIColor+Extended.h"

@implementation UIColor(Extended)

+ (UIColor *)colorFromHEXCode:(int)hexCode {
    return [UIColor colorWithRed:((float)((hexCode & 0xFF0000) >> 16))/255.0 green:((float)((hexCode & 0xFF00) >> 8))/255.0 blue:((float)(hexCode & 0xFF))/255.0 alpha:1.0];
}

+ (UIColor *)colorFromHEXCode:(int)hexCode withAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexCode & 0xFF0000) >> 16))/255.0 green:((float)((hexCode & 0xFF00) >> 8))/255.0 blue:((float)(hexCode & 0xFF))/255.0 alpha:alpha];
}

+ (UIColor *)bonobosBlack {
    return [UIColor colorFromHEXCode:0x232323];
}

+ (UIColor *)bonobosLightGrey {
    return [UIColor colorFromHEXCode:0xF4F4F4];
}

+ (UIColor *)bonobosDarkGrey {
    return [UIColor colorFromHEXCode:0x4C4C4C];
}

+ (UIColor *)bonobosBlue {
    return [UIColor colorFromHEXCode:0x007FA2];
}

+ (UIColor *)bonobosRed {
    return [UIColor colorFromHEXCode:0xFC4618];
}

@end

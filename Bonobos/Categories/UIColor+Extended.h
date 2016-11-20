//
//  UIColor+Extended.h
//  Bonobos
//
//  Created by Steven Diaz on 11/19/16.
//  Copyright © 2016 Steven Diaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor(Extended)

/**
 *  Color from hexadecimal code i.e. 0x1a1a1a
 *
 *  @param hexCode The hex code to translate into a UIColor
 *
 *  @return The UIColor representative of the hex code
 */
+ (UIColor *)colorFromHEXCode:(int)hexCode;

/**
 *  Color from hexadecimal code with alpha component
 *
 *  @param hexCode The hex code to translate into a UIColor
 *
 *  @param alpha The alpha value to apply to the hex color
 *
 *  @return The UIColor representative of the hex code with alpha channel
 */
+ (UIColor *)colorFromHEXCode:(int)hexCode withAlpha:(CGFloat)alpha;

// Bonobos Color Palette
+ (UIColor *)bonobosBlack;
+ (UIColor *)bonobosLightGrey;
+ (UIColor *)bonobosDarkGrey;
+ (UIColor *)bonobosBlue;
+ (UIColor *)bonobosRed;

@end

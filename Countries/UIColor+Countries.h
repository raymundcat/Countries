//
//  UIColor+Countries.h
//  Countries
//
//  Created by John Raymund Catahay on 22/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Countries)

+ (UIColor *)colorWithFractionedRed: (CGFloat)red green: (CGFloat)green blue: (CGFloat)blue;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIColor *)peachColor;
+ (UIColor *)lemonColor;
+ (UIColor *)yelloOrangeColor;
+ (UIColor *)blueGreenColor;
+ (UIColor *)darkBlueGreenColor;
+ (UIColor *)lightBlueGreenColor;
+ (UIColor *)skyBlueColor;

+ (CAGradientLayer *)gradientWithColors: (NSArray *)colors forRect: (CGRect)rect;

@end

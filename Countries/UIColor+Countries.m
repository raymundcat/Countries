//
//  UIColor+Countries.m
//  Countries
//
//  Created by John Raymund Catahay on 22/05/2017.
//  Copyright © 2017 John Raymund Catahay. All rights reserved.
//

#import "UIColor+Countries.h"

@implementation UIColor (Countries)

+ (UIColor *)colorWithFractionedRed: (CGFloat)red green: (CGFloat)green blue: (CGFloat)blue{
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];}

+ (UIColor *)peachColor {
    return [UIColor colorWithFractionedRed:178.0f green:107.0f blue:157.0f];
}

@end

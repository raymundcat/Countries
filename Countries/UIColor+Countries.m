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

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)peachColor {
    return [UIColor colorWithFractionedRed:178.0f green:107.0f blue:157.0f];
}

+ (UIColor *)lemonColor {
    return [UIColor colorFromHexString:@"FFEA54"];
}

+ (UIColor *)yelloOrangeColor {
    return [UIColor colorFromHexString:@"FFD31F"];
}

+ (UIColor *)blueGreenColor {
    return [UIColor colorFromHexString:@"62D2A7"];
}

+ (UIColor *)lightBlueGreenColor {
    return [UIColor colorFromHexString:@"93DD98"];
}

+ (UIColor *)darkBlueGreenColor {
    return [UIColor colorFromHexString:@"65A899"];
}

+ (UIColor *)skyBlueColor {
    return [UIColor colorFromHexString:@"4697E4"];
}

@end

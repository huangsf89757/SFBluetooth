//
//  UIColor+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UIColor+SFExtension.h"

@implementation UIColor (SFExtension)
+ (UIColor *)sf_colorFromHex:(NSInteger)hex
{
    
    return [self sf_colorFromHex:hex alpha:1.0f];
}

+ (UIColor *)sf_colorFromHex:(NSInteger)hex alpha:(CGFloat)alpha
{
    
    return [self sf_colorWithRed:((hex & 0xFF0000) >> 16) green:((hex & 0xFF00) >> 8) blue:(hex & 0xFF) alpha:alpha];
}


+ (UIColor *)sf_randomColor
{
    return [self sf_colorWithRed:arc4random_uniform(256) green:arc4random_uniform(256) blue:arc4random_uniform(256) alpha:1];
}



+ (UIColor *)sf_colorWithHexString:(NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [self sf_colorWithRed:r green:g blue:b alpha:1];
}

+ (UIColor *)sf_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}
@end

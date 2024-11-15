//
//  UIColor+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>

// 颜色
#define SFRGBColor(r, g, b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define SFRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
#define SFRandomColor  SFRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)
#define SFWhiteColor [UIColor whiteColor]
#define SFBlackColor [UIColor blackColor]
#define SFRedColor [UIColor redColor]
#define SFClearColor [UIColor clearColor]
// 十六进制颜色
#define SFHexColor(color) [UIColor sf_colorFromHex:color]
#define SFHexColorWithAlpha(color,a) [UIColor sf_colorFromHex:(color) alpha:(a)]

@interface UIColor (SFExtension)
/**
 *  十六进制转颜色
 *
 *  @param hex 进制
 *
 *  @return RGB颜色
 */
+ (UIColor *)sf_colorFromHex:(NSInteger)hex;
/**
 *  十六进制转颜色
 *
 *  @param hex   十六进制数字
 *  @param alpha 透明度
 *
 *  @return RGB颜色
 */
+ (UIColor *)sf_colorFromHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor *)sf_colorWithHexString:(NSString *)color;

/**
 生成随机色
 
 @return 随机色
 */
+ (UIColor *)sf_randomColor;

/**
 使用 R / G / B 数值创建颜色
 
 @param red red
 @param green green
 @param blue blue
 @return 颜色
 */
+ (UIColor *)sf_colorWithRed:(uint8_t)red green:(uint8_t)green blue:(uint8_t)blue alpha:(CGFloat)alpha;
@end

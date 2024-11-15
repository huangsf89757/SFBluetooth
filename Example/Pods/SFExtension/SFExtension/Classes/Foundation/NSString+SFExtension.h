//
//  NSString+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SFExtension)

/**
 是否是手机号

 @return 是否是手机号
 */
- (BOOL)isPhoneNumber;
/**
 *  获取Documents文件夹全路径
 *
 *  @return Documents全路径
 */
- (NSString *)sf_docDir;
/**
 *  获取Caches文件夹全路径
 *
 *  @return Caches全路径
 */
- (NSString *)sf_cachesDir;
/**
 *  获取tmp文件夹全路径
 *
 *  @return tmp全路径
 */
- (NSString *)sf_tempDir;
/**
 *  截取指定范围内的字符串
 *
 *  @param startString 起始位置
 *  @param endString   结束位置
 *
 */
- (NSString *)sf_rangeFromString:(NSString *)startString toString:(NSString *)endString;
/**
 根据字体计算文本尺寸
 
 @param font 文本字体
 @param maxWidth 最大宽度
 @return 文本尺寸
 */
- (CGSize)sf_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;

/**
 根据字体计算文字尺寸
 
 @param font 字体
 
 @return 文字尺寸
 */
- (CGSize)sf_sizeWithFont:(UIFont *)font;
/**
 计算文字高度
 
 @param font        文本所使用的字体
 @param lineSpacing 行间距
 @param maxWidth    最大宽度
 
 @return 文本所占用的高度
 */
- (CGFloat)sf_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat) lineSpacing maxWidth:(CGFloat)maxWidth;
/**
 *  清除字符串小数点末尾的0
 *
 *  @return 新的字符串
 */
- (NSString *)sf_cleanDecimalPointAndZero;
/**
 *  根据一个字符串返回一个带有中划线的富文本
 *
 */
- (NSMutableAttributedString *)sf_getMiddleLineAttriString;
/*!
 *  @author ChrisCai, 16-09-06
 *
 *  @brief 中文转拼音
 *
 *  @param chinese 中文字符串
 *
 *  @return 拼音
 */
+ (NSString *)sf_transform:(NSString *)chinese;
/**
 *  获取MIMEType
 *
 *  @param path 文件路径
 *
 *  @return MIMEType
 */
+ (NSString *)sf_mimeTypeForFileAtPath:(NSString *)path;
#if TARGET_OS_IPHONE
- (CGSize)drawInRect:(CGRect)inRect withFont:(UIFont *)inFont color:(UIColor *)inColor shadowColor:(UIColor *)inShadowColor shadowOffset:(CGSize)inShadowOffset;
- (CGSize)drawInRect:(CGRect)inRect withFont:(UIFont *)inFont lineBreakMode:(NSLineBreakMode)inLineBreakMode color:(UIColor *)inColor shadowColor:(UIColor *)inShadowColor shadowOffset:(CGSize)inShadowOffset;
- (CGSize)drawInRect:(CGRect)inRect withFont:(UIFont *)inFont lineBreakMode:(NSLineBreakMode)inLineBreakMode alignment:(NSTextAlignment)alignment color:(UIColor *)inColor shadowColor:(UIColor *)inShadowColor shadowOffset:(CGSize)inShadowOffset;
#endif
@end

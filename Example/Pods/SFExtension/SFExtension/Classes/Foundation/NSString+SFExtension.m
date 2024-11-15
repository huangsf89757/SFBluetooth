//
//  NSString+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "NSString+SFExtension.h"
#import <MobileCoreServices/MobileCoreServices.h>
@implementation NSString (SFExtension)
#pragma mark -
#pragma mark - ===== 正则 =====
- (BOOL)isPhoneNumber
{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}
#pragma mark -
#pragma mark - 沙盒路径相关

- (NSString *)sf_docDir
{
    NSString *newStr = [self lastPathComponent];
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *docFile = [docPath stringByAppendingPathComponent:newStr];
    return docFile;
}

- (NSString *)sf_cachesDir
{
    NSString *newStr = [self lastPathComponent];
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *cachesFile = [cachesPath stringByAppendingPathComponent:newStr];
    
    return cachesFile;
    
}

- (NSString *)sf_tempDir
{
    NSString *newStr = [self lastPathComponent];
    
    NSString *tepPath = NSTemporaryDirectory();
    
    NSString *tepFile = [tepPath stringByAppendingPathComponent:newStr];
    
    return tepFile;
}
#pragma mark -
#pragma mark - ===== 字符截取 =====
- (NSString *)sf_rangeFromString:(NSString *)startString toString:(NSString *)endString
{
    NSRange range = [self rangeOfString:startString];
    NSString *string;
    if (range.location != NSNotFound)
    {
        string = [self substringFromIndex:range.location + range.length];
    }
    
    range = [string rangeOfString:endString];
    if (range.location != NSNotFound)
    {
        string = [string substringToIndex:range.location];
    }
    return  string;
}

#pragma mark -
#pragma mark - ===== 字符尺寸计算 =====
- (CGSize)sf_sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return bounds.size;
}

- (CGSize)sf_sizeWithFont:(UIFont *)font
{
    CGSize size = CGSizeZero;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
    {
        NSDictionary *attributes = @{NSFontAttributeName : font};
#ifdef __IPHONE_7_0
        size = [self sizeWithAttributes:attributes];
        size.width = ceilf(size.width);
        size.height = ceilf(size.height);
#endif
    }
    else
    {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font];
#pragma GCC diagnostic pop
    }
    
    return size;
}

- (CGFloat)sf_sizeWithFont:(UIFont *)font lineSpacing:(CGFloat) lineSpacing maxWidth:(CGFloat)maxWidth
{
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = lineSpacing;
    
    CGRect bounds = [self boundingRectWithSize:CGSizeMake(maxWidth, 0)
                                       options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:font ,NSParagraphStyleAttributeName:paragraph}
                                       context:nil];
    return ceilf(bounds.size.height);
}

#pragma mark -
#pragma mark - ===== 其他 =====

- (NSString *)sf_cleanDecimalPointAndZero
{
    
    if ([self containsString:@"."])
    {
        NSArray<NSString *> * arr = [self componentsSeparatedByString:@"."];
        NSString * last = [arr.lastObject cleanDecimalPointAndZero];
        if (![last isEqualToString:@"0"])
        {
            return [NSString stringWithFormat:@"%@.%@",arr.firstObject,last];
        }
        else
        {
            return [NSString stringWithFormat:@"%@",arr.firstObject];
        }
    }
    else
    {
        return self;
    }
}
- (NSString *)cleanDecimalPointAndZero
{
    
    NSString *c = nil;
    NSInteger offset = self.length - 1;
    while (offset > 0)
    {
        c =[[self substringWithRange:NSMakeRange(offset, 1)] mutableCopy];
        if ([c isEqualToString:@"0"]|| [c isEqualToString:@"."])
        {
            offset--;
        }
        else
        {
            break;
        }
    }
    return [self substringToIndex:offset + 1];
}

- (NSMutableAttributedString *)sf_getMiddleLineAttriString
{
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc]initWithString:self attributes:attribtDic];
    return attriStr;
}

+ (NSString *)sf_transform:(NSString *)chinese
{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //返回最近结果
    return pinyin;
}

+ (NSString *)sf_mimeTypeForFileAtPath:(NSString *)path
{
    
    if (![[[NSFileManager alloc] init] fileExistsAtPath:path])
    {
        return nil;
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType)
    {
        return @"application/octet-stream";
    }
    NSString * type = (__bridge NSString *)(MIMEType);
    CFRelease(MIMEType);
    return type;
}


- (CGSize)drawInRect:(CGRect)inRect withFont:(UIFont *)inFont color:(UIColor *)inColor shadowColor:(UIColor *)inShadowColor shadowOffset:(CGSize)inShadowOffset;
{
    
    return [self drawInRect:inRect withFont:inFont lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft color:inColor shadowColor:inShadowColor shadowOffset:inShadowOffset];
}

- (CGSize)drawInRect:(CGRect)inRect withFont:(UIFont *)inFont lineBreakMode:(NSLineBreakMode)inLineBreakMode color:(UIColor *)inColor shadowColor:(UIColor *)inShadowColor shadowOffset:(CGSize)inShadowOffset;
{
    return [self drawInRect:inRect withFont:inFont lineBreakMode:inLineBreakMode alignment:NSTextAlignmentLeft color:inColor shadowColor:inShadowColor shadowOffset:inShadowOffset];
}

- (CGSize)drawInRect:(CGRect)inRect withFont:(UIFont *)inFont lineBreakMode:(NSLineBreakMode)inLineBreakMode alignment:(NSTextAlignment)alignment color:(UIColor *)inColor shadowColor:(UIColor *)inShadowColor shadowOffset:(CGSize)inShadowOffset;
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, inShadowOffset, 0.0, inShadowColor.CGColor);
    CGContextSetFillColorWithColor(context, inColor.CGColor);
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    CGSize renderedSize = [self drawInRect:inRect withFont:inFont lineBreakMode:inLineBreakMode];
#pragma GCC diagnostic pop
    CGContextRestoreGState(context);
    
    return renderedSize;
}

@end

//
//  SFMacro.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <Foundation/Foundation.h>

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//真机
#endif

#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

#pragma mark -
#pragma mark - ===== 判断对象是否为空 =====

// 判断对象是否为空
#define SFIsEmptyObject(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// 判断字符串是否为空
#define SFIsEmptyString(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
// 判断数组是否为空
#define SFIsEmptyArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
// 判断字典是否为空
#define SFIsEmptyDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)


#pragma mark -
#pragma mark - ===== 屏幕尺寸 =====
// 获取屏幕宽度与高度
#define SFSCREEN_WIDTH \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.width)

#define SFSCREEN_HEIGHT \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? [UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale : [UIScreen mainScreen].bounds.size.height)

#define SFSCREEN_SIZE \
([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)] ? CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale) : [UIScreen mainScreen].bounds.size)

// 系统版本号
#define SFSYSTEM_VERSION [[UIDevice currentDevice] systemVersion]
// 获取当前语言
#define SFCURRENT_LANGUAGR ([[NSLocale preferredLanguages] objectAtIndex:0])
// 判断是否为iPhone
#define SF_IS_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 判断是否为iPad
#define SF_IS_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#pragma mark -
#pragma mark - =====  输出打印， =====
// 开发的时候打印，但是发布的时候不打印的NSLog
#ifdef DEBUG
#define SFLog(fmt,...) NSLog((@"%s 第%d行" fmt),__func__,__LINE__,##__VA_ARGS__)
#else
#define SFLog(fmt,...)
#endif



// 弱引用/强引用
#define SFWeakSelf(type)   __weak typeof(type) weak##type = type;
#define SFStrongSelf(type) __strong typeof(type) type = weak##type;
// 由角度转换弧度
#define SFDegreesToRadian(x) (M_PI * (x) / 180.0)
// 由弧度转换角度
#define SFRadianToDegrees(radian) (radian * 180.0) / (M_PI)

// 获取宽度比例
#define SFWidthRatio  (SFSCREEN_WIDTH / 375.0)
// 获取高度比例
#define SFHeightRatio (SFSCREEN_HEIGHT / 667.0)

// 根据2x/ 3x 计算宽高
// #define SFScreenRatio SFScreenWidth == 414) ? 1 : (375 / 414.0))
// 适配宽度
#define SFWIDTH(width)  (ceilf((width) * SFWidthRatio))
// 适配高度
#define SFHEIGHT(height) (ceilf((height) * SFHeightRatio))


// 平方常规
#define CHINESE_PingFangRegular(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Regular" size:(a)];\
font? font: [UIFont systemFontOfSize:(a)];\
})

#define SFFontRegularFont(size) CHINESE_PingFangRegular(SFWIDTH(size))
// 平方中粗
#define CHINESE_PingFangMedium(a) ({\
UIFont * font = [UIFont fontWithName:@"PingFangSC-Medium" size:(a)];\
font? font: [UIFont boldSystemFontOfSize:(a)];\
})

#define SFFontMedium(size) CHINESE_PingFangMedium(SFWIDTH(size))












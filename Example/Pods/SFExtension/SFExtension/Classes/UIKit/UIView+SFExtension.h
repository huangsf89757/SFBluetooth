//
//  UIView+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SFExtension)
/// 获取一个view的控制器
- (UIViewController*)sf_viewController;
/// 寻找1像素的线(可以用来隐藏导航栏下面的黑线）
- (UIImageView *)sf_findHairlineImageViewUnder;
/// 添加顶部分割线
- (UIView*)sf_addTopLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha;
/// 添加底部分割线
- (UIView*)sf_addBottomLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha;
// 添加下划线
- (void)sf_addLine:(UIColor *)color inRect:(CGRect)rect;
/// 从XIB加载控件
+ (instancetype)sf_loadFromXib;
/**
 *  局部圆角半径
 *
 *  @param cornerRadius 圆角半径大小
 *  @param corner       圆角半径位置
 */
- (void)sf_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)corner;
@end

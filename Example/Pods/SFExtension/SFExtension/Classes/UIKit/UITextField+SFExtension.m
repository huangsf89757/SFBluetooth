//
//  UITextField+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UITextField+SFExtension.h"

@implementation UITextField (SFExtension)
static NSString * const SFPlaceholderColorKey = @"placeholderLabel.textColor";

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    // 系统的控件都是懒加载的
    // 提前设置占位文字, 目的 : 让它提前创建placeholderLabel
    NSString *oldPlaceholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = oldPlaceholder;
    // 恢复到默认的占位文字颜色
    if (placeholderColor == nil) {
        placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:placeholderColor forKeyPath:SFPlaceholderColorKey];
}


- (UIColor *)placeholderColor
{
    return [self valueForKeyPath:SFPlaceholderColorKey];
}

@end

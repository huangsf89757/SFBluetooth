//
//  UIView+SFGesture.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UIView+SFGesture.h"
#import <objc/runtime.h>
static char kSFActionHandlerTapBlockKey;
static char kSFActionHandlerLongPressBlockKey;
@implementation UIView (SFGesture)
- (void)sf_setTapActionWithBlock:(SFCommonBlock)block
{
    // 开启用户交互
    self.userInteractionEnabled = YES;
    // 创建手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAction:)];
    // 添加手势
    [self addGestureRecognizer:tap];
    // 保存回调
    objc_setAssociatedObject(self, &kSFActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)_tapAction:(UITapGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kSFActionHandlerTapBlockKey);
        
        if (action)
        {
            action();
        }
    }
}

- (void)sf_setLongPressActionWithBlock:(SFCommonBlock)block
{
    // 创建手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(_LongPressAction:)];
    // 添加手势
    [self addGestureRecognizer:longPress];
    // 保存回调
    objc_setAssociatedObject(self, &kSFActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)_LongPressAction:(UITapGestureRecognizer *)gesture
{
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        void(^action)(void) = objc_getAssociatedObject(self, &kSFActionHandlerLongPressBlockKey);
        
        if (action)
        {
            action();
        }
    }
}
@end

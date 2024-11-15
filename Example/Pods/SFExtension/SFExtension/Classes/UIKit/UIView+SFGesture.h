//
//  UIView+SFGesture.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFCommon.h"


@interface UIView (SFGesture)
/**
 *  给view添加单击手势
 *
 *  @param block 单击手势执行的block
 */
- (void)sf_setTapActionWithBlock:(SFCommonBlock)block;

/**
 *  给view添加长按手势
 *
 *  @param block 长按手势执行的block
 */
- (void)sf_setLongPressActionWithBlock:(SFCommonBlock)block;
@end

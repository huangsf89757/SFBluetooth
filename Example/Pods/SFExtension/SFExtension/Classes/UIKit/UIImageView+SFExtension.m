//
//  UIImageView+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UIImageView+SFExtension.h"

@implementation UIImageView (SFExtension)
// 播放GIF
- (void)sf_playGifAnim:(NSArray *)images
{
    if (!images.count)
    {
        return;
    }
    //动画图片数组
    self.animationImages = images;
    //执行一次完整动画所需的时长
    self.animationDuration = 0.5;
    //动画重复次数, 设置成0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}
// 停止动画
- (void)sf_stopGifAnim
{
    if (self.isAnimating)
    {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}
@end

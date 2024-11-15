//
//  UIImageView+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SFExtension)
// 播放GIF
- (void)sf_playGifAnim:(NSArray *)images;
// 停止动画
- (void)sf_stopGifAnim;
@end

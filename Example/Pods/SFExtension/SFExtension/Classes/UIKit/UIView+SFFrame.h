//
//  UIView+SFFrame.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SFFrame)
@property CGFloat sf_width;
@property CGFloat sf_height;
@property CGFloat sf_x;
@property CGFloat sf_y;
@property CGFloat sf_centerY;
@property CGFloat sf_centerX;

- (CGFloat)sf_maxX;
- (CGFloat)sf_maxY;
- (CGFloat)sf_midX;
- (CGFloat)sf_midY;
- (CGFloat)sf_minX;
- (CGFloat)sf_minY;
@end

@interface UIScrollView (SFExtension)
// Content Offset
@property (nonatomic) CGFloat contentOffsetX;
@property (nonatomic) CGFloat contentOffsetY;

// Content Size
@property (nonatomic) CGFloat contentSizeWidth;
@property (nonatomic) CGFloat contentSizeHeight;

// Content Inset
@property (nonatomic) CGFloat contentInsetTop;
@property (nonatomic) CGFloat contentInsetLeft;
@property (nonatomic) CGFloat contentInsetBottom;
@property (nonatomic) CGFloat contentInsetRight;
@end

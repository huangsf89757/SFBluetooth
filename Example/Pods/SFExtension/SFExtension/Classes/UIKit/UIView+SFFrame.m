//
//  UIView+SFFrame.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UIView+SFFrame.h"

@implementation UIView (SFFrame)
- (CGFloat)sf_centerX {
    
    return self.center.x;
}

- (void)setSf_centerX:(CGFloat)sf_centerX {
    
    CGPoint center = self.center;
    center.x = sf_centerX;
    self.center = center;
}

- (CGFloat)sf_centerY {
    return self.center.y;
}
- (void)setSf_centerY:(CGFloat)sf_centerY {
    
    CGPoint center = self.center;
    center.y = sf_centerY;
    self.center = center;
}

- (CGFloat)sf_height {
    
    return self.frame.size.height;
}

- (void)setSf_height:(CGFloat)sf_height {
    
    CGRect rect = self.frame;
    rect.size.height = sf_height;
    self.frame = rect;
}

- (CGFloat)sf_width {
    
    return self.frame.size.width;
}

- (void)setSf_width:(CGFloat)sf_width {
    
    CGRect rect = self.frame;
    rect.size.width = sf_width;
    self.frame = rect;
}

- (CGFloat)sf_x {
    
    return self.frame.origin.x;
}

- (void)setSf_x:(CGFloat)sf_x {
    
    CGRect rect = self.frame;
    rect.origin.x = sf_x;
    self.frame = rect;
    
}

- (CGFloat)sf_y {
    
    return self.frame.origin.y;
}
- (void)setSf_y:(CGFloat)sf_y {
    
    CGRect rect = self.frame;
    rect.origin.y = sf_y;
    self.frame = rect;
    
}

- (CGFloat)sf_maxX {
    
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)sf_maxY {
    
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)sf_midX {
    
    return self.sf_maxX - (self.sf_width / 2.f);
}

- (CGFloat)sf_midY {
    
    return self.sf_maxY - (self.sf_height / 2.f);
}

- (CGFloat)sf_minX {
    
    return CGRectGetMinX(self.frame);
}
- (CGFloat)sf_minY {
    
    return CGRectGetMinY(self.frame);
}
@end

#pragma mark Content Offset

@implementation UIScrollView (SFExtension)

- (CGFloat)contentOffsetX {
    
    return self.contentOffset.x;
}

- (CGFloat)contentOffsetY {
    
    return self.contentOffset.y;
}

- (void)setContentOffsetX:(CGFloat)newContentOffsetX {
    
    self.contentOffset = CGPointMake(newContentOffsetX, self.contentOffsetY);
}

- (void)setContentOffsetY:(CGFloat)newContentOffsetY {
    
    self.contentOffset = CGPointMake(self.contentOffsetX, newContentOffsetY);
}


#pragma mark Content Size

- (CGFloat)contentSizeWidth {
    
    return self.contentSize.width;
}

- (CGFloat)contentSizeHeight {
    
    return self.contentSize.height;
}

- (void)setContentSizeWidth:(CGFloat)newContentSizeWidth {
    
    self.contentSize = CGSizeMake(newContentSizeWidth, self.contentSizeHeight);
}

- (void)setContentSizeHeight:(CGFloat)newContentSizeHeight {
    
    self.contentSize = CGSizeMake(self.contentSizeWidth, newContentSizeHeight);
}


#pragma mark Content Inset

- (CGFloat)contentInsetTop {
    
    return self.contentInset.top;
}

- (CGFloat)contentInsetRight {
    
    return self.contentInset.right;
}

- (CGFloat)contentInsetBottom {
    
    return self.contentInset.bottom;
}

- (CGFloat)contentInsetLeft {
    
    return self.contentInset.left;
}

- (void)setContentInsetTop:(CGFloat)newContentInsetTop {
    
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.top = newContentInsetTop;
    self.contentInset = newContentInset;
}

- (void)setContentInsetRight:(CGFloat)newContentInsetRight {
    
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.right = newContentInsetRight;
    self.contentInset = newContentInset;
}

- (void)setContentInsetBottom:(CGFloat)newContentInsetBottom {
    
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.bottom = newContentInsetBottom;
    self.contentInset = newContentInset;
}

- (void)setContentInsetLeft:(CGFloat)newContentInsetLeft {
    
    UIEdgeInsets newContentInset = self.contentInset;
    newContentInset.left = newContentInsetLeft;
    self.contentInset = newContentInset;
}

@end

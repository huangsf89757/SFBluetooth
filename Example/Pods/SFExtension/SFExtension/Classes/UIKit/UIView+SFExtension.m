//
//  UIView+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UIView+SFExtension.h"
#import "UIView+SFFrame.h"
@implementation UIView (SFExtension)
- (UIViewController*)sf_viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController * )nextResponder;
        }
    }
    return nil;
}
- (UIImageView *)sf_findHairlineImageViewUnder
{
    
    if ([self isKindOfClass:[UIImageView class]] && self.bounds.size.height <= 1.0)
    {
        return (UIImageView *)self;
    }
    
    for (UIView * subview in self.subviews)
    {
        UIImageView * imageView = [subview sf_findHairlineImageViewUnder];
        if (imageView)
        {
            return imageView;
        }
    }
    return nil;
}
- (UIView * )sf_addTopLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha {
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.sf_width,height)];
    topLine.backgroundColor = color;
    topLine.alpha = alpha;
    
    topLine.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self addSubview:topLine];
    
    return topLine;
    
}

- (UIView*)sf_addBottomLineWithColor:(UIColor *)color height:(CGFloat)height alpha:(CGFloat)alpha {
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.sf_height- height,self.sf_width,height)];
    bottomLine.backgroundColor = color;
    bottomLine.alpha = alpha;
    bottomLine.translatesAutoresizingMaskIntoConstraints=NO;
    [self addSubview:bottomLine];
    
    return bottomLine;
}

- (void)sf_addLine:(UIColor *)color inRect:(CGRect)rect
{
    CAShapeLayer * solidShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef solidShapePath =  CGPathCreateMutable();
    [solidShapeLayer setStrokeColor:[color CGColor]];
    
    CGFloat width = CGRectGetWidth(rect);
    
    CGFloat height = CGRectGetHeight(rect);
    
    if (width > height)
    {
        solidShapeLayer.lineWidth = height ;
        CGPathMoveToPoint(solidShapePath, NULL, CGRectGetMinX(rect),CGRectGetMinY(rect));
        CGPathAddLineToPoint(solidShapePath, NULL, CGRectGetMaxX(rect),CGRectGetMinY(rect));
    }
    else
    {
        solidShapeLayer.lineWidth = width ;
        CGPathMoveToPoint(solidShapePath, NULL, CGRectGetMinX(rect),CGRectGetMinY(rect));
        CGPathAddLineToPoint(solidShapePath, NULL, CGRectGetMinX(rect),CGRectGetMaxY(rect));
    }
    
    [solidShapeLayer setPath:solidShapePath];
    
    CGPathRelease(solidShapePath);
    
    [self.layer addSublayer:solidShapeLayer];
}

+ (instancetype)sf_loadFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)sf_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)corner
{
    CGSize radio = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}
@end

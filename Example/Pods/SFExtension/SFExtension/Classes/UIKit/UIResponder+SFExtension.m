//
//  UIResponder+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "UIResponder+SFExtension.h"

@implementation UIResponder (SFExtension)
- (void)sf_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] sf_routerEventWithName:eventName userInfo:userInfo];
}

@end

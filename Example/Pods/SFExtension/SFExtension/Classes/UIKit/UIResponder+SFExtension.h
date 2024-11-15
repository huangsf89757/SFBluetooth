//
//  UIResponder+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (SFExtension)
- (void)sf_routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end

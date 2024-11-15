//
//  NSTimer+SFExtension.h
//  Pods
//
//  Created by 花菜 on 2017/8/7.
//
//

#import <Foundation/Foundation.h>

@interface NSTimer (SFExtension)

+ (instancetype)sf_scheduleTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block;

+ (instancetype)sf_timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block;
@end

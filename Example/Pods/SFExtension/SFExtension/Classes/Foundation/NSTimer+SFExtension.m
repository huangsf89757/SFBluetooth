//
//  NSTimer+SFExtension.m
//  Pods
//
//  Created by 花菜 on 2017/8/7.
//
//

#import "NSTimer+SFExtension.h"

@implementation NSTimer (SFExtension)
+ (instancetype)sf_scheduleTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block
{
    NSTimer *timer = [self sf_timerWithTimeInterval:seconds repeats:repeats usingBlock:block];
    [NSRunLoop.currentRunLoop addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

+ (instancetype)sf_timerWithTimeInterval:(NSTimeInterval)inSeconds repeats:(BOOL)repeats usingBlock:(void (^)(NSTimer *timer))block
{
    NSParameterAssert(block != nil);
    CFAbsoluteTime seconds = fmax(inSeconds, 0.0001);
    CFAbsoluteTime interval = repeats ? seconds : 0;
    CFAbsoluteTime fireDate = CFAbsoluteTimeGetCurrent() + seconds;
    return (__bridge_transfer NSTimer *)CFRunLoopTimerCreateWithHandler(NULL, fireDate, interval, 0, 0, (void(^)(CFRunLoopTimerRef))block);
}
@end

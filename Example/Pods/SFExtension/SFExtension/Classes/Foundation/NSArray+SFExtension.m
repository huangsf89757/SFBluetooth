//
//  NSArray+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "NSArray+SFExtension.h"
#import <objc/runtime.h>
@implementation NSArray (SFExtension)
- (NSArray *)shuffleArray
{
    NSMutableArray * array = [self mutableCopy];
    
    [array shuffle];
    
    return [array copy];
}
+ (void)load
{
    //  替换不可变数组中的方法
    Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(sf_objectAtIndex:));
    method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
    //  替换可变数组中的方法
    Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
    Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(sf_mutableObjectAtIndex:));
    method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
}
- (id)sf_objectAtIndex:(NSUInteger)index
{
    
    if (index >= self.count)
    {
        
        @try
        {
            [self sf_objectAtIndex:index];
        }
        @catch (NSException *exception)
        {
            // 抛出异常
            NSLog(@"数组越界...%@",[exception callStackSymbols]);
            return nil;
        }
        @finally {}
        return nil;
    }
    else
    {
        return [self sf_objectAtIndex:index];
    }
}

- (id)sf_mutableObjectAtIndex:(NSUInteger)index
{
    
    if (index >= self.count)
    {
        
        @try
        {
            [self sf_mutableObjectAtIndex:index];
        }
        @catch (NSException *exception)
        {
            // 抛出异常
            NSLog(@"可变数组越界...%@",[exception callStackSymbols]);
        }
        @finally {}
        return nil;
    }
    else
    {
        return [self sf_mutableObjectAtIndex:index];
    }
}
@end


@implementation NSMutableArray (SFExtension)
- (void)shuffle
{
    for (NSInteger i = [self count] - 1; i > 0; i--) {
        [self exchangeObjectAtIndex:arc4random_uniform((int)i + 1)
                  withObjectAtIndex:i];
    }
}
@end


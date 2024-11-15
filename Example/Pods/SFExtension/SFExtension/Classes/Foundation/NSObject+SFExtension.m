//
//  NSObject+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "NSObject+SFExtension.h"
#import <objc/runtime.h>
static const char * SFObjectsDictionary = "SFObjectsDictionary";
@interface SFEndObject : NSObject

@end
@implementation SFEndObject

+ (instancetype)end
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self class] new];
    });
    return instance;
}

@end

@implementation NSObject (SFExtension)
- (id)performSelector:(SEL)aSelector withObjects:(id)object,... {
    
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    if (signature == nil) {
        NSAssert(false, @"牛逼的错误,找不到 %@ 方法",NSStringFromSelector(aSelector));
    }
    // 包装方法
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 设置方法调用者
    invocation.target = self;
    // 设置需要调用的方法
    invocation.selector = aSelector;
    // 获取除去self、_cmd以外的参数个数
    NSInteger paramsCount = signature.numberOfArguments - 2;
    // 设置参数
    va_list params;
    va_start(params, object);
    int i = 0;
    // [GKEndMark end] 是自定义的结束符号,仅此而已,从而使的该方法可以接收nil做为参数
    for (id tmpObject = object; (id)tmpObject != [SFEndObject end]; tmpObject = va_arg(params, id)) {
        // 防止越界
        if (i >= paramsCount) break;
        // 去掉self,_cmd所以从2开始
        [invocation setArgument:&tmpObject atIndex:i + 2];
        i++;
    }
    va_end(params);
    // 调用方法
    [invocation invoke];
    // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnType) {
        [invocation getReturnValue:&returnValue];
    }
    return returnValue;
}

#pragma mark -
#pragma mark - ===== swizzle =====
+ (IMP)sf_swizzleInstanceMethod:(SEL)originalSelector withMethod:(SEL)newSelector
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method newMethod = class_getInstanceMethod(self, newSelector);
    
    if (originalMethod && newMethod)
    {
        IMP originalIMP = method_getImplementation(originalMethod);
        
        if (class_addMethod(self, originalSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        {
            class_replaceMethod(self, newSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }
        else
        {
            method_exchangeImplementations(originalMethod, newMethod);
        }
        
        return originalIMP;
    }
    
    return NULL;
}


- (NSMutableDictionary *)shared_ObjectDictionary
{
    NSMutableDictionary *objectDictionary = objc_getAssociatedObject(self, SFObjectsDictionary);
    if (objectDictionary == nil)
    {
        objectDictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, SFObjectsDictionary, objectDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objectDictionary;
}

- (id)sf_associatedObjectWithKey:(NSString *)key
{
    return [[self shared_ObjectDictionary] objectForKey:key];
}

- (void)sf_setAssociatedObject:(nullable id)object key:(NSString *)key
{
    if (object == nil)
    {
        [[self shared_ObjectDictionary] removeObjectForKey:key];
    }
    else
    {
        [[self shared_ObjectDictionary] setObject:object forKey:key];
    }
}

- (void)sf_removeAssociatedObjectWithKey:(NSString *)key
{
    [self sf_setAssociatedObject:nil key:key];
}

- (NSDictionary *)sf_associatedObjects
{
    return [[self shared_ObjectDictionary] copy];
}


@end

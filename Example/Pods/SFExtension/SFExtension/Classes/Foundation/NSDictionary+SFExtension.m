//
//  NSDictionary+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import "NSDictionary+SFExtension.h"

@implementation NSDictionary (SFExtension)
- (NSArray *)sortedKeys;
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)sortedArrayUsingKeyValues;
{
    NSArray *sortedKeys = [self sortedKeys];
    
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for (id currentKey in sortedKeys) {
        [returnArray addObject:[self objectForKey:currentKey]];
    }
    
    return returnArray;
}

@end

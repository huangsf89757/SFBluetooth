//
//  UIActionSheet+SFExtension.m
//  SFExtension
//
//  Created by 花菜 on 2017/9/14.
//  Copyright © 2017年 Caiflower. All rights reserved.
//

#import "UIActionSheet+SFExtension.h"
// 去除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

@interface SFActionSheetWrapper : NSObject<UIActionSheetDelegate>
@property (nonatomic, strong) UIActionSheet * actionSheet;
@property (nonatomic, copy) SFActionSheetCompletion completion;
@end

@implementation SFActionSheetWrapper

- (UIActionSheet *)actionSheetWithTitle:(NSString *)title completion:(SFActionSheetCompletion)completion cancleButtonTitle:(NSString *)cancleButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray <NSString *>*)otherButtonTitles
{
    CFRetain((__bridge CFTypeRef)self);
    self.completion = completion;
    self.actionSheet = [[UIActionSheet alloc] init];
    self.actionSheet.title = title;
    self.actionSheet.delegate = self;
    for (NSString * title in otherButtonTitles) {
        [self.actionSheet addButtonWithTitle:title];
    }
    NSInteger count = otherButtonTitles.count;
    if (destructiveButtonTitle.length != 0) {
        [self.actionSheet addButtonWithTitle:destructiveButtonTitle];
        self.actionSheet.destructiveButtonIndex = count++;
    }
    if (cancleButtonTitle.length != 0) {
        [self.actionSheet addButtonWithTitle:cancleButtonTitle];
        self.actionSheet.cancelButtonIndex = count;
    }
    
    [self.actionSheet showInView:[[UIApplication sharedApplication].windows objectAtIndex:0]];
    
    return _actionSheet;
    
}

#pragma mark -
#pragma mark - ===== UIActionSheetDelegate =====
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completion) {
        self.completion(buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        CFRelease((__bridge CFTypeRef)self);
    });
}







@end

@implementation UIActionSheet (SFExtension)

+ (UIActionSheet *)sf_actionSheetWithTitle:(NSString *)title completion:(SFActionSheetCompletion)completion cancleButtonTitle:(NSString *)cancleButtonTitle destructiveButtonTittle:(NSString *)destructiveButtonTittle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    NSMutableArray * titleList = [NSMutableArray array];
    va_list params;
    va_start(params, otherButtonTitles);
    for (id item = otherButtonTitles; item != nil; item = va_arg(params, id)) {
        [titleList addObject:item];
    }
    va_end(params);
    
    return [self sf_actionSheetWithTitle:title completion:completion cancleButtonTitle:cancleButtonTitle destructiveButtonTittle:destructiveButtonTittle otherButtonTitleList:titleList];
    
}

+ (UIActionSheet *)sf_actionSheetWithTitle:(NSString *)title completion:(SFActionSheetCompletion)completion cancleButtonTitle:(NSString *)cancleButtonTitle destructiveButtonTittle:(NSString *)destructiveButtonTittle otherButtonTitleList:(NSArray<NSString *> *)otherButtonTitleList
{
    return [[[SFActionSheetWrapper alloc] init] actionSheetWithTitle:title completion:completion cancleButtonTitle:cancleButtonTitle destructiveButtonTitle:destructiveButtonTittle otherButtonTitles:otherButtonTitleList];
}

- (void)sf_setButtonTitleColor:(UIColor *)titleColor
{
    [self sf_enumerateButtonUsingBlock:^(UIButton * button) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }];
}

- (void)sf_enumerateButtonUsingBlock:(void (^)(UIButton *))block
{
    for (UIView * subview in [self subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton * button = (UIButton *)subview;
            block(button);
        }
    }
}

@end
#pragma clang diagnostic pop

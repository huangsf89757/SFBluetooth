//
//  UIActionSheet+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/9/14.
//  Copyright © 2017年 Caiflower. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SFActionSheetCompletion)(NSInteger buttonIndex, NSString * buttonTitle);
@interface UIActionSheet (SFExtension)

+ (UIActionSheet *)sf_actionSheetWithTitle:(NSString *)title
                                completion:(SFActionSheetCompletion)completion
                         cancleButtonTitle:(NSString *)cancleButtonTitle
                   destructiveButtonTittle:(NSString *)destructiveButtonTittle
                         otherButtonTitles:(NSString *)otherButtonTitles,...;

+ (UIActionSheet *)sf_actionSheetWithTitle:(NSString *)title
                               completion :(SFActionSheetCompletion)completion
                         cancleButtonTitle:(NSString *)cancleButtonTitle
                   destructiveButtonTittle:(NSString *)destructiveButtonTittle
                      otherButtonTitleList:(NSArray<NSString *> *)otherButtonTitleList;

- (void)sf_setButtonTitleColor:(UIColor *)titleColor;

- (void)sf_enumerateButtonUsingBlock:(void(^)(UIButton *))block;
@end

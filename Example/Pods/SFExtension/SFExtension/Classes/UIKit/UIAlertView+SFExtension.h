//
//  UIAlertView+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/9/14.
//  Copyright © 2017年 Caiflower. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SFAlertViewCompletion)(NSInteger buttonIndex, NSString * buttonTitle);
@interface UIAlertView (SFExtension_quickAlert)

+ (void)sf_dismissPresentingAnimated:(BOOL)animated;

+ (UIAlertView *)sf_alertWithTitle:(NSString *)title
                                 message:(NSString *)message
                                completion:(SFAlertViewCompletion)completion
                         cancleButtonTitle:(NSString *)cancleButtonTitle
                         otherButtonTitles:(NSString *)otherButtonTitles,...;

+ (UIAlertView *)sf_alertWithTitle:(NSString *)title
                                 message:(NSString *)message
                               completion :(SFAlertViewCompletion)completion
                         cancleButtonTitle:(NSString *)cancleButtonTitle
                      otherButtonTitleList:(NSArray<NSString *> *)otherButtonTitleList;

+ (UIAlertView *)sf_alertWithTitle:(NSString *)title
                           message:(NSString *)message
                        completion:(void(^)())completion;

+ (UIAlertView *)sf_alertWithMessage:(NSString *)message
                        completion:(void(^)())completion;
@end


@interface UIAlertView (SFExtension_confirm)

+ (UIAlertView *)sf_confirmWithTitle:(NSString *)title
                           message:(NSString *)message
                        approve:(void(^)())approve;

+ (UIAlertView *)sf_confirmWithTitle:(NSString *)title
                           message:(NSString *)message
                           approve:(void(^)())approve
                            cancle:(void(^)())cancle;
@end

@interface UIAlertView (SFExtension_input)

+ (UITextField *)sf_inputWithTitle:(NSString *)title
                           message:(NSString *)message
                 canaleButtonTitle:(NSString *)canaleButtonTitle
                approveButtonTitle:(NSString *)approveButtonTitle
                        completion:(void(^)(NSString * input,BOOL cancled))completion;

+ (UITextField *)sf_inputWithTitle:(NSString *)title
                           message:(NSString *)message
                 secureTextEntry:(BOOL)secureTextEntry
                canaleButtonTitle:(NSString *)canaleButtonTitle
                approveButtonTitle:(NSString *)approveButtonTitle
                        completion:(void(^)(NSString * input,BOOL cancled))completion;
@end


@interface UIAlertView (SFExtension)

- (UILabel *)sf_messageLabel;


- (UILabel *)sf_titleLabel;
@end





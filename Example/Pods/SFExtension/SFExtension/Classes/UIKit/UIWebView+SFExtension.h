//
//  UIWebView+SFExtension.h
//  SFExtension
//
//  Created by 花菜 on 2017/7/26.
//  Copyright © 2017年 chriscaixx. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 拦截 webview 弹窗显示网址
 */
@interface UIWebView (SFExtension)<UIAlertViewDelegate>
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect *)frame;
@end

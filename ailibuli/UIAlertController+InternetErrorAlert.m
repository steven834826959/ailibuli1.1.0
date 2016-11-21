//
//  UIAlertController+InternetErrorAlert.m
//  ailibuli
//
//  Created by ios on 16/11/10.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "UIAlertController+InternetErrorAlert.h"

@implementation UIAlertController (InternetErrorAlert)


+ (instancetype)internetErrorAlertShow{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    return alert;
}

@end

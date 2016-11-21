//
//  StatutVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginDelegate <NSObject>
- (void)loginState:(NSString *)state riqi:(NSString *)riqi1 riqi:(NSString *)riqi2 bachelordom:(NSString *)bac iflogin:(BOOL)login;

@end

@interface StatutVC : UIViewController
@property (nonatomic, assign)BOOL ifLogin; // 是否登录
@property (nonatomic, copy)NSString *state; // 状态
@property (nonatomic, copy)NSString *bachelordom; // 是否单身
@property (nonatomic, copy)NSString *riqi1; // 日期1
@property (nonatomic, copy)NSString *riqi2; // 日期2
@property (nonatomic, strong)UITextField *accountText; // 账号
@property (nonatomic, strong)UITextField *passWordText; // 密码
@property (nonatomic, copy)NSString *text1;
@property (nonatomic, copy)NSString *text2;

@property (nonatomic, assign)id<LoginDelegate>delegate;


@property(nonatomic,assign)int gender;

- (void)uploadInformation:(id)json;

@end

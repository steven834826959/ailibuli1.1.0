//
//  ChooseView.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/6.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChooseViewDelegate <NSObject>
@optional
- (void)sendState:(NSString *)str;
- (void)sendBachelordom:(NSString *)str;
- (void)sendSex:(NSString *)str;

@end
@interface ChooseView : UIView


@property (nonatomic, copy)NSString *type;
@property (nonatomic, copy)NSString *state; // 状态
@property (nonatomic, copy)NSString *bachelordom; // 是否单身

@property (nonatomic, strong)UIButton *btn1;
@property (nonatomic, strong)UIButton *btn2;
@property (nonatomic, strong)UIButton *btn3;
@property (nonatomic, strong)UIButton *btn4;
@property (nonatomic, strong)UIButton *btn5;
@property (nonatomic, assign)id<ChooseViewDelegate>delegate;
- (void)createView;

@end

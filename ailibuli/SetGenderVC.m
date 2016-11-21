

//
//  SetGenderVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/20.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "SetGenderVC.h"
#import "ChooseView.h"
#import "StatutVC.h"
@interface SetGenderVC ()<ChooseViewDelegate>

@property(nonatomic,assign)BOOL setGender;
@end

@implementation SetGenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"您的性别";
    [self.view setBackgroundColor:BGColor];
    ChooseView *choose = [ChooseView new];
    [choose setFrame:CGRectMake(20, 110, self.view.frame.size.width - 40, 250)];
    choose.type = @"4";
    choose.delegate = self;
    [choose createView];
    [self.view addSubview:choose];
    
    
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.bottom.mas_equalTo(-50 - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.bottom.mas_equalTo(-50 - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [label setFont:[UIFont systemFontOfSize:14]];
    label.textColor = [UIColor whiteColor];
    label.text = @"下一步";
    label.textAlignment = NSTextAlignmentCenter;
}
- (void)sendSex:(NSString *)str{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.sex forKey:@"gender"];
    [defaults synchronize];
    self.sex = str;
}
- (void)button{
    StatutVC  * statut = [StatutVC new];
    statut.ifLogin = YES;
    statut.state = self.state;
    statut.riqi1 = [self riqi];
    statut.riqi2 = [self riqi];
    statut.bachelordom = @"否";
    [statut uploadInformation:@{@"loveStatus":self.state}];
    [self.navigationController pushViewController:statut animated:YES];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"已登录"forKey:@"userLogin"];
    [defaults setObject:self.state forKey:@"state"];
    [defaults synchronize];
    [defaults setValue:[self riqi] forKey:@"riqi2"];
    [defaults setValue:[self riqi] forKey:@"riqi1"];
}

- (NSString *)riqi{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY.MM.dd"];
    return [dateformatter stringFromDate:senddate];
}
@end

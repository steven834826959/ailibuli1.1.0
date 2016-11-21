//
//  SetStateVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/20.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "SetStateVC.h"
#import "ChooseView.h"
#import "SetGenderVC.h"
@interface SetStateVC ()<ChooseViewDelegate>

@property(nonatomic,assign)BOOL setStates;

@end

@implementation SetStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.navigationItem setHidesBackButton:TRUE animated:NO];

    self.title = @"您的爱情状态";
    [self.view setBackgroundColor:BGColor];
    ChooseView *choose = [ChooseView new];
    [choose setFrame:CGRectMake(20, 110, self.view.frame.size.width - 40, 250)];
    choose.type = @"3";
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
- (void)sendState:(NSString *)str{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.state forKey:@"states"];
    [defaults synchronize];
    self.state = str;
}

- (void)button{
    SetGenderVC  *setG = [SetGenderVC new];
    setG.state = self.state;
    [self.navigationController pushViewController:setG animated:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

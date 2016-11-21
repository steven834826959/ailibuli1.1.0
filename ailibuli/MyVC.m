
//
//  MyVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "MyVC.h"
#import "PersonalInformationVC.h"
#import "RenzhengVC.h"
#import "BalanceVC.h"
#import "BankCardVC.h"
#import "SecuritySettingVC.h"
#import "GeneralVC.h"
#import "GuanyuViewController.h"

@interface MyVC ()

@end

@implementation MyVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController]; 
    [self.view setBackgroundColor:BGColor];
    self.title = @"我的";
    [self createMainView];
}


- (void)createMainView{
    //背景图
    UIImageView *backIV = [[UIImageView alloc]init];
    [backIV setFrame:CGRectMake(0, -1, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"背景@2x-1"];
    backIV.image = image;
    UIImageView *topIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *imageTop = [UIImage imageNamed:@"上背景"];
    topIV.image = imageTop;
    [backIV addSubview:topIV];
    backIV.userInteractionEnabled = YES;
    [self.view addSubview:backIV];
    
    for (int i = 0 ; i < 7; i++) {
        UIButton *baseColorBtn = [UIButton new];
        [baseColorBtn setBackgroundColor:[UIColor colorWithRed:131.0 / 255 green:126.0 / 255 blue:182.0 / 255 alpha:1]];
        [self.view addSubview:baseColorBtn];
        baseColorBtn.frame = CGRectMake( 44 * kScreenH / 568.0f, 34 * kScreenH / 568.0f + 50 * i * kScreenH / 568.0f , self.view.frame.size.width  - 2*(44 * kScreenH / 568.0f), 35 * kScreenH / 568.0f);
        UIImageView *image = [UIImageView new];
        [baseColorBtn addSubview:image];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"my%d",i]];
        [image setFrame:CGRectMake(12, 10 * kScreenH / 568.0f, 15 * kScreenH / 568.0f, 15 * kScreenH / 568.0f)];
        
        UILabel *label = [UILabel new];
        [baseColorBtn addSubview:label];
        [label setFrame:CGRectMake(12 + 15 * kScreenH /568.0f + 10, 0, baseColorBtn.frame.size.width - 12 - 15 * kScreenH / 568.0f, 35 * kScreenH / 568.0f)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14 * kScreenH / 568.0f];
        
        switch (i) {
            case 0:
                label.text = @"个人信息";
                break;
            case 1:
                label.text = @"账户余额";
                break;
            case 2:
                label.text = @"银行卡管理";
                break;
            case 3:
                label.text = @"安全设置";
                break;
            case 4:
                label.text = @"通用设置";
                break;
            case 5:
                label.text = @"关于我们";
                break;
            case 6:
                label.text = @"退出登录";
                break;
        }

        [baseColorBtn setTag:201607180 + i];
        [baseColorBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

- (void)nologin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未登录账号" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}



- (void)btnAction:(UIButton *)btn{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"secretKey"]) {
        if (btn.tag == 201607180) {
            [self nologin];
                    }
        if (btn.tag == 201607181) {
            [self nologin];
        } if (btn.tag == 201607182) {
            [self nologin];
        } if (btn.tag == 201607183) {
            [self nologin];
        }
        if (btn.tag == 201607184) {
            NSLog(@"5");
            GeneralVC *gen = [GeneralVC new];
            [self.navigationController pushViewController:gen animated:YES];
            
        } if (btn.tag == 201607185) {
            NSLog(@"6");
            GuanyuViewController *guanyu = [GuanyuViewController new];
            [self.navigationController pushViewController:guanyu animated:YES];
        }
        if (btn.tag == 201607186) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击确定退出登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"未登录"forKey:@"userLogin"];
                [defaults setObject:nil forKey:@"state"];

                [defaults setObject:nil forKey:@"secretKey"];
                [defaults setObject:nil forKey:@"sessionid"];
                [defaults setObject:nil forKey:@"userId"];
                [defaults synchronize];
                
                self.tabBarController.selectedIndex = 0;
                
                [self.delegate Logout:@"123"];
                
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            NSLog(@"7");
        }
      
    }else{
    
        if (btn.tag == 201607180) {
            PersonalInformationVC  *per = [PersonalInformationVC new];
            [self.navigationController pushViewController:per animated:YES];
        }
        if (btn.tag == 201607181) {
            BalanceVC *balance = [BalanceVC new];
            [self.navigationController pushViewController:balance animated:YES];
            NSLog(@"2");
        } if (btn.tag == 201607182) {
            BankCardVC *bank = [BankCardVC new];
            [self.navigationController pushViewController:bank animated:YES];
        } if (btn.tag == 201607183) {

            SecuritySettingVC *sec = [SecuritySettingVC new];
            [self.navigationController pushViewController:sec animated:YES];
            
            
            NSLog(@"4");
        }  if (btn.tag == 201607184) {
            NSLog(@"5");
            GeneralVC *gen = [GeneralVC new];
            [self.navigationController pushViewController:gen animated:YES];

        } if (btn.tag == 201607185) {
            NSLog(@"6");
            GuanyuViewController *guanyu = [GuanyuViewController new];
            [self.navigationController pushViewController:guanyu animated:YES];
        }
        if (btn.tag == 201607186) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击确定退出登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:@"未登录"forKey:@"userLogin"];
                [defaults setObject:nil forKey:@"state"];

                [defaults setObject:nil forKey:@"secretKey"];
                [defaults setObject:nil forKey:@"sessionid"];
                [defaults setObject:nil forKey:@"userId"];
                [defaults synchronize];
                
                self.tabBarController.selectedIndex = 0;
                
                [self.delegate Logout:@"123"];
                
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }

        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

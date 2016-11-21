
//
//  SecuritySettingVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/4.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "SecuritySettingVC.h"
#import "RenzhengVC.h"
#import "NewPasswordVC.h"

@interface SecuritySettingVC ()

@end

@implementation SecuritySettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    
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
    
    self.title = @"安全设置";
    [self createMainView];
}

- (void)createMainView{
    for (int i = 0 ; i < 2; i++) {
        UIButton *baseColorBtn = [UIButton new];
        [baseColorBtn setBackgroundColor:[UIColor colorWithRed:131.0 / 255 green:126.0 / 255 blue:182.0 / 255 alpha:1]];
        [self.view addSubview:baseColorBtn];
        baseColorBtn.frame = CGRectMake( 10 , 10 * kScreenH / 568.0f + 50 * i  , self.view.frame.size.width  - 20, 35 * kScreenH / 568.0f);
        
        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        [label setFrame:CGRectMake(20 , 10 * kScreenH / 568.0f + 50 * i , self.view.frame.size.width  - 20, 35 * kScreenH / 568.0f)];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14 * kScreenH / 568.0f];
        
        
        switch (i) {
            case 0:
                label.text = @"银行卡绑定";
                break;
            case 1:
                label.text = @"重置登录密码";
                break;
//            case 2:
//                label.text = @"重置支付密码";
//                break;
        }
        
        [baseColorBtn setTag:201609040 + i];
        [baseColorBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }

}
- (void)btnAction:(UIButton *)btn{
    
        if (btn.tag == 201609040) {
            RenzhengVC *renzheng = [RenzhengVC new];
            [self.navigationController pushViewController:renzheng animated:YES];
        }
        if (btn.tag == 201609041) {
            
            NewPasswordVC *new = [NewPasswordVC new];
            [self.navigationController pushViewController:new animated:YES];
            
        } if (btn.tag == 201609042) {
            
        }
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}



@end

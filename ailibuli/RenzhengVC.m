//
//  RenzhengVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/4.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "RenzhengVC.h"
#import "BankSetVC.h"
@interface RenzhengVC ()
@property (nonatomic, strong)UITextField *nameField;
@property (nonatomic, strong)UITextField *idCardField;
@property (nonatomic, strong)UITextField *emailField;
@property (nonatomic, strong)UITextField *capAcntNoField;

@property(nonatomic,strong)UIView *prompt;


@end

@implementation RenzhengVC

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
    
    self.title = @"银行卡绑定";
    [self createRenzheng];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"您所绑定的银行卡在所属银行预留手机号、姓名、省份证、必须与注册手机号相同，否则无法实现充值操作!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}


- (void)createRenzheng{
    
    UIView *view  = [UIView new];
    [view setBackgroundColor:[UIColor colorWithRed:67/ 255.0 green:76/ 255.0  blue:72/255.0 alpha:0.85]];
    [view setFrame:CGRectMake(10 , 10 * kScreenH / 568.0f, self.view.frame.size.width  - 20,  64 * 4 * kScreenH / 568.0f)];
    [self.view addSubview:view];
    
    
    
    UILabel *lable1 = [UILabel new];
    [lable1 setFrame:CGRectMake(20 , 34 * kScreenH / 568.0f , self.view.frame.size.width  - 40, 30 * kScreenH / 568.0f)];
    lable1.text = @"姓名";
    lable1.font = [UIFont systemFontOfSize:14 * kScreenH / 568.0f];
    lable1.textAlignment = NSTextAlignmentLeft;
    lable1.textColor = [UIColor whiteColor];
    
    [self.view addSubview:lable1];
    self.nameField = [UITextField new];
    [self.nameField setFrame:CGRectMake(20 , 64 * kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    [self.view addSubview:self.nameField];
    [self.nameField setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];
    [self.nameField setPlaceholder:@" 请输入姓名"];
    [self.nameField setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];
    [self.nameField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameField setTextColor:[UIColor grayColor]];
    
    
    
    UILabel *lable2 = [UILabel new];
    [lable2 setFrame:CGRectMake(20 , 64 * 2* kScreenH / 568.0f - 30 * kScreenH / 568.0f, self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    lable2.text = @"身份证";
    lable2.font = [UIFont systemFontOfSize:14* kScreenH / 568.0f];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.textColor = [UIColor whiteColor];
    [self.view addSubview:lable2];

    self.idCardField = [UITextField new];
    [self.idCardField setFrame:CGRectMake(20 , 64 * 2* kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    [self.view addSubview:self.idCardField];
    [self.idCardField setPlaceholder:@" 请输入身份证号码"];
    [self.idCardField setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];
    [self.idCardField setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];

       [self.idCardField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.idCardField setTextColor:[UIColor grayColor]];


    UILabel *lable4 = [UILabel new];
    [lable4 setFrame:CGRectMake(20 , 64 * 3* kScreenH / 568.0f - 30* kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    lable4.text = @"银行卡";
    lable4.font = [UIFont systemFontOfSize:14* kScreenH / 568.0f];
    lable4.textAlignment = NSTextAlignmentLeft;
    lable4.textColor = [UIColor whiteColor];
    [self.view addSubview:lable4];
    self.capAcntNoField = [UITextField new];
    [self.capAcntNoField setFrame:CGRectMake(20 , 64 * 3* kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    [self.view addSubview:self.capAcntNoField];
    [self.capAcntNoField setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];
    [self.capAcntNoField setPlaceholder:@" 请输入银行卡号"];
    [self.capAcntNoField setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];

     [self.capAcntNoField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.capAcntNoField setTextColor:[UIColor grayColor]];

    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190* kScreenW / 320.0f, 30* kScreenH / 568.0f));
        make.bottom.mas_equalTo(- 50* kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190* kScreenW / 320.0f, 30* kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50* kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [label setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];
    label.textColor = [UIColor whiteColor];
    label.text = @"下一步";
    label.textAlignment = NSTextAlignmentCenter;
    
    
    
}



//充值操作
- (void)button{
    [self.idCardField  resignFirstResponder];
    [self.nameField  resignFirstResponder];
    [self.emailField  resignFirstResponder];
    [self.capAcntNoField  resignFirstResponder];

    BankSetVC *bankset = [BankSetVC new];
    
    bankset.cust_nm = self.nameField.text;
    bankset.capAcntNo = self.capAcntNoField.text;
    bankset.email = self.emailField.text;
    bankset.certif_id = self.idCardField.text;
    
    [self.navigationController pushViewController:bankset animated:YES];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

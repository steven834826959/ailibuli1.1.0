//
//  AmountVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/19.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "AmountVC.h"
#import "TixianVC.h"
#import "ChongzhiVC.h"
@interface AmountVC ()
@property (nonatomic, strong)UITextField *Amount;
@property (nonatomic, strong) UIImageView *yun;

@property(nonatomic,strong)UIButton *nextBtn;


@end

@implementation AmountVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [self bankView];
    [self createView];
    
    
}



- (void)bankView{
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.text = @"   银行卡";
    label.font = [UIFont systemFontOfSize:14];
    [self.yun addSubview:label];
    [label setFrame:CGRectMake(10, 10,  self.view.frame.size.width - 20, 30)];
    [label setBackgroundColor:[UIColor colorWithRed:78/255.0 green:102.0/255 blue:96/255.0 alpha:1]];
    
    UIView *baseView = [UIView new];
    [baseView setFrame:CGRectMake(10, 10 + 30, self.view.frame.size.width - 20, 120)];
//    [baseView setBackgroundColor:[UIColor colorWithRed:142/255.0 green:158/255.0 blue:158/255.0 alpha:0.7]];
    
    [baseView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.7]];
    [self.view addSubview:baseView];
    
    UIImageView *image = [UIImageView new];
    [baseView addSubview:image];
    image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.j]];
    NSLog(@"%@",self.j);
    [image setFrame:CGRectMake(10, 40, 100, 40 )];
    
    
    UILabel *bankc = [UILabel new];
    bankc.textColor = [UIColor grayColor];
    bankc.text = [NSString stringWithFormat:@"***%@",[self.yinhangid substringToIndex:8]];
    bankc.font = [UIFont systemFontOfSize:20];
    [baseView addSubview:bankc];
    [bankc setFrame:CGRectMake(10 + 100 +10, 40,  self.view.frame.size.width - 80, 40)];
   
    
}

- (void)createView{
    
    
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(10, 10 +150, self.view.frame.size.width - 20, 30)];
    [self.view addSubview:view];
    [view setBackgroundColor:[UIColor colorWithRed:78/255.0 green:102.0/255 blue:96/255.0 alpha:1]];
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    label.text = @"   金额";
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    [label setFrame:CGRectMake(10, 10 + 150,  self.view.frame.size.width - 20, 30)];
    
    UIView *veiw1 = [UIView new];
    [veiw1 setBackgroundColor:[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1]];
    [self.view addSubview:veiw1];
    [veiw1 setFrame:CGRectMake(10, 40 + 150, self.view.frame.size.width - 20, 40)];
    
    //金额文本框
    
    self.Amount = [UITextField new];
    //数字键盘
    self.Amount.keyboardType = UIKeyboardTypeNumberPad;
    
    //监听文本框的点击
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(amountClicked:) name:UITextFieldTextDidChangeNotification object:self.Amount];
    
    
    
    [self.Amount setFrame:CGRectMake(20, 40+ 150, self.view.frame.size.width - 40, 40)];
    [self.view addSubview:self.Amount];
    self.Amount.textColor = [UIColor whiteColor];
    if (self.chongzhiORtixian) {
        self.Amount.placeholder = @"请输入充值金额";
    }else{
        self.Amount.placeholder = @"请输入提现金额";
    }
    [self.Amount setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIButton *button1 = [UIButton new];
    [self.view addSubview:button1];
    [button1 setImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50 * kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    button1.enabled = NO;
    
    self.nextBtn = button1;
    
    
    
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50 * kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];

    [label1 setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"下一步";
    label1.textAlignment = NSTextAlignmentCenter;

    
}

//移除监听
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


//监听点击
- (void)amountClicked:(NSNotification *)noti{
    //三目运算符
    self.nextBtn.enabled = self.Amount.text.length > 0 ? YES : NO;

}


- (void)button1{
    [self.Amount resignFirstResponder];
    
    if (self.chongzhiORtixian) {
        ChongzhiVC *chongzhi = [ChongzhiVC new];
        chongzhi.Str = [NSString stringWithFormat:@"%d",[self.Amount.text intValue] * 100]  ;
        [self.navigationController pushViewController:chongzhi animated:YES];
    }else{
        TixianVC *tixian = [TixianVC new];
        tixian.Str = [NSString stringWithFormat:@"%d",[self.Amount.text intValue] * 100] ;
        [self.navigationController pushViewController:tixian animated:YES];
    }
    
  }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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

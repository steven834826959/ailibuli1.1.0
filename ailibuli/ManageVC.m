//
//  ManageVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ManageVC.h"
#import <Masonry.h>
#import "WQFButton.h"
#import "MyProductVc.h"
#import "WaitePayVc.h"
#import "DealRecodVc.h"
#import "AddressViewController.h"
#import "LoveInterestVc.h"
#import "LoveInterestVc2.h"

@interface ManageVC ()

@end

@implementation ManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    [self setupUI];
   
}


- (void)setupUI{
 
    UIImageView *backIV = [[UIImageView alloc]init];
    [backIV setFrame:CGRectMake(0, -1, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"背景@2x-1"];
    backIV.image = image;
    
    UIImageView *topIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *imageTop = [UIImage imageNamed:@"上背景"];
    topIV.image = imageTop;
    [backIV addSubview:topIV];
    topIV.userInteractionEnabled = YES;
    backIV.userInteractionEnabled = YES;
    [self.view addSubview:backIV];
    
    self.navigationItem.title = @"管理";
 
    // 我的产品
    WQFButton *myProductBtn = [WQFButton new];
    [myProductBtn setBackgroundColor:[UIColor colorWithRed:121/255.0 green:109/255.0 blue:213/255.0 alpha:1]];
    myProductBtn.tag = 10001;
    [topIV addSubview:myProductBtn];
    [myProductBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(74);
//        make.right.mas_equalTo(-10);
//        make.height.mas_equalTo((self.view.frame.size.height - 90 -64) / 3);
        
          make.left.mas_equalTo(11 * kScreenW / 320.0f);
          make.top.mas_equalTo(22 * kScreenH / 568.0f);
          make.width.mas_equalTo(195 * kScreenW / 320.0f);
          make.height.mas_equalTo(100 * kScreenH / 568.0f);
    }];
    
//    [myProductBtn setImage:[UIImage imageNamed:@"manage1"] forState:0];
  
    
    
    UIImageView *image1 = [UIImageView new];
    [myProductBtn addSubview:image1];
    [image1 setImage:[UIImage imageNamed:@"我的产品图标@2x-1"]];
    image1.contentMode = UIViewContentModeScaleAspectFit;
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45* kScreenH / 568.0f,45* kScreenH /568.0f));
        make.centerX.mas_equalTo(myProductBtn.centerX);
        make.centerY.mas_equalTo(myProductBtn.centerY);
    }];
    
    UILabel *labelai1 = [UILabel new];
    [myProductBtn addSubview:labelai1];
    labelai1.text = @"我的产品";
    labelai1.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
    labelai1.font =[UIFont systemFontOfSize:14 * kScreenH / 568.0f];
    labelai1.textAlignment = NSTextAlignmentCenter;
    [labelai1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(myProductBtn.mas_width);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(image1.mas_bottom).mas_equalTo(0);
    }];
    
    // 等待付款
//    WQFButton *waitePayBtn = [WQFButton new];
//    waitePayBtn.tag = 10002;
////    [waitePayBtn setImage:[UIImage imageNamed:@"等待付款"] forState:0];
//    [waitePayBtn setBackgroundColor:[UIColor colorWithRed:59/255.0 green:148/255.0 blue:150/255.0 alpha:1]];
//    [self.view addSubview:waitePayBtn];
//    
//    [waitePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(myProductBtn.mas_right).offset(0);
//        make.top.mas_equalTo(74);
//        make.right.mas_equalTo(self.view.mas_right).offset(-10);
//        make.height.mas_equalTo(205);
//    }];
    
    // 爱的利息-可兑换
    WQFButton *loveInterest = [WQFButton new];
    loveInterest.tag = 10004;
    [loveInterest setBackgroundColor:[UIColor colorWithRed:234/255.0 green:134/255.0 blue:150/255.0 alpha:1]];
    [topIV addSubview:loveInterest];
    
    [loveInterest mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.mas_equalTo(dealRecodBtn.mas_right).offset(10);
        make.top.mas_equalTo(myProductBtn.mas_top);
        make.right.mas_equalTo(-11 * kScreenW / 320.0);
        make.height.mas_equalTo(100 * kScreenH / 568.0f);
        make.left.mas_equalTo(myProductBtn.mas_right).mas_equalTo(11 * kScreenW / 320.0f);
    }];
    
    
    UIImageView *image4 = [UIImageView new];
    [loveInterest addSubview:image4];
    [image4 setImage:[UIImage imageNamed:@"keduihuan"]];
    [image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62 * kScreenH / 568.0f, 32 * kScreenH / 568.0f));
        make.centerX.mas_equalTo(loveInterest.centerX);
        make.centerY.mas_equalTo(loveInterest.centerY - 10);
    }];
    
    
    UILabel *labelai = [UILabel new];
    [loveInterest addSubview:labelai];
    labelai.text = @"爱的利息";
    labelai.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
;
    labelai.font =[UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    labelai.textAlignment = NSTextAlignmentCenter;
    [labelai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(loveInterest.mas_width);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(image4.mas_bottom).mas_equalTo(5);
    }];
   
    UILabel *labelai12 = [UILabel new];
    [loveInterest addSubview:labelai12];
    labelai12.text = @"(可兑换)";
    labelai12.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
;
    labelai12.font =[UIFont systemFontOfSize:13 *kScreenH / 568.0f];
    labelai12.textAlignment = NSTextAlignmentCenter;
    [labelai12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(loveInterest.mas_width);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(labelai.mas_bottom).mas_equalTo(2);
    }];

    
    
    
    
    
    
    
    // 交易记录
    WQFButton *dealRecodBtn = [WQFButton new];
    dealRecodBtn.tag = 10003;
    [topIV addSubview:dealRecodBtn];
    
    [dealRecodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(11 * kScreenW / 320.0f);
        make.top.mas_equalTo(myProductBtn.mas_bottom).offset(11 * kScreenH / 568.0f);
        make.width.mas_equalTo(92 * kScreenW / 320.0f);
        make.height.mas_equalTo(100 * kScreenH / 568.0f);
    }];
    [dealRecodBtn setBackgroundColor:[UIColor colorWithRed:121/255.0 green:109/255.0 blue:213/255.0 alpha:1]];
    
   
    UIImageView *image2 = [UIImageView new];
    [dealRecodBtn addSubview:image2];
    [image2 setImage:[UIImage imageNamed:@"jilu"]];
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45 * kScreenH / 568.0f, 30 * kScreenH / 568.0f));
        make.centerX.mas_equalTo(dealRecodBtn.centerX);
        make.centerY.mas_equalTo(dealRecodBtn.centerY);
    }];
    
    UILabel *labelai2 = [UILabel new];
    [dealRecodBtn addSubview:labelai2];
    labelai2.text = @"交易记录";
    labelai2.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
;
    labelai2.font =[UIFont systemFontOfSize:14 * kScreenH / 568.0f];
    labelai2.textAlignment = NSTextAlignmentCenter;
    [labelai2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(dealRecodBtn.mas_width);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(image2.mas_bottom).mas_equalTo(0);
    }];
    
    // 收货地址
    WQFButton *receiveBtn = [WQFButton new];
    receiveBtn.tag = 10005;
    [receiveBtn setBackgroundColor:[UIColor colorWithRed:121/255.0 green:109/255.0 blue:213/255.0 alpha:1]];
    [topIV addSubview:receiveBtn];
    [receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-11 * kScreenW / 320.0f);
        make.top.mas_equalTo(myProductBtn.mas_bottom).mas_equalTo(11 * kScreenH / 568.0f);
        make.width.mas_equalTo(loveInterest.mas_width);
        make.height.mas_equalTo(100 * kScreenH / 568.0f);
        receiveBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }];
    
    
    UIImageView *image3 = [UIImageView new];
    [receiveBtn addSubview:image3];
    [image3 setImage:[UIImage imageNamed:@"hidfhi"]];
    [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45 * kScreenH / 568.0f, 30 * kScreenH / 568.0f));
        make.centerX.mas_equalTo(receiveBtn.centerX);
        make.centerY.mas_equalTo(receiveBtn.centerY);
    }];
    
    UILabel *labelai3 = [UILabel new];
    [receiveBtn addSubview:labelai3];
    labelai3.text = @"收货地址";
    labelai3.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
;
    labelai3.font =[UIFont systemFontOfSize:14 * kScreenH / 568.0f];
    labelai3.textAlignment = NSTextAlignmentCenter;
    [labelai3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(receiveBtn.mas_width);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(image3.mas_bottom).mas_equalTo(0);
    }];
    
    
    // 爱的利息-已兑换
    WQFButton *loveInterest2 = [WQFButton new];
    loveInterest2.tag = 10006;
    [loveInterest2 setBackgroundColor:[UIColor colorWithRed:234/255.0 green:134/255.0 blue:150 / 255.0 alpha:1]];
    [topIV addSubview:loveInterest2];
    
    [loveInterest2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myProductBtn.mas_bottom).mas_equalTo(11 * kScreenH / 568.0f);
        make.width.mas_equalTo(receiveBtn.mas_width);
        make.height.mas_equalTo(100 * kScreenH / 568.0f);
        make.right.mas_equalTo(myProductBtn.mas_right);
    }];
        UIImageView *image5 = [UIImageView new];
    [loveInterest2 addSubview:image5];
    [image5 setImage:[UIImage imageNamed:@"hsdfkh"]];
    [image5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(62 * kScreenH / 568.0f, 34 * kScreenH / 568.0f));
        make.centerX.mas_equalTo(loveInterest2.centerX);
        make.centerY.mas_equalTo(loveInterest2.centerY).mas_equalTo(-10);
    }];
    
    UILabel *labelai4 = [UILabel new];
    [loveInterest2 addSubview:labelai4];
    labelai4.text = @"爱的利息";
    labelai4.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
;
    labelai4.font =[UIFont systemFontOfSize:13 *kScreenH / 568.0f];
    labelai4.textAlignment = NSTextAlignmentCenter;
    [labelai4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(loveInterest2.mas_width);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(image5.mas_bottom).mas_equalTo(5);
    }];
    
    UILabel *labelai42 = [UILabel new];
    [loveInterest2 addSubview:labelai42];
    labelai42.text = @"(已兑换)";
    labelai42.textColor = [UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:0.85];
;
    labelai42.font =[UIFont systemFontOfSize:13 *kScreenH / 568.0f];
    labelai42.textAlignment = NSTextAlignmentCenter;
    [labelai42 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(loveInterest2.mas_width);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(labelai4.mas_bottom).mas_equalTo(2);
    }];

    
    
    
    
    
    // 按钮的点击事件
    for (WQFButton *btn in topIV.subviews) {
        [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}


//点击按钮事件
- (void)clickButton :(UIButton *)btn{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"secretKey"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未登录账号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];

    }else{
        switch (btn.tag) {
            case 10001:
                NSLog(@"我的产品");
                [self.navigationController pushViewController:[MyProductVc new] animated:YES];
                break;
            case 10002:
                NSLog(@"等待付款");
                break;
            case 10003:
                NSLog(@"交易记录");
                [self.navigationController pushViewController:[DealRecodVc new] animated:YES];
                break;
            case 10004:
                NSLog(@"爱的利息");
                [self.navigationController pushViewController:[LoveInterestVc new] animated:YES];
                break;
            case 10005:
                NSLog(@"收货地址");
                [self.navigationController pushViewController:[AddressViewController new] animated:YES];
                break;
            case 10006:
                NSLog(@"爱的利息2");
                [self.navigationController pushViewController:[LoveInterestVc2 new] animated:YES];
                break;
                
        }

    }
    
    
}


@end

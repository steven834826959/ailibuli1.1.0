//
//  WQFTabBar.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/17.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "WQFTabBar.h"
#import "StatutVC.h"
#import "ProductVC.h"
#import "ServiceVC.h"
#import "ManageVC.h"
#import "MyVC.h"
#import "YTBasicServiceViewController.h"
#import "YTNavigationController.h"


@interface WQFTabBar ()<LoginDelegate,LogoutDelegate>
@property (nonatomic, strong) UIButton *selectedBtn;

@end

@implementation WQFTabBar

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[NSString stringWithFormat:@"%@",[defaults objectForKey:@"userLogin"]] isEqualToString:@"已登录"]) {
        [self creatTabBar];
        [self setupchildVcloginState:[defaults objectForKey:@"state"] riqi:[defaults objectForKey:@"riqi1"] riqi:[defaults objectForKey:@"riqi2"] bachelordom:nil iflogin:YES];
    }else {
        [self creatTabBar];
        [self setupchildVcloginState:nil riqi:nil riqi:nil bachelordom:nil iflogin:NO];
    }
}

- (void)Logout:(NSString *)logout{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[NSString stringWithFormat:@"%@",[defaults objectForKey:@"userLogin"]] isEqualToString:@"已登录"]) {
        [self creatTabBar];
        [self setupchildVcloginState:[defaults objectForKey:@"state"] riqi:[defaults objectForKey:@"riqi1"] riqi:[defaults objectForKey:@"riqi2"] bachelordom:nil iflogin:YES];
    }else {
        [self creatTabBar];
        [self setupchildVcloginState:nil riqi:nil riqi:nil bachelordom:nil iflogin:NO];
    }
    
        
}


//代理方法
- (void)loginState:(NSString *)state riqi:(NSString *)riqi1 riqi:(NSString *)riqi2 bachelordom:(NSString *)bac iflogin:(BOOL)login{
    
    [self setupchildVcloginState:state riqi:riqi1 riqi:riqi2 bachelordom:bac iflogin:login];

}

- (void)setupchildVcloginState:(NSString *)state riqi:(NSString *)riqi1 riqi:(NSString *)riqi2 bachelordom:(NSString *)bac iflogin:(BOOL)login{
 
    
    StatutVC *firstVC = [[StatutVC alloc]init];
    firstVC.state = state;
    firstVC.riqi1 = riqi1;
    firstVC.riqi2 = riqi2;
    firstVC.ifLogin = login;
    firstVC.bachelordom = bac;
    firstVC.delegate = self;
    
    YTNavigationController *firstNavC = [[YTNavigationController alloc]
                                         initWithRootViewController:firstVC];

    ProductVC *secondVC = [[ProductVC alloc]init];
    YTNavigationController *secondNavC = [[YTNavigationController alloc]initWithRootViewController:secondVC];
    
//    ServiceVC *thirdVC = [[ServiceVC alloc]init];
//    YTNavigationController *thirdNavC = [[YTNavigationController alloc]initWithRootViewController:thirdVC];
    
    
    YTBasicServiceViewController *thirdVC = [[YTBasicServiceViewController alloc]init];
    YTNavigationController *thirdNavC = [[YTNavigationController alloc]initWithRootViewController:thirdVC];
    
    
    
    
    
    ManageVC *fourthVC = [[ManageVC alloc]init];
    YTNavigationController *fourthNavC = [[YTNavigationController alloc]initWithRootViewController:fourthVC];
    
    MyVC *fifthVC = [[MyVC alloc]init];
    YTNavigationController *fifthNavC = [[YTNavigationController alloc]initWithRootViewController:fifthVC];
    fifthVC.delegate = self;
    
    [self setViewControllers:@[firstNavC,secondNavC,thirdNavC,fourthNavC,fifthNavC] animated:YES];
}


- (void)creatTabBar{
    //删除现有的tabBar
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];  //移除TabBarController自带的下部的条
    
    //测试添加自己的视图
    UIView *myView = [[UIView alloc] init];
    myView.frame = rect;
    
    UIImageView *backIV = [[UIImageView alloc]init];
    [backIV setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"标签栏"];
    backIV.image = image;
    backIV.userInteractionEnabled = YES;
    [myView addSubview:backIV];
    
    [self.view addSubview:myView];
    
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [[UIButton alloc]init];
        
         NSString *barImageName = [NSString stringWithFormat:@"barImage%d", i + 1];
        NSString *selectedIN = [NSString stringWithFormat:@"selectedBarIN%d",i+1];
        
        [btn setImage:[UIImage imageNamed:selectedIN] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:barImageName] forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeCenter;
        

        CGFloat x = i * myView.frame.size.width / 100 * 20.2;
        btn.frame = CGRectMake(x , 0, (myView.frame.size.width - myView.frame.size.width / 100 * 4) / 5, myView.frame.size.height);
        [myView addSubview:btn];
        btn.tag = i + 20160617;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图

        
        //带参数的监听方法记得加"冒号"
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置刚进入时,第一个按钮为选中状态
        if (0 == i) {
            btn.selected = YES;
            self.selectedBtn = btn;  //设置该按钮为选中的按钮
        }  
    }  

}

- (void)clickBtn:(UIButton *)button {
    
    // 1.先将之前选中的按钮设置为未选中
    self.selectedBtn.selected = NO;
    // 2.将之前选中的变为长色;
    [self.selectedBtn setBackgroundColor:[UIColor clearColor]];
    //3.再将当前按钮设置为选中
    button.selected = YES;
    //4.最后把当前按钮赋值为之前选中的按钮
    self.selectedBtn = button;
    //5.跳转到相应的视图控制器. (通过selectIndex参数来设置选中了那个控制器)
    self.selectedIndex = button.tag - 20160617;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

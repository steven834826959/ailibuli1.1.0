//
//  StatutVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "StatutVC.h"
#import "HiddenLine.h"
#import "RegisteredVC.h"
#import "ChooseView.h"
#import "WQFTabBar.h"
#import "SetStateVC.h"
#import "MijiVC.h"
#import <YYKit.h>

#import "UIImage+GIF.h"
#import "YTActivityViewController.h"
#import "YTForgetPwdViewController.h"
#import "YTActivityNewViewController.h"

#import "SetGenderVC.h"
#import "UIImage+YT.h"

@interface StatutVC ()<UITextFieldDelegate,ChooseViewDelegate,RegisteredVCDelegate>
@property (nonatomic, strong)UIImageView *statutImage;
@property (nonatomic, strong)UILabel *dateLabelUp;
@property (nonatomic, strong)UILabel *dateLabelDown;
@property (nonatomic, strong)UIView *controlView;
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIDatePicker *pick; 

@property (nonatomic, strong)NSMutableArray *mijiArr;
@property (nonatomic, strong)UIImageView *navChoose;

@property (nonatomic, strong)UILabel *zhuangtaiText;
@property (nonatomic, strong)UIImageView *yun;

@property(nonatomic,strong)UIButton *loginBtn;



//单身状态先关属性
@property(nonatomic,strong)UIButton *longeyDateBtn;


@property(nonatomic,strong)UILabel *view12Text;
@property(nonatomic,strong)UIView *viewDate2;
@property(nonatomic,strong)UIView *view12;


@property(nonatomic,copy)NSString *currentBachelordom;


//设置状态相关
@property(nonatomic,assign)BOOL setStates;
@property(nonatomic,assign)BOOL setGender;


@end

@implementation StatutVC

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
    
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    
     self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:49.0/255 green:178.0/255 blue:170.0/255 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    [self determineLogin];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.navigationItem setHidesBackButton:TRUE animated:NO];
    
   
   
}

#pragma mark - Registered代理方法
- (void)valuesBackToStatusVcWithUserName:(NSString *)userName password:(NSString *)password{
    
    self.accountText.text = userName;
    self.passWordText.text = password;

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:userName forKey:@"phone"];
    
    //保存手机号2
    [defaults setObject:userName forKey:@"phoneBackup"];
    
    
    [defaults synchronize];

    [NSThread sleepForTimeInterval:0.5];
    
    [self dengluRequest];
    
}
//背景图片
- (void)yunImage{
    self.yun = [UIImageView new];
    [_yun setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_yun setImage:[UIImage imageNamed:@"yun"]];
}




- (void)text{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [self.delegate loginState:self.state riqi:[defaults objectForKey:@"riqi1"] riqi:[defaults objectForKey:@"riqi2"] bachelordom:nil iflogin:YES];
    
}

//日期格式
- (NSString *)riqi{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[NSDateFormatter new];
    [dateformatter setDateFormat:@"YYYY.MM.dd"];
    return [dateformatter stringFromDate:senddate];
}


- (void)determineLogin{

    if (self.ifLogin) {
  
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.state = [defaults objectForKey:@"state"];
     
        if (self.state.length  > 0) {
                if ([@"single" isEqualToString:[defaults objectForKey:@"state"]]){
                    self.state = @"单身";
                }else if ([@"inLove" isEqualToString:[defaults objectForKey:@"state"]]){
                    self.state = @"恋爱";
                }else if ([@"married" isEqualToString:[defaults objectForKey:@"state"]]){
                    self.state = @"已婚";
                }
                
                self.navigationItem.title = [NSString stringWithFormat:@"您的状态 - %@", self.state];
                self.bachelordom = [defaults objectForKey:@"bachelordom"];
                [self requeststatemiji];
        }else{
            SetStateVC *set = [SetStateVC new];
            [self.navigationController pushViewController:set animated:NO];
        }
    }else{
        self.navigationItem.title = @"登录";
        [self createLogin];
    }
    
}
- (void)requeststatemiji{
    
   
    
    self.mijiArr = [NSMutableArray array];
    NSString *url = [NSString new];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"state"] isEqualToString:@"恋爱"] || [[defaults objectForKey:@"state"] isEqualToString:@"inLove"]) {
        url = @"inLove";
        
    }else if ([[defaults objectForKey:@"state"] isEqualToString:@"单身"] || [[defaults objectForKey:@"state"] isEqualToString:@"single"]) {
        url = @"single";
    }else if ([[defaults objectForKey:@"state"] isEqualToString:@"已婚"] || [[defaults objectForKey:@"state"] isEqualToString:@"married	"]) {
        url = @"married";
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:@"http://mapi.loveyongtong.com/long/secretList" parameters:@{@"key":url}  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     NSMutableArray *arr = [responseObject objectForKey:@"data"];
     self.mijiArr = arr;
        
      [self creatState];

 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
     NSLog(@"%@",error);
     [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
     UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
     UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
     [alert addAction:action];
     [self presentViewController:alert animated:YES completion:nil];

 }];
  
    
    
}


//界面视图
- (void)creatState{
   //背景图
    self.yun = [UIImageView new];
    [_yun setFrame:CGRectMake(0, -1, self.view.frame.size.width, self.view.frame.size.height)];
    [_yun setImage:[UIImage imageNamed:@"背景@2x-1"]];
    UIImageView *topIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"上背景"];
    topIV.image = image;
    [self.yun addSubview:topIV];
    
    self.yun.userInteractionEnabled = YES;
    [self.view addSubview:_yun];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.frame = CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height -49 - 2);
    // frame中的size指UIScrollView的可视范围
     self.scrollView.backgroundColor = [UIColor clearColor];
    [self.yun addSubview: self.scrollView];
    
     self.scrollView.contentSize = CGSizeMake(0, self.view.frame.size.height);
    //  隐藏水平滚动条
     self.scrollView.showsVerticalScrollIndicator = NO;
    //  去掉弹簧效果
     self.scrollView.bounces = YES;
    
    //上部背景图
    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 121)];
    [view1 setBackgroundColor:[UIColor clearColor]];
    [self.scrollView addSubview:view1];

    //恋爱日期
    UIView *view11 = [UIView new];
    [view11 setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    
    [view1 addSubview:view11];
    [view11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(25);
        make.bottom.mas_equalTo(-65);
        make.width.mas_equalTo(70);
        
    }];
    //对象生日
    UIView *view12 = [UIView new];
    self.view12 = view12;
    [view12 setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    [view1 addSubview:view12];
    [view12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65);
        make.left.mas_equalTo(25);
        make.bottom.mas_equalTo(-25);
        make.width.mas_equalTo(70);
    }];
    UILabel *view11Text = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, 60, 10)];
    view11Text.textColor = [UIColor whiteColor];
    if ([self.state isEqualToString:@"恋爱"]) {
        view11Text.text = @"恋爱日期";
    }else if ([self.state isEqualToString:@"单身"]) {
        view11Text.text = @"是否恋过";
    }else if ([self.state isEqualToString:@"已婚"]) {
        view11Text.text = @"结婚日期";
    }
    [view11Text setFont:[UIFont systemFontOfSize:14]];
    [view11 addSubview:view11Text];
    
    UILabel *view12Text = [[UILabel alloc]initWithFrame:CGRectMake(6, 10, 60, 10)];
    self.view12Text = view12Text;
    if ([self.state isEqualToString:@"恋爱"]) {
        view12Text.text = @"对象生日";
    }else if ([self.state isEqualToString:@"单身"]) {
        //判断是否恋爱过
        view12Text.text = @"分手日期";
        
    }else if ([self.state isEqualToString:@"已婚"]) {
        view12Text.text = @"配偶生日";
    }
    view12Text.textColor = [UIColor whiteColor];
    [view12Text setFont:[UIFont systemFontOfSize:14]];
    [view12 addSubview:view12Text];
    
    
//日期视图
    UIView *viewDate = [UIView new];
    [viewDate setBackgroundColor:[UIColor colorWithRed:131.0/255 green:126.0/255 blue:181.0/255 alpha:1]];
    [view1 addSubview:viewDate];
    [viewDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view11.mas_top);
        make.bottom.mas_equalTo(view11.mas_bottom);
        make.left.mas_equalTo(view11.mas_right).offset(0);
        make.right.mas_equalTo(-50);
    }];
    
    UIView *viewDate2 = [UIView new];
    self.viewDate2 = viewDate2;
    [viewDate2 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:126.0/255 blue:181.0/255 alpha:1]];
    [view1 addSubview:viewDate2];
    [viewDate2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view12.mas_top);
        make.bottom.mas_equalTo(view12.mas_bottom);
        make.left.mas_equalTo(view12.mas_right).offset(0);
        make.right.mas_equalTo(-50);
    }];
    
    //日期右边的三角按钮
    UIButton *btnUp = [UIButton new];
    [view1 addSubview:btnUp];
    [btnUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view11.mas_top);
        make.bottom.mas_equalTo(view11.mas_bottom);
        make.left.mas_equalTo(view11.mas_right).offset(2.5);
        make.right.mas_equalTo(-50);
    }];
    [btnUp addTarget:self action:@selector(riqiChoose) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btnDown = [UIButton new];
    [view1 addSubview:btnDown];
    [btnDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view12.mas_top);
        make.bottom.mas_equalTo(view12.mas_bottom);
        make.left.mas_equalTo(view12.mas_right).offset(0);
        make.right.mas_equalTo(-50);
    }];
    [btnDown addTarget:self action:@selector(riqiChoose1) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *buttonUp = [UIButton new];
    //    [buttonUp setBackgroundColor:[UIColor colorWithRed:134.0 / 255 green:128.0 / 255 blue:165.0/255 alpha:1]];
    [view1 addSubview:buttonUp];
    [buttonUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view11.mas_top);
        make.bottom.mas_equalTo(view11.mas_bottom);
        make.left.mas_equalTo(viewDate.mas_right).offset(0);
        make.width.mas_equalTo(25);
    }];
    [buttonUp setImage:[UIImage imageNamed:@"状态向下紫"] forState:UIControlStateNormal];
    [buttonUp addTarget:self action:@selector(riqiChoose) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *buttonDown = [UIButton new];
    
    [view1 addSubview:buttonDown];
    [buttonDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view12.mas_top);
        make.bottom.mas_equalTo(view12.mas_bottom);
        make.left.mas_equalTo(viewDate.mas_right).offset(0);
        make.width.mas_equalTo(25);
    }];
    [buttonDown setImage:[UIImage imageNamed:@"状态向下紫"] forState:UIControlStateNormal];
    [buttonDown addTarget:self action:@selector(riqiChoose1) forControlEvents:UIControlEventTouchUpInside];
    self.longeyDateBtn = buttonDown;
    
    self.dateLabelUp  = [UILabel new];
    [self.dateLabelUp setTextColor:[UIColor whiteColor]];
    self.dateLabelUp.textAlignment = NSTextAlignmentCenter;
    [self.dateLabelUp setFont:[UIFont systemFontOfSize:18]];
    [view1 addSubview:self.dateLabelUp];
    
    if ([self.state isEqualToString:@"单身"]) {
        self.dateLabelUp.text = self.bachelordom ? self.bachelordom : @"否";
        
        
    }else {
        //设置分手日期
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDateFormatter *inputFormatter= [NSDateFormatter new];
        
        [inputFormatter setDateFormat:@"yyyy.MM.dd"];
        NSString *date = [inputFormatter stringFromDate:[NSDate date]];
        
        
        //如果沙盒为(null)且riqi1为空
        if ([[defaults objectForKey:@"riqi1"] isEqualToString:@"(null)"] && [self.riqi1 isEqualToString:@"(null)"]) {
            
            self.dateLabelUp.text = date;
            
        }else if(![[defaults objectForKey:@"riqi1"] isEqualToString:@"(null)"] && [self.riqi1 isEqualToString:@"(null)"]){
            //如果沙盒不为(null)且riqi1为空
            self.dateLabelUp.text = [defaults objectForKey:@"riqi1"];
            
        }else if(self.riqi1.length != 0){
            self.dateLabelUp.text = self.riqi1;
        }
//        self.dateLabelUp.text = _riqi1 ? _riqi1 : ([defaults objectForKey:@"riqi1"] ? [defaults objectForKey:@"riqi1"] :date);
        
    }

    [self.dateLabelUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view11.mas_top);
        make.bottom.mas_equalTo(view11.mas_bottom);
        make.left.mas_equalTo(view11.mas_right).offset(2.5);
        make.right.mas_equalTo(-50);

    }];

    
    self.dateLabelDown  = [UILabel new];
    [self.dateLabelDown setTextColor:[UIColor whiteColor]];
//    self.dateLabelDown.text = _riqi2;

    if ([self.currentBachelordom isEqualToString:@"否"]) {
        self.dateLabelDown.text = @"";
        
        view12Text.hidden = YES;
        viewDate2.hidden = YES;
        view12.hidden = YES;
        buttonDown.hidden = YES;
        buttonDown.enabled = NO;
        btnDown.enabled = NO;
        
    }else{
        
        //设置 日期
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDateFormatter *inputFormatter= [NSDateFormatter new];
        
        [inputFormatter setDateFormat:@"yyyy.MM.dd"];
        NSString *date = [inputFormatter stringFromDate:[NSDate date]];

        //如果沙盒为(null)且riqi2为空
        if ([[defaults objectForKey:@"riqi2"] isEqualToString:@"(null)"] && [self.riqi2 isEqualToString:@"(null)"]) {
            
            self.dateLabelDown.text = date;
            
        }else if(![[defaults objectForKey:@"riqi2"] isEqualToString:@"(null)"] && [self.riqi2 isEqualToString:@"(null)"]){
            //如果沙盒不为(null)且riqi1为空
            self.dateLabelDown.text = [defaults objectForKey:@"riqi2"];
        
        }else if(self.riqi2.length != 0){
            
            self.dateLabelDown.text = self.riqi2;
            
        }
        
        NSLog(@"................................................................................................................................................................................................................................................................................................%@,%@",self.riqi1,self.riqi2);
//        self.dateLabelDown.text = _riqi2 ? _riqi2 : ([defaults objectForKey:@"riqi2"] ? [defaults objectForKey:@"riqi1"] : date);
        
        view12Text.hidden = NO;
        viewDate2.hidden = NO;
        view12.hidden = NO;
        buttonDown.hidden = NO;
        
        buttonDown.enabled = YES;
        btnDown.enabled = YES;
        
    }
    
    self.dateLabelDown.textAlignment = NSTextAlignmentCenter;
    [self.dateLabelDown setFont:[UIFont systemFontOfSize:18]];
    [view1 addSubview:self.dateLabelDown];
    [self.dateLabelDown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view12.mas_top);
        make.bottom.mas_equalTo(view12.mas_bottom);
        make.left.mas_equalTo(view12.mas_right).offset(0);
        make.right.mas_equalTo(-50);
    }];
    
   
    
    
   
 
  
    
    
    
    
    
    
    
  // ---------------------------------------------------------------//
    
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 121, self.view.frame.size.width,150)];
    [ self.scrollView addSubview:view2];
    
    UIImageView *imageText = [UIImageView new];
    imageText.userInteractionEnabled = YES;
    imageText.layer.cornerRadius = 5;
    imageText.layer.masksToBounds = YES;

    [imageText setImage:[UIImage imageNamed:@"首页大图"]];
    [imageText setBackgroundColor:[UIColor clearColor]];
    [view2 addSubview:imageText];
    [imageText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-25);
        make.left.mas_equalTo(100);
    }];
  //敲击跳转到活动页
    UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(statusTaped)];
    [imageText addGestureRecognizer:iconTap];
    
    
 
    //欢迎使用爱理不离
    self.zhuangtaiText = [UILabel new];
//    [view2 addSubview:self.zhuangtaiText];
//    [self.zhuangtaiText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(30);
//        make.right.mas_equalTo(-25);
//        make.bottom.mas_equalTo(-30);
//        make.left.mas_equalTo(115);
//    }];
//   
    [self.zhuangtaiText setFont:[UIFont systemFontOfSize:15]];
    self.zhuangtaiText.numberOfLines = 0;
    [self.zhuangtaiText setTextColor:[UIColor whiteColor]];
    
    [self sysuserLoveStatusList];

    
    
    self.statutImage = [UIImageView new];
//    [self.statutImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@状态",self.state]]];
     [self.statutImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"iconc"]]];
    
    [view2 addSubview:self.statutImage];
    [self.statutImage mas_makeConstraints:^(MASConstraintMaker *make) {
        // 添加大小约束
//        if ([self.state isEqualToString:@"恋爱"]) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.top.mas_equalTo(25);
            make.left.mas_equalTo(20);
//        }else if ([self.state isEqualToString:@"单身"]) {
//            make.size.mas_equalTo(CGSizeMake(110, 105));
//            make.top.mas_equalTo(15);
//            make.right.mas_equalTo(-20);
//        }else if ([self.state isEqualToString:@"已婚"]) {
//            make.size.mas_equalTo(CGSizeMake(70, 115));
//            make.top.mas_equalTo(15);
//            make.right.mas_equalTo(-20);
//        }

       
        
    }];
    
 // --------------------------------------------------------------//
    
    
    
    UIImageView *view3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, view2.frame.origin.y + view2.frame.size.height, self.view.frame.size.width, 30)];
    [view3 setBackgroundColor:[UIColor colorWithRed:181.0/255 green:117.0 / 255 blue:147.0/255 alpha:1]];
    [ self.scrollView addSubview:view3];
    
    UIImageView *view4 = [[UIImageView alloc]initWithFrame:CGRectMake(0, view3.frame.origin.y + view3.frame.size.height, self.view.frame.size.width, 20)];
    [view4 setBackgroundColor:[UIColor colorWithRed:72.0/ 255 green:65.0 / 255 blue:106.0 / 255 alpha:1]];
    [ self.scrollView addSubview:view4];
    
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:view3.frame];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    label3.font = [UIFont systemFontOfSize:14];
    label3.textColor = [UIColor whiteColor];
    [ self.scrollView addSubview:label3];
    
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:view4.frame];
    label4.backgroundColor = [UIColor colorWithRed:131 / 255.0 green:127 / 255.0 blue:179 / 255.0 alpha:1];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = [UIFont systemFontOfSize:13];
    label4.textColor = [UIColor whiteColor];
    [ self.scrollView addSubview:label4];
    
    
    if ([self.state isEqualToString:@"恋爱"]) {
       label3.text = @"守爱侠助您维系恋爱关系";
    }else if ([self.state isEqualToString:@"单身"]) {
        label3.text = @"爱你妹帮你搞定两性健康关系";
    }else if ([self.state isEqualToString:@"已婚"]) {
        label3.text = @"潘多拉守护关系";
    }
    
    
    if ([self.state isEqualToString:@"恋爱"]) {
        label4.text = @"T I P S 表白秘诀";
    }else if ([self.state isEqualToString:@"单身"]) {
        label4.text = @"T I P S 脱单大法";
    }else if ([self.state isEqualToString:@"已婚"]) {
        label4.text = @"T I P S 婚姻保鲜";
    }

    for (int i = 0; i<self.mijiArr.count; i++) {
        UIButton *button = [UIButton new];
        [button setFrame:CGRectMake(25, view4.frame.origin.y + view4.frame.size.height + i * 40 + 1, self.view.frame.size.width - 50, 40)];
        
        [button setTitle:[[self.mijiArr objectAtIndex:i]objectForKey:@"title"] forState:UIControlStateNormal];
        [self.scrollView addSubview:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [button setTag:201607210 + i];
        [button addTarget:self action:@selector(miji:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIView *btnline = [UIView new];
        [btnline setFrame:CGRectMake(0, button.frame.origin.y + 40, self.view.frame.size.width, 1.2)];
        [btnline setBackgroundColor:[UIColor whiteColor]];
        btnline.alpha = .4;
        [self.scrollView addSubview:btnline];
    }
    
    self.scrollView.contentSize = CGSizeMake(self.view.size.width, 40 * self.mijiArr.count + 340);

    
}
- (void)miji:(UIButton *)btn{
    
    
    self.navChoose.image = [UIImage imageNamed:@""];
    
    MijiVC *miji = [MijiVC new];
    
    miji.idd = [[self.mijiArr objectAtIndex:btn.tag - 201607210]objectForKey:@"_id"];
    miji.titlea = [[self.mijiArr objectAtIndex:btn.tag - 201607210]objectForKey:@"title"];
    
    
    self.navChoose.hidden = YES;
    
    
    
    [self.navigationController pushViewController:miji animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    self.navChoose.hidden = YES;

}

- (void)navChooseState{
    
    [self createChooseView:@"1"];
}

- (void)riqiChoose{
    [self createChooseView:@"2"];
}
- (void)riqiChoose1{
    [self createChooseView:@"3"];
}

- (void)createChooseView:(NSString *)str{
    
    self.controlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.controlView setBackgroundColor:[UIColor clearColor]];
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self.controlView];
    
    UIView *aView = [UIView new];
    [aView setFrame:CGRectMake(25 , kScreenH / 3.5, kScreenW - 50 , 200)];
    
    [aView setBackgroundColor:[UIColor colorWithRed:90.0 /255 green:86.0 /255 blue:132.0 /255 alpha:1.0]];
    [self.controlView addSubview:aView];
    
    if ([str isEqualToString:@"1"]) {
   
        ChooseView *choooseView = [ChooseView new];
        [choooseView setFrame:CGRectMake(0, 0, kScreenW - 50, 150)];
        choooseView.type = @"1";
        choooseView.state = self.state;
        choooseView.delegate = self;
        [choooseView createView];
        aView.backgroundColor = [UIColor colorWithRed:90/255.0 green:85/255.0 blue:133/255.0 alpha:1];
        [aView addSubview:choooseView];
    }
    
    if ([str isEqualToString:@"2"]&&[self.state isEqualToString:@"单身"]) {
        [aView setFrame:CGRectMake(25, kScreenH / 3.5 + 50, kScreenW - 50 , 150)];
        ChooseView *choooseView = [ChooseView new];
        [choooseView setFrame:CGRectMake(0, 0, kScreenW - 50, 100)];
        choooseView.type = @"2";
        choooseView.bachelordom =  self.bachelordom ;
        choooseView.state = self.state;
        choooseView.delegate = self;
        [choooseView createView];
        [aView addSubview:choooseView];
        
    }else if ([str isEqualToString:@"3"] || [str isEqualToString:@"2"]){
        self.pick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kScreenW - 50, 175)];
        [self.pick setDatePickerMode:UIDatePickerModeDate];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        self.pick.locale = locale;
        [aView addSubview:self.pick];
        
        if ([str isEqualToString:@"2"]) {
            NSDateFormatter *inputFormatter= [NSDateFormatter new];
            [inputFormatter setLocale:locale];
            [inputFormatter setDateFormat:@"yyyy.MM.dd"];
            if ([_riqi1 isEqualToString:@"(null)"]) {
                NSDate *inputDate = [inputFormatter dateFromString:@"2016.08.08"];
                [self.pick setDate:inputDate ? inputDate : [NSDate date] animated:NO];

            }else{
                NSDate *inputDate = [inputFormatter dateFromString:_riqi1];
                [self.pick setDate:inputDate ? inputDate :[NSDate date] animated:YES];
            }
            [self.pick addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];

        }else if([str isEqualToString:@"3"]){
            NSDateFormatter *inputFormatter= [NSDateFormatter new];
            [inputFormatter setLocale:locale];
            [inputFormatter setDateFormat:@"yyyy.MM.dd"];
            if ([_riqi2 isEqualToString:@"(null)"]) {
                NSDate *inputDate = [inputFormatter dateFromString:@"2016.08.08"];
                [self.pick setDate:inputDate ? inputDate : [NSDate date] animated:NO];
                
            }else{
                NSLog(@"--------%@",self.riqi2);
                NSDate *inputDate = [inputFormatter dateFromString:_riqi2];
                [self.pick setDate:inputDate ? inputDate : [NSDate date] animated:NO];
            }
            [self.pick addTarget:self action:@selector(dateChanged2) forControlEvents:UIControlEventValueChanged];
                   }
    }
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, aView.frame.size.height - 25, aView.frame.size.width, 30 * kScreenH / 568.0f)];
    imageView.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    imageView.userInteractionEnabled = YES;
    [aView addSubview:imageView];
    
    UIButton *quxiao = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30 * kScreenH / 568.0f)];
    [imageView addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao.titleLabel setFont:[UIFont systemFontOfSize:13 *kScreenH / 568.0f]];
    
    UIButton *queding = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width - 50, 0, 50, 30 * kScreenH / 568.0f)];
    [imageView addSubview:queding];
    [queding.titleLabel setFont:[UIFont systemFontOfSize:13 * kScreenH / 568.0f]];
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    
    [quxiao addTarget:self action:@selector(quxiaoButton) forControlEvents:UIControlEventTouchUpInside];
    [queding addTarget:self action:@selector(quedingButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)dateChanged{
    if ([self.pick date] == nil) {
        
    }else{
    NSDate *pickerDate = [self.pick date];
    NSDateFormatter *pickerFormatter =[NSDateFormatter new];
    [pickerFormatter setDateFormat:@"yyyy.MM.dd"];
    self.riqi1 = [pickerFormatter stringFromDate:pickerDate];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([self.state isEqualToString:@"单身"]) {
            [defaults setValue:self.bachelordom forKey:@"bachelordom"];
            [defaults synchronize];
        }else{
            [defaults setValue:self.riqi1 forKey:@"riqi1"];
            [defaults synchronize];

        }
    }
    
}
- (void)dateChanged2{
    if ([self.pick date] == nil) {
        
    }else{
    NSDate *pickerDate = [self.pick date];
    NSDateFormatter *pickerFormatter =[NSDateFormatter new];
    [pickerFormatter setDateFormat:@"yyyy.MM.dd"];
    
    self.riqi2 = [pickerFormatter stringFromDate:pickerDate];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:self.riqi2 forKey:@"riqi2"];
        [defaults synchronize];

    }
}

- (void)quxiaoButton{
    [self.controlView removeFromSuperview];
}
- (void)quedingButton{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.state  = [defaults objectForKey:@"state"];

    if ([self.state isEqualToString:@"恋爱"]) {
   
        [self uploadInformation:@{@"loveStatus":@"inLove"}];
        [self uploadInformation:@{@"isLove":@1}];
        [self uploadInformation:@{@"loverDetails":@{@"islove":@1,@"loveDate":[[defaults objectForKey:@"riqi1"] stringByReplacingOccurrencesOfString:@"." withString:@"-"],@"loverBirthday":[[defaults objectForKey:@"riqi2"] stringByReplacingOccurrencesOfString:@"." withString:@"-"]}}];

           self.currentBachelordom = @"是";
        
    }else if([self.state isEqualToString:@"单身"]) {
        if ([[defaults objectForKey:@"bachelordom"] isEqualToString:@"是"]) {
            
            self.longeyDateBtn.enabled = YES;
            self.currentBachelordom = @"是";
            [self uploadInformation:@{@"loverDetails":@{@"islove":@1,@"overDate":[[defaults objectForKey:@"riqi2"]stringByReplacingOccurrencesOfString:@"." withString:@"-" ]}}];
        }else{
            
            [defaults setObject:@"否" forKey:@"bachelordom"];
            self.currentBachelordom = @"否";
            
            [self uploadInformation:@{@"isLove":@0}];
             [self uploadInformation:@{@"loverDetails":@{@"islove":@0,@"overDate":[[defaults objectForKey:@"riqi2"]stringByReplacingOccurrencesOfString:@"." withString:@"-" ]}}];
        }
        
        [self uploadInformation:@{@"loveStatus":@"single"}];
        
        [defaults setObject:self.bachelordom forKey:@"bachelordom"];
        [defaults synchronize];
        
        
    }else if([self.state isEqualToString:@"已婚"]) {

        [self uploadInformation:@{@"loveStatus":@"married"}];
        
        [self uploadInformation:@{@"loverDetails":@{@"islove":@1,@"marriedDate":[[defaults objectForKey:@"riqi1"] stringByReplacingOccurrencesOfString:@"." withString:@"-"],@"loverBirthday":[[defaults objectForKey:@"riqi2"] stringByReplacingOccurrencesOfString:@"." withString:@"-"]}}];

        self.currentBachelordom = @"是";
        
    }
    [self.controlView removeFromSuperview];
    [self.scrollView removeFromSuperview];
    [self determineLogin];
    [self.scrollView setFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64 -49 - 2)];
    
 
}

- (void)sendState:(NSString *)str{
    self.state = str;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:@"state"];
    [defaults synchronize];

}

- (void)sendBachelordom:(NSString *)str{
    
    self.bachelordom = str;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:@"bachelordom"];
    [defaults synchronize];
    NSLog(@"%@",str);
}




- (void)createLogin{
 
    UIView *boxView = [UIView new];
    [boxView setBackgroundColor:[UIColor colorWithRed:96.0/255 green:93.0/255 blue:121.0/255 alpha:1]];
    [self.view addSubview:boxView];
    // 给黑色view添加约束
    [boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        // 添加大小约束
        make.top.mas_equalTo(32 * kScreenH / 568.0f );
        make.left.mas_equalTo(43 * kScreenW / 320.0f);
        make.right.mas_equalTo(-43 *kScreenW / 320.0f);
        make.bottom.mas_equalTo(-80 * kScreenH / 568.0f );
    }];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
    
    //头像View
    UIImageView *headImage = [UIImageView new];
    [headImage setImage:[UIImage imageNamed:@"头像"]];
    [boxView addSubview:headImage];
    [headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.top.mas_equalTo(20);
//        make.left.mas_equalTo(-20);
        
        
        make.size.mas_equalTo(CGSizeMake(100 * kScreenH / 568.0f, 100 * kScreenH / 568.0f ));
        
        make.top.mas_equalTo(18 * kScreenH /568.0f * 0.5);
        make.left.mas_equalTo(-26 * kScreenW /320.0f * 0.5);

    }];
    
    UILabel *aLabel = [UILabel new];
    [aLabel setText:@"登录"];
    [aLabel setTextColor:[UIColor whiteColor]];
    [aLabel setFont:[UIFont systemFontOfSize:14 * (kScreenH / 568.0f)]];
    
    
    
    NSLog(@"--------尺寸");
    NSLog(@"%lf",kScreenH);
    
    [boxView addSubview:aLabel];
    [aLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(30, 10));
//        make.left.mas_equalTo(headImage.mas_right).offset(40);
//        make.top.mas_equalTo(100);
        
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.left.mas_equalTo(headImage.mas_right).offset(40 * kScreenW / 320.0f);
        make.bottom.mas_equalTo(headImage.mas_bottom);

    }];
    
    UILabel *bLabel = [UILabel new];
    [bLabel setText:@"注册"];
    [bLabel setTextColor:[UIColor colorWithRed:118.0/255 green:118.0/255 blue:118.0/255 alpha:1.0]];
    [bLabel setFont:[UIFont systemFontOfSize:14 * (kScreenH / 568.0f)]];
    [boxView addSubview:bLabel];
    [bLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.mas_equalTo(-25 * kScreenW / 320.0f);
        make.bottom.mas_equalTo(headImage.mas_bottom);
 
    }];
    
    
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    [bLabel addSubview:button];
    [button addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [bLabel setUserInteractionEnabled:YES];

    
    //下边登录框
    UIView *boxview2 = [UIView new];
    [boxView addSubview:boxview2];
    [boxview2 setBackgroundColor:[UIColor colorWithRed:75.0/255 green:72.0/255 blue:77.0/255 alpha:1]];
    [boxview2 mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.mas_equalTo(headImage.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
  
    }];
    
    UIImageView *yonghuImage = [UIImageView new];
    [boxview2 addSubview:yonghuImage];
    [yonghuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f ,30 * kScreenH / 568.0f));
    }];
    yonghuImage.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    [yonghuImage setImage:[UIImage imageNamed:@"用户new"]];
    
    self.accountText = [UITextField new];
    
    //数字键盘
    self.accountText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.accountText.textColor = [UIColor whiteColor];
    [boxview2 addSubview:_accountText];

    [self.accountText mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(30);
//        make.left.mas_equalTo(53);
//        make.right.mas_equalTo(-23);
//        make.height.mas_equalTo(30);
        
        make.top.mas_equalTo(24 * kScreenH / 568.0f);
        make.left.mas_equalTo(yonghuImage.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    [_accountText setBackgroundColor:[UIColor colorWithRed:123.0/255 green:121.0/255 blue:153.0/255 alpha:1]];
    _accountText.delegate = self;
    [_accountText setPlaceholder:@" 请输入您的手机号"];
    [_accountText setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_accountText setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
    UIImageView *mimaImage = [UIImageView new];
    [boxview2 addSubview:mimaImage];
    [mimaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(65 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    mimaImage.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    [mimaImage setImage:[UIImage imageNamed:@"密码new"]];

  
    self.passWordText = [UITextField new];
    [boxview2 addSubview:_passWordText];
    self.passWordText.textColor = [UIColor whiteColor];

    
    [self.passWordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mimaImage.mas_top);
        make.left.mas_equalTo(mimaImage.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    _passWordText.delegate = self;
    
    [_passWordText setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_passWordText setBackgroundColor:[UIColor colorWithRed:123.0/255 green:121.0/255 blue:153.0/255 alpha:1]];
    [_passWordText setPlaceholder:@" 请输入您的密码"];
    [_passWordText setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passWordText.secureTextEntry = YES;
    

    
    //监听TF
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.accountText];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledChanged) name:UITextFieldTextDidChangeNotification object:self.passWordText];
    
    //忘记密码按钮
    UIButton *forgetPWD = [[UIButton alloc]init];
    [boxview2 addSubview:forgetPWD];
    
    //隐藏忘记密码按钮
//    forgetPWD.hidden = YES;
    [forgetPWD setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPWD setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    forgetPWD.font = [UIFont systemFontOfSize:10 * kScreenH / 568.0f];
    
    [forgetPWD addTarget:self action:@selector(forgetPwdAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [forgetPWD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100 * kScreenH / 568.0f);
        make.right.mas_equalTo(_passWordText.mas_right);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
    
    
    //创建公告view
    UIView *adView = [[UIView alloc]init];
    adView.backgroundColor = [UIColor greenColor];
    [boxview2 addSubview:adView];
    [adView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_accountText.mas_right);
        make.left.mas_equalTo(yonghuImage.mas_left);
        make.top.mas_equalTo(self.passWordText.mas_bottom).mas_equalTo(30 * kScreenH / 568.0f);
        make.height.mas_equalTo(100 * kScreenH / 568.0f);
    }];

    UIButton *denglu = [UIButton new];
    [boxview2 addSubview:denglu];
    
    self.loginBtn = denglu;
    
    self.loginBtn.enabled = NO;
    
    [denglu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        make.top.mas_equalTo(adView.mas_bottom).mas_equalTo(16 * kScreenH / 568.0f);
        
    }];
    
    UIImageView *gifView = [[UIImageView alloc]init];
    [adView addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
//    NSString  *name = @"合成-3.gif";
//    
//    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
//    
//    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    
    
    //加载gif图片
    gifView.image = [UIImage imageNamed:@"登录大图"];
    
//    gifView.backgroundColor = [UIColor clearColor];
//    
//    gifView.image = [UIImage sd_animatedGIFWithData:imageData];
//    

    
    
    //添加敲击事件
    UITapGestureRecognizer *gitTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gifTaped)];
    [gifView addGestureRecognizer:gitTap];
    gifView.userInteractionEnabled = YES;
    
    [denglu setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    [denglu addTarget:self action:@selector(denglu) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *denglulabel = [UILabel new];
    [denglu addSubview:denglulabel];
    [denglulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    denglulabel.textColor = [UIColor whiteColor];
    denglulabel.text = @"立即登录";
    denglulabel.textAlignment = NSTextAlignmentCenter;
    denglulabel.font = [UIFont systemFontOfSize:15];

}

//忘记密码
- (void)forgetPwdAction{
    
    YTForgetPwdViewController *f = [[YTForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:f animated:YES];



}







//敲击方法
- (void)gifTaped{
//    YTActivityViewController *activity = [YTActivityViewController sharedSingleton];
//    
//    self.navChoose.hidden = YES;
//
//    [self.navigationController pushViewController:activity animated:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];


}

- (void)textFiledChanged{

    self.loginBtn.enabled =  (self.accountText.text.length > 0 && self.passWordText.text.length > 0) ? YES : NO;
    
}




- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reKeyBoard
{
    [self.accountText resignFirstResponder];
    [self.passWordText resignFirstResponder];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == _accountText){
        self.text1 =_accountText.text;
    }
    if (textField == _passWordText) {
        self.text2 = _passWordText.text ;
    }
    
}

- (void)denglu{
    
    [self.accountText resignFirstResponder];
    [self.passWordText resignFirstResponder];
    
    if (self.text1.length == 0 || self.text2.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入信息" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        [self dengluRequest];

    }
    
    
}
- (void)dengluRequest{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue :@"miyao"forHTTPHeaderField:@"Content-Type"];

    [manager POST:@"http://mapi.loveyongtong.com/sysuser/login" parameters:@{@"uid":self.accountText.text,@"pwd":self.passWordText.text,@"tm":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        NSLog(@"---------登录请求的dic%@",dic);
        
        NSString *str2 = [[dic objectForKey:@"desc"] stringByRemovingPercentEncoding];
        
        if ([str2 isEqualToString:@"request data succesfully![登录成功！]"]) {
            
            if( [[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]length] == 0  ){
                
                NSString *stateStr = [[dic objectForKey:@"data"] objectForKey:@"loveStatus"];
        
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     
                //保存手机号
                [defaults setObject:_accountText.text forKey:@"phone"];
                
                //保存手机号2
                [defaults setObject:_accountText.text forKey:@"phoneBackup"];
                
                [defaults setObject:@"已登录"forKey:@"userLogin"];
                [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"loveStatus"] forKey:@"state"];
                [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"secretKey"] forKey:@"secretKey"];
                [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"sessionid"] forKey:@"sessionid"];
                [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"userSysId"] forKey:@"userId"];
                
                [defaults synchronize];
                
                SetStateVC *set = [SetStateVC new];
                [self.navigationController pushViewController:set animated:NO];
    
            }else{

                self.state =[[dic objectForKey:@"data"]objectForKey:@"loveStatus"];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:_accountText.text forKey:@"phone"];
                
                    [defaults setObject:_accountText.text forKey:@"phoneBackup"];
                
                    [defaults setObject:@"已登录"forKey:@"userLogin"];
                    [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"loveStatus"] forKey:@"state"];
                    [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"secretKey"] forKey:@"secretKey"];
                    [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"sessionid"] forKey:@"sessionid"];
                    [defaults setObject:[[dic objectForKey:@"data"]objectForKey:@"userSysId"] forKey:@"userId"];

                    [defaults synchronize];
//                    [[NSNotificationCenter defaultCenter] postNotificationName:@"登录" object:nil userInfo:nil];
                
                [self GRXXRequest];
 
            }
            
        }else if([str2 isEqualToString:@"用户名或密码出错![登录失败，用户名或密码错！]"]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败，用户名或密码错！" preferredStyle:UIAlertControllerStyleAlert];
            [self  presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


- (void)registered{

    RegisteredVC *zhuce =[[RegisteredVC alloc]init];
    //设置代理
    zhuce.delegate = self;
    [self.navigationController pushViewController:zhuce animated:YES];
        
}


- (void)sysuserLoveStatusList{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager GET:@"http://mapi.loveyongtong.com/sysuser/longpolling/list" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"------------状态%@",dic);
    
        [self zhuangtaiText:0 dic:dic];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible= NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}

- (void)uploadInformation:(id)json{
    
    
    NSLog(@"%@",json);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求21头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager POST:@"http://mapi.loveyongtong.com/sysuser/updateInfo" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
}

//状态
- (void)zhuangtaiText:(int)i dic:(NSDictionary *)dic{
    NSMutableArray *arr = [dic objectForKey:@"data"];
    NSString *Str = @"欢迎使用爱理不离!";
    if (arr.count == 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Str];
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [Str length])];
        self.zhuangtaiText.attributedText = attributedString;

    }else{
        if ([NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectAtIndex:i]objectForKey:@"msgContent"]].length == 0 ) {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:Str];
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [Str length])];
            self.zhuangtaiText.attributedText = attributedString;
        }else{
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[[[dic objectForKey:@"data"]objectAtIndex:i]objectForKey:@"msgContent"]];
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[[[dic objectForKey:@"data"]objectAtIndex:i]objectForKey:@"msgContent"] length])];
            self.zhuangtaiText.attributedText = attributedString;
        }
    }
    
    }
- (void)GRXXRequest{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager GET:@"http://mapi.loveyongtong.com/sysuser/getUserInfo" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"---------------拿到用户信息%@",dic);
        
        self.state = [[dic objectForKey:@"data"] objectForKey:@"loveStatus"];

        if ([[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]isEqualToString:@"single"] ||[[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]isEqualToString:@"单身"]){
            
            NSString *str = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loverDetails"] objectForKey:@"overDate"]];
            [defaults setObject:[str stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"riqi2"];
            
            if ([[[dic objectForKey:@"data"]objectForKey:@"loverDetails"] objectForKey:@"islove"]) {
                [defaults setObject:@"是" forKey:@"bachelordom"];
                [defaults synchronize];
                
                self.riqi2 = [[[dic objectForKey:@"data"] objectForKey:@"loverDetails"] objectForKey:@"overDate"];
   
            }else{
            [defaults setObject:@"否" forKey:@"bachelordom"];
                [defaults synchronize];
            }

            [defaults synchronize];
            [self text];
        }
        if ([[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]isEqualToString:@"married"] || [[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]isEqualToString:@"已婚"]){
            
            [defaults setObject:[[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loverDetails"] objectForKey:@"marriedDate"]]stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"riqi1"];
            
               [defaults setObject:[[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loverDetails"] objectForKey:@"loverBirthday"]]stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"riqi2"];
            
            [defaults synchronize];
            
            
            self.riqi1 = [[[dic objectForKey:@"data"] objectForKey:@"loverDetails"] objectForKey:@"loverBirthday"];
        
            self.riqi2 = [[[dic objectForKey:@"data"] objectForKey:@"loverDetails"] objectForKey:@"marriedDate"];
      
            [self text];
        }
        if ([[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]isEqualToString:@"inLove"] || [[[dic objectForKey:@"data"]objectForKey:@"loveStatus"]isEqualToString:@"恋爱"]){
            
            [defaults setObject:[[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loverDetails"] objectForKey:@"loveDate"]]stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"riqi1"];
            
            [defaults setObject:[[NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loverDetails"] objectForKey:@"loverBirthday"]]stringByReplacingOccurrencesOfString:@"-" withString:@"."] forKey:@"riqi2"];
            
            [defaults synchronize];
            
            self.riqi1 = [[[dic objectForKey:@"data"] objectForKey:@"loverDetails"] objectForKey:@"loverDate"];
            
            self.riqi2 = [[[dic objectForKey:@"data"] objectForKey:@"loverDetails"] objectForKey:@"loverBirthday"];
            
            [self text];
        }
        
        
        
//        [defaults setObject:@"2016.07.10" forKey:@"riqi2"];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}



- (void)viewWillAppear:(BOOL)animated{
    
//    self.navChoose.hidden = NO;
//    [_navChoose setImage:[UIImage imageNamed:@"barChoose"]];
    
    if (self.ifLogin) {
        self.navChoose = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * 0.69 , 13, 17, 17)];
        [_navChoose setImage:[UIImage imageNamed:@"barChoose"]];
        _navChoose.userInteractionEnabled = YES;
        [self.navigationController.navigationBar addSubview:_navChoose];
        
        UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(navChooseState)];
        [_navChoose addGestureRecognizer:singleRecognizer];
    }
    
    
}

- (void)statusTaped{
//    YTActivityNewViewController *new = [[YTActivityNewViewController alloc]init];
//    
//    [self.navigationController pushViewController:new animated:YES];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}


@end

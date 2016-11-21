
//
//  BalanceVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "BalanceVC.h"

#import "AmountVC.h"
@interface BalanceVC ()
@property (nonatomic, strong)UILabel *yue;
@property (nonatomic, copy)NSString *yueStr;
@property (nonatomic, copy)NSString *j;
@property (nonatomic, copy)NSString *bankid;

@property(nonatomic,assign)int user_st;
//充值提现
@property(nonatomic,strong)UIButton *rechargeBtn;
@property(nonatomic,strong)UIButton *drawBtn;

@end

@implementation BalanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    self.title = @"账户余额";
    
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
    
    [self yinhang];
    
    [self yuereq];
    
    [self createyue];
    
    [self createChongzhiTixian];
    
    
    
}





- (void)createyue{
    UIView *baseView = [UIView new];
    [baseView setBackgroundColor:[UIColor colorWithRed:158.0/255 green:131.0/255 blue:198.0/ 255 alpha:1.0]];
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(178);
    }];
    
    
    
    self.yue = [UILabel new];
    [baseView addSubview:self.yue];
    [self.yue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(baseView.mas_centerX);
        make.centerY.mas_equalTo(baseView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 30, 35));
    }];
    
    NSString *Str = @"*******";
    self.yue.textColor = [UIColor whiteColor];
    self.yue.textAlignment = NSTextAlignmentCenter;
    self.yue.text = [NSString stringWithFormat:@"￥%@",Str];
    self.yue.font = [UIFont systemFontOfSize:35];
    
    UILabel *label = [UILabel new];
    label.text = @"我的余额";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [baseView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(self.view.frame.size.width - 45, 15));
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.yue.mas_top).offset(-10);
    }];

    
    
}
- (void)createChongzhiTixian{
 
    
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50 * kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    self.rechargeBtn = button;
    self.rechargeBtn.enabled = NO;
    
    
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50 * kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [label setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    label.textColor = [UIColor whiteColor];
    label.text = @"充值";
    label.textAlignment = NSTextAlignmentCenter;
    

    UIButton *button1 = [UIButton new];
    [self.view addSubview:button1];
    [button1 setBackgroundColor:[UIColor colorWithRed:133 / 255.0 green:127 / 255.0 blue:186 / 255.0 alpha:1]];
    [button1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(- 50 * kScreenH / 568.0f - 49 - 60 * kScreenH / 568.0f);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    self.drawBtn = button1;
    self.drawBtn.enabled = NO;
    
    
    UILabel *label1 = [UILabel new];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(- 50 * kScreenH / 568.0f - 49 - 60 * kScreenH / 568.0f);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [label1 setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    label1.textColor = [UIColor whiteColor];
    label1.text = @"提现";
    label1.textAlignment = NSTextAlignmentCenter;
    

}


- (void)yinhang{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    // time
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [NSDateFormatter new];
    [forMatter setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    
    
    NSString *phoneStr = [defaults objectForKey:@"phone"];
    
    NSLog(@"------富有传输参数%@",phoneStr);
    
    
    
    NSString *url = [NSString stringWithFormat:@"http://mapi.loveyongtong.com/fypay/queryUserInfo?mchnt_txn_dt=%@&user_ids=%@",dateStr,[defaults objectForKey:@"phone"] ? [defaults objectForKey:@"phone"] : [defaults objectForKey:@"phoneBackup"]];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"--------富友个人信息反回%@",dic);
        
        if ([[dic objectForKey:@"status"] intValue] == 200) {
            NSString *firstStr = [[dic objectForKey:@"data"] objectForKey:@"resp_code"];
            
            if ([firstStr isEqualToString:@"0000"]) {
                self.j =  [[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"parent_bank_id"]objectAtIndex:0];
                //银行id
                self.bankid =  [[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"capAcntNo"]objectAtIndex:0];
                
                
                //用户状态
                self.user_st = [[[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"user_st"]objectAtIndex:0] intValue];
                
            }else{
                
                [NSThread sleepForTimeInterval:3.0f];
                UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取银行卡参数失败，请退出并重新登录！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            

        }else{
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取银行卡参数失败！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        
        
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}


- (void)yuereq{

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
    // time
    NSDate *date = [NSDate date];
    NSDateFormatter *forMatter = [NSDateFormatter new];
    [forMatter setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [forMatter stringFromDate:date];
    
    NSString *url = [NSString stringWithFormat:@"http://mapi.loveyongtong.com/fypay/queryBalance?mchnt_txn_dt=%@&cust_no=%@",dateStr,[defaults objectForKey:@"phone"] ? [defaults objectForKey:@"phone"] : [defaults objectForKey:@"phoneBackup"]];
    NSLog(@"%@",url);
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if ([[dic objectForKey:@"status"] intValue] == 200) {
            NSString *resp_code = [[dic objectForKey:@"data"] objectForKey:@"resp_code"];
            if ([resp_code isEqualToString:@"0000"]) {
                NSString  *str = [[[[[[dic objectForKey:@"data"]objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"ca_balance"]firstObject];
                float yuef= [str floatValue] / 100;
                if (str) {
                    self.yue.text = [NSString stringWithFormat:@"￥%.2f",yuef];
                    self.rechargeBtn.enabled = YES;
                    self.drawBtn.enabled = YES;
                }
                
            }else{
                [NSThread sleepForTimeInterval:3.0f];
                UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取余额失败，请退出并重新登录！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else{
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取余额失败！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        
        }
        
        
        
       
        NSLog(@"-----------获取余额请求,%@",dic);
        
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"---------------获取余额请求失败%@",error);
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }];
}


- (void)button{

//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您下载“爱理不理”爱情小助手APP测试版，敬请您关注我们的正式版隆重上线！" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:cancelAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    
    if (self.bankid.length == 0 || self.user_st == 2) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未绑定银行卡,请去安全设置绑定" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        AmountVC *chongzhi = [AmountVC new];
        chongzhi.chongzhiORtixian = YES;
        chongzhi.yinhangid = self.bankid;
        chongzhi.j = self.j;
        [self.navigationController pushViewController:chongzhi animated:YES];
    }

}
- (void)button1{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"感谢您下载“爱理不理”爱情小助手APP测试版，敬请您关注我们的正式版隆重上线！" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//    [alertController addAction:cancelAction];
//    
//    [self presentViewController:alertController animated:YES completion:nil];
    if (self.bankid.length == 0 || self.user_st == 2 || self.user_st == 3) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未绑定银行卡,请去安全设置绑定" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
    AmountVC *tixian = [AmountVC new];
    tixian.chongzhiORtixian = NO;
    tixian.yinhangid = self.bankid;
    tixian.j = self.j;
        
    [self.navigationController pushViewController:tixian animated:YES];
        
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self yuereq];
    [self yinhang];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end

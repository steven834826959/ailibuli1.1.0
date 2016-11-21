//
//  BuyDetermineVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "BuyDetermineVC.h"
#import "BuyXieyiVc.h"

#import "LoveInterestVc.h"

@interface BuyDetermineVC ()
@property (nonatomic, strong)UILabel *balance;
@property (nonatomic, strong)UIButton *agreemenBtn;
@property (nonatomic, assign)BOOL ifAgreed;
@property (nonatomic, strong)UIButton *buybtn;


//余额
@property(nonatomic,assign)float blanceEqual;

@end

@implementation BuyDetermineVC

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
    
    self.title = @"确认购买";
    [self createZhifu];
    _ifAgreed = NO;
    [self yuereq];
    
}


- (void)createZhifu{
    
    UIImageView *zfxxView = [UIImageView new];
    zfxxView.image = [UIImage imageNamed:@"确定取消紫色"];
    [zfxxView setFrame:CGRectMake(0, 0, self.view.frame.size.width,25 * kScreenH / 568.0f)];
    [self.view addSubview:zfxxView];
    
    
    UILabel *label = [UILabel new];
    [label setFrame:CGRectMake(20, 0, self.view.frame.size.width - 40,25 * kScreenH / 568.0f)];
    label.text = @"支付信息";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:14 * kScreenH / 568.0f];
    [self.view addSubview:label];
    
    
    UIView *baseView = [UIView new];
    [baseView setFrame:CGRectMake(0, CGRectGetMaxY(zfxxView.frame), self.view.frame.size.width, 120 * kScreenH / 568.0f)];
    [baseView setBackgroundColor:[UIColor colorWithRed:126/ 255.0 green:136/255.0 blue:218/255.0 alpha:1]];
    
    [self.view addSubview:baseView];
    
    UILabel *buyAmount = [UILabel new];
    [buyAmount setFrame:CGRectMake(20 * kScreenH / 568.0f, 20 * kScreenH / 568.0f , self.view.frame.size.width - 40,25 * kScreenH / 568.0f)];
    buyAmount.text = @"购买金额";
    buyAmount.textColor = [UIColor whiteColor];
    buyAmount.textAlignment = NSTextAlignmentLeft;
    buyAmount.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [baseView addSubview:buyAmount];
    
    UILabel *buyAmount1 = [UILabel new];
    [buyAmount1 setFrame:CGRectMake(20  * kScreenH / 568.0f, 20  * kScreenH / 568.0f, self.view.frame.size.width - 40,25 * kScreenH / 568.0f)];
    buyAmount1.text = [NSString stringWithFormat:@"%@元",self.str];
    buyAmount1.textColor = [UIColor whiteColor];
    buyAmount1.textAlignment = NSTextAlignmentRight;
    buyAmount1.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [baseView addSubview:buyAmount1];
    
    UILabel *yunian = [UILabel new];
    [yunian setFrame:CGRectMake(20 * kScreenH / 568.0f, 50 * kScreenH / 568.0f, self.view.frame.size.width - 40,25 * kScreenH / 568.0f)];
    yunian.text = @"以往利率";
    yunian.textColor = [UIColor whiteColor];
    yunian.textAlignment = NSTextAlignmentLeft;
    yunian.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [baseView addSubview:yunian];
    
    UILabel *yunian1 = [UILabel new];
    [yunian1 setFrame:CGRectMake(20  * kScreenH / 568.0f, 50  * kScreenH / 568.0f, self.view.frame.size.width - 40,25 * kScreenH / 568.0f)];
    yunian1.text = [NSString stringWithFormat:@"%@(仅供参考)",self.shouyi];
    yunian1.textColor = [UIColor whiteColor];
    yunian1.textAlignment = NSTextAlignmentRight;
    yunian1.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [baseView addSubview:yunian1];
 
    self.balance = [UILabel new];
    [self.balance setFrame:CGRectMake(20 * kScreenH / 568.0f, 80 * kScreenH / 568.0f, self.view.frame.size.width - 40,25 * kScreenH / 568.0f)];
    self.balance.text = @"余额 **元";
    self.balance.textColor = [UIColor whiteColor];
    self.balance.textAlignment = NSTextAlignmentLeft;
    self.balance.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [baseView addSubview:self.balance];
   
    self.buybtn = [UIButton new];
//    [self.buybtn setBackgroundImage:[UIImage imageNamed:@"购买确认"] forState:UIControlStateNormal];
    [self.buybtn setTintColor:[UIColor whiteColor]];
    [self.buybtn setTitle:@"确认" forState:UIControlStateNormal];
    self.buybtn.backgroundColor = [UIColor colorWithRed:234/255.0 green:134/255.0 blue:150/255.0 alpha:1];
    [self.view  addSubview:self.buybtn];
    [self.buybtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150 * kScreenH / 568.0f, 30  * kScreenH / 568.0f));
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(-112 * kScreenH / 568.0f);
    }];
    [self.buybtn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *agreemenLabel = [UILabel new];
    
    agreemenLabel.text = @"      我已阅读并同意《永同财富平台用户协议》";
    agreemenLabel.textColor = [UIColor whiteColor];
    agreemenLabel.textAlignment = NSTextAlignmentCenter;
    agreemenLabel.font = [UIFont systemFontOfSize:13  * kScreenH / 568.0f];
    [self.view addSubview:agreemenLabel];
    [agreemenLabel setFrame:CGRectMake(0, self.view.frame.size.height - 176  * kScreenH / 568.0f-25 * kScreenH / 568.0f-20 * kScreenH / 568.0f-20 * kScreenH / 568.0f, self.view.frame.size.width, 20  * kScreenH / 568.0f)];
    [agreemenLabel sizeToFit];
    [agreemenLabel setCenterX:self.view.centerX];
    [agreemenLabel setUserInteractionEnabled:YES];
 
    
    self.agreemenBtn = [UIButton new];
    [self.agreemenBtn setBackgroundImage:[UIImage imageNamed:@"32"] forState:UIControlStateNormal];
    [agreemenLabel addSubview:self.agreemenBtn];
    [self.agreemenBtn setFrame:CGRectMake(0, 0, 15, 15)];
 
    [self.agreemenBtn addTarget:self action:@selector(agreemenBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UIButton *btn = [UIButton new];
    [agreemenLabel addSubview:btn];
    [btn setFrame:CGRectMake(20 * kScreenH / 568.0f, 0, agreemenLabel.frame.size.width - 20 * kScreenH / 568.0f, 20 * kScreenH / 568.0f)];
    [btn addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)push{
    BuyXieyiVc *xieyi = [BuyXieyiVc new];
    [self.navigationController pushViewController:xieyi animated:YES];
}
		
- (void)agreemenBtnAction{
    
    if (self.ifAgreed) {
        [self.agreemenBtn setBackgroundImage:[UIImage imageNamed:@"32"] forState:UIControlStateNormal];
        self.ifAgreed = NO;
    }else{
        [self.agreemenBtn setBackgroundImage:[UIImage imageNamed:@"31"] forState:UIControlStateNormal];
        self.ifAgreed = YES;
    }
}


//购买条件
- (void)buy{
    
    if (self.ifAgreed) {

        NSUserDefaults *defauts = [NSUserDefaults standardUserDefaults];
        if (![defauts objectForKey:@"secretKey"]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未登录账号" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertController addAction:cancelAction];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else if (self.blanceEqual < self.str.floatValue) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"余额小于购买金额！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            //发送购买请求
           [self buyRequest:_json];
        }
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未同意《永同财富平台用户协议》" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];

    }
    
}

- (void)buyRequest:(id)json{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式	
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    manager.requestSerializer.timeoutInterval = 200;
    
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    NSLog(@"%@",json);
    [manager POST:@"http://mapi.loveyongtong.com/loan/buyLoan" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        
        NSString *alertStr = [NSString stringWithFormat:@"%@  %@  %@",[dic objectForKey:@"desc"],[[dic objectForKey:@"fyData"]objectForKey:@"description"],[[dic objectForKey:@"fyData"]objectForKey:@"mchnt_txn_ssn"]];
        
        
        NSString *alert1 = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"fyData"]objectForKey:@"description"]];
        
        NSLog(@"购买返回值");
        NSLog(@"-----------------购买产品返回%@",dic);
        
        if ([[dic objectForKey:@"status"] intValue] != 200) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alert1 ? alert1 : @""
 preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                self.buybtn.userInteractionEnabled=YES;
                self.buybtn.alpha=1;
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];

        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"购买成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
   
                //跳转到兑换页面
                [self.navigationController pushViewController:[LoveInterestVc new] animated:YES];
                self.buybtn.userInteractionEnabled = NO;
                self.buybtn.alpha=1;
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    
    }];
}


- (void)yuereq{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
    
    NSString *url = [NSString stringWithFormat:@"http://mapi.loveyongtong.com/fypay/queryBalance?mchnt_txn_dt=%@&cust_no=%@",dateStr,[defaults objectForKey:@"phone"] ? [defaults objectForKey:@"phone"] : [defaults objectForKey:@"phoneBackup"]];
    NSLog(@"%@",url);
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
   
        NSLog(@"---------余额返回%@",dic);
        if ([[dic objectForKey:@"status"] intValue] == 200) {
            NSString *resp_code = [[dic objectForKey:@"data"] objectForKey:@"resp_code"];
            if ([resp_code isEqualToString:@"0000"]) {
                NSString  *str = [[[[[[dic objectForKey:@"data"]objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"ca_balance"]firstObject];
                
                float yuef= [str floatValue] / 100;
                NSLog(@"%f",[str floatValue]);
                
                if (str) {
                    self.blanceEqual = str.floatValue;
                    //余额查询
                    self.balance.text = [NSString stringWithFormat:@"余额 %.2f元",yuef];
                }
            }else{
                [NSThread sleepForTimeInterval:3.0f];
                UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"请退出并重新登录" preferredStyle:UIAlertControllerStyleAlert];
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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];

    }];
}

@end

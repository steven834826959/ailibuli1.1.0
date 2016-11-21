//
//  BankCardVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/4.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "BankCardVC.h"

@interface BankCardVC ()
@property (nonatomic, copy)NSString *j;
@property (nonatomic, copy)NSString *bankid;
@property (nonatomic, strong)UIImageView *yun;

@property(nonatomic,assign)int user_st;

@end

@implementation BankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的银行卡";
    
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
}

- (void)bankView{
    UIView *baseView = [UIView new];
    [baseView setFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 100)];
    
    [baseView setBackgroundColor:[UIColor colorWithRed:135 / 255.0 green:130 / 255.0 blue:196 / 255.0 alpha:.9]];
    [self.view addSubview:baseView];
    
    UIImageView *image = [UIImageView new];
    [baseView addSubview:image];
    
    if (self.user_st != 2) {
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.j]];
        NSLog(@"%@",self.j);
        [image setFrame:CGRectMake(10, 30, 100, 40 )];
    }

    
    
    
    UILabel *bankc = [UILabel new];
    bankc.textColor = [UIColor whiteColor];
    
    if (self.bankid.length == 0 || self.user_st == 2 ) {
        bankc.text = [NSString stringWithFormat:@"未绑定银行卡"];

    }else{
        bankc.text = [NSString stringWithFormat:@"***%@",[self.bankid substringToIndex:8]];

    }
    bankc.font = [UIFont systemFontOfSize:20];
    [baseView addSubview:bankc];
    [bankc setFrame:CGRectMake(10 + 100 +10, 30,  self.view.frame.size.width - 80, 40)];
}


- (void)yinhang{
    
    
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
    
    NSLog(@"-------时间字符串%@",dateStr);
    NSLog(@"-------userID%@",[defaults objectForKey:@"userId"]);
    
    
    NSString *url = [NSString stringWithFormat:@"http://mapi.loveyongtong.com/fypay/queryUserInfo?mchnt_txn_dt=%@&user_ids=%@",dateStr,[defaults objectForKey:@"phone"] ? [defaults objectForKey:@"phone"] : [defaults objectForKey:@"phoneBackup"]];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"------富友个人信息返回%@",dic);
        
        if ([NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"results"]].length == 0 ) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请求出错，请重新登录！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            
            self.j =  [[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"parent_bank_id"]objectAtIndex:0] ? [[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"parent_bank_id"]objectAtIndex:0] : @"";
            
            
            self.bankid =  [[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"capAcntNo"]objectAtIndex:0] ? [[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"capAcntNo"]objectAtIndex:0] : 0;
            
        //用户状态
            self.user_st = [[[[[[[dic objectForKey:@"data"] objectForKey:@"results"]objectForKey:@"result"]objectAtIndex:0]objectForKey:@"user_st"]objectAtIndex:0] intValue];
            
                [self bankView];

        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}





@end

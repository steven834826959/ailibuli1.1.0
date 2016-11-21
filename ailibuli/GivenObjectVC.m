//
//  GivenObjectVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/30.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "GivenObjectVC.h"
@interface GivenObjectVC ()
@property (nonatomic, strong)UITextField *field;
@property (nonatomic, strong)NSString *Sid;
@end

@implementation GivenObjectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    [self.view setBackgroundColor:BGColor];
    [self createbaseView];
    

    
}
- (void)createbaseView{
    
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(10,74, self.view.frame.size.width - 20, 110)];
    [view setBackgroundColor:[UIColor colorWithRed:75/255.0 green:86/255.0 blue:81/255.0 alpha:1]];
    [self.view addSubview:view];
    
    
    
    UILabel *label = [UILabel new];
    [view addSubview:label];
    [label setFrame:CGRectMake(13, 13, view.frame.size.width - 26, 20)];
    [label setTextColor:[UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1]];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"账号";
    
    
    self.field = [UITextField new];
    [view addSubview:self.field];
    [self.field setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];
    [self.field setFrame:CGRectMake(13 , 13 + 20 + 3, view.frame.size.width - 26, 35)];
    [self.field setTextColor:[UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1]];
    self.field.placeholder = @"  请输入手机号";
    [self.field setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    UILabel *label1 = [UILabel new];
    [view addSubview:label1];
    [label1 setFrame:CGRectMake(13, 13 + 23 + 3 + 35, view.frame.size.width - 26, 20)];
    [label1 setTextColor:[UIColor colorWithRed:158.0/255 green:158.0/255 blue:158.0/255 alpha:1]];
    label1.font = [UIFont systemFontOfSize:15];
    label1.text = @"请输入您将赠送对象的账号,即注册的手机号";
    
    

    // 增送
    UIButton *songBtn = [UIButton new];
    [songBtn setTitle:@"赠送" forState:0];
    [songBtn setBackgroundImage:[UIImage imageNamed:@"紫色条"] forState:0];
    [songBtn addTarget:self action:@selector(clickSongBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:songBtn];
    
    [songBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.left.mas_equalTo(100);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.bottom.mas_equalTo(-90);
    }];
    
}


- (void)clickSongBtn{
    [self.field resignFirstResponder];
    if (self.field.text.length == 0) {
        
    }else{
        self.Sid = [NSString stringWithFormat:@"%@",[self.arr objectAtIndex:0]];
        for (int i = 1; i < self.arr.count; i++) {
            self.Sid = [self.Sid stringByAppendingString:[NSString stringWithFormat:@";%@",[self.arr objectAtIndex:i]]];
        }
        [self zengsongRequest];

    }
    
    
}



- (void)zengsongRequest{
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager POST:@"http://mapi.loveyongtong.com/services/give" parameters:@{@"recieverMobile":self.field.text,@"serviceId": self.Sid} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] isEqualToString:@"200"]) {
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"赠送成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
                [self.navigationController popViewControllerAnimated:YES];
                
            }];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"赠送失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}



@end

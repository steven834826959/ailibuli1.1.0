//
//  inputVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/4.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "inputVC.h"
#define KScreenWidth        [UIScreen mainScreen].bounds.size.width
#define KScreenHeight       [UIScreen mainScreen].bounds.size.height
@interface inputVC ()
@end

@implementation inputVC

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
    
    [self createView];
    
}

- (void)createView{
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(10, 10 * kScreenH / 568.0f, self.view.frame.size.width - 20, 30 * kScreenH / 568.0f)];
    [self.view addSubview:view];
    [view setBackgroundColor:[UIColor colorWithRed:131/255.0 green:124.0/255 blue:216/255.0 alpha:1]];
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];

    label.text = @"请输入编辑信息";

    label.font = [UIFont systemFontOfSize:13 * kScreenH / 568.0f];
    [self.view addSubview:label];
    [label setFrame:CGRectMake(20, 10 * kScreenH / 568.0f,  self.view.frame.size.width - 40, 30 * kScreenH /568.0f)];
    
    UIView *veiw1 = [UIView new];
    [veiw1 setBackgroundColor:[UIColor colorWithRed:131/255.0 green:129/255.0 blue:157/255.0 alpha:1]];
    [self.view addSubview:veiw1];
    [veiw1 setFrame:CGRectMake(10,CGRectGetMaxY(label.frame), self.view.frame.size.width - 20, 40 * kScreenH / 568.0f)];
    
    self.input = [UITextField new];
    [self.input setFrame:CGRectMake(20, veiw1.frame.origin.y, self.view.frame.size.width - 40, 40 * kScreenH / 568.0f)];
    [self.view addSubview:self.input];
    self.input.textColor = [UIColor whiteColor];
    
    self.input.placeholder = self.str;
    
    [self.input setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UIButton *addAddress = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 55, 20, 44, 44)];
    addAddress.titleLabel.font = [UIFont systemFontOfSize:15];
    [addAddress setTitle:@"完成" forState:UIControlStateNormal];
    [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(quding) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addAddress];
    
  
}

- (void)quding{
    
    [self.input resignFirstResponder];
    if (self.i == 1) {
        [self uploadInformation:@{@"name":self.input.text}];
    }
    if (self.i == 2) {
        [self uploadInformation:@{@"birthday":self.input.text}];
    }
    if (self.i == 3) {
        [self uploadInformation:@{@"email":self.input.text}];
    }
    [self.navigationController popViewControllerAnimated:YES];

    
}

- (void)uploadInformation:(id)json{

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
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

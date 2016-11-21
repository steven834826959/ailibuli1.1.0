//
//  RegisteredVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/23.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "RegisteredVC.h"
#import "WQFTextField.h"
#import <Masonry.h>
#import "zhucexieyiVC.h"
#import "NSString+MoblieString.h"
#import "NSDate+getInternetDate.h"

@interface RegisteredVC ()<UITextFieldDelegate,NSURLConnectionDelegate>

@property (strong, nonatomic)WQFTextField *passWordText;

@property (strong, nonatomic)WQFTextField *passWord2Text;

@property (strong, nonatomic)WQFTextField *phoneNoText;

@property (strong, nonatomic)WQFTextField *phoneCodeText;

@property (nonatomic, strong)WQFTextField *verificationField;

@property (nonatomic, strong)UIImageView *verificationCode;

@property (nonatomic, copy) NSString *str1;//账号

@property (nonatomic, copy) NSString *str2;//密码1

@property (nonatomic, copy) NSString *str3;//密码2

@property (nonatomic, copy) NSString *str4;//手机号码

@property (nonatomic, copy) NSString *str5;//短信验证码

@property (nonatomic, copy) NSString *str6;//验证码机校验串

@property (nonatomic, copy) NSString *str7;//验证码

@property (nonatomic, copy) NSString *msgId;


@property (nonatomic, copy) NSData *imageData;

@property (nonatomic, strong)UIView *controlView;

@property (nonatomic, assign)int e;

@end

@implementation RegisteredVC

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
    
    [self initSubViews];

    self.title = @"注册";
    [self fieldDelegate];
    [self verificationView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reKeyBoard)];
    
    [self.view addGestureRecognizer:tap];
    
    UIButton *addAddress = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 75, 20, 64, 44)];
    addAddress.titleLabel.font = [UIFont systemFontOfSize:15];
    [addAddress setTitle:@"注册协议" forState:UIControlStateNormal];
    [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(xieyi) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addAddress];
    

}



- (void)initSubViews{
    
    UIView *bgView = [[UIView alloc]init];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithRed:97.0/255.0f green:93.0/255.0f blue:121.0/255.0f alpha:0.8];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //背景图布局
        make.top.mas_equalTo(32 * kScreenH / 568.0f);
        make.left.mas_equalTo(43 * kScreenW / 320.0f);
        make.right.mas_equalTo(-43 * kScreenW / 320.0f);
        make.bottom.mas_equalTo(-45-49 * kScreenH / 568.0f);
    }];
    
    
    //手机号码
    UIImageView *phoneNumImg = [UIImageView new];
    [bgView addSubview:phoneNumImg];
    [phoneNumImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(29 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f ,30 * kScreenH / 568.0f));

    }];
    phoneNumImg.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    [phoneNumImg setImage:[UIImage imageNamed:@"手机"]];
    
    self.phoneNoText = [WQFTextField new];
    
    //数字键盘
    self.phoneNoText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.phoneNoText.textColor = [UIColor whiteColor];
    [bgView addSubview:_phoneNoText];
    
    
    [self.phoneNoText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneNumImg.mas_top);
        make.left.mas_equalTo(phoneNumImg.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    [_phoneNoText setBackgroundColor:[UIColor colorWithRed:123.0/255 green:121.0/255 blue:153.0/255 alpha:1]];
    _phoneNoText.delegate = self;
    [_phoneNoText setPlaceholder:@" 请输入您的手机号"];
    [_phoneNoText setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_phoneNoText setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    //数字键盘


    //密码
    UIImageView *mimaImage = [UIImageView new];
    [bgView addSubview:mimaImage];
    [mimaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneNumImg.mas_bottom).mas_equalTo(20 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    [mimaImage setImage:[UIImage imageNamed:@"密码new"]];
    mimaImage.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    self.passWordText = [WQFTextField new];
    [bgView addSubview:_passWordText];
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

//重复密码
    UIImageView *mimaImage2 = [UIImageView new];
    [bgView addSubview:mimaImage2];
    [mimaImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mimaImage.mas_bottom).mas_equalTo(20 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    mimaImage2.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    [mimaImage2 setImage:[UIImage imageNamed:@"密码new"]];
        self.passWord2Text = [WQFTextField new];
    [bgView addSubview:_passWord2Text];
    self.passWord2Text.textColor = [UIColor whiteColor];
    
    [self.passWord2Text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mimaImage.mas_bottom).mas_equalTo(20 * kScreenH / 568.0f);
        make.left.mas_equalTo(phoneNumImg.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    _passWord2Text.delegate = self;
    
    [_passWord2Text setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_passWord2Text setBackgroundColor:[UIColor colorWithRed:123.0/255 green:121.0/255 blue:153.0/255 alpha:1]];
    [_passWord2Text setPlaceholder:@" 请重复输入您的密码"];
    [_passWord2Text setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passWordText.secureTextEntry = YES;
    
   
    //获取验证码按钮
    UIButton *getVerfiyCode = [[UIButton alloc]init];
    [bgView addSubview:getVerfiyCode];
    [getVerfiyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
//    [getVerfiyCode setBackgroundImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    [getVerfiyCode setBackgroundColor:[UIColor colorWithRed:133.0/255.0f green:127.0/255.0f blue:186.0/255.0f alpha:0.8]];
    
    [getVerfiyCode setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];

    [getVerfiyCode addTarget:self action:@selector(huoquyanyanzhengma:) forControlEvents:UIControlEventTouchUpInside];
    
    [getVerfiyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passWord2Text.mas_bottom).mas_equalTo(20 * kScreenH / 568.0f);
        make.left.mas_equalTo(phoneNumImg.mas_left);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
    }];
    
    //验证码框
    UIImageView *verfyImg = [UIImageView new];
    [bgView addSubview:verfyImg];
    [verfyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(getVerfiyCode.mas_bottom).mas_equalTo(20 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    verfyImg.backgroundColor = [UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1];
    [verfyImg setImage:[UIImage imageNamed:@"密码new"]];
    
    
    self.phoneCodeText = [WQFTextField new];
    self.phoneCodeText.keyboardType = UIKeyboardTypeNumberPad;
    [bgView addSubview:_phoneCodeText];
    self.phoneCodeText.textColor = [UIColor whiteColor];
    
    [self.phoneCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verfyImg.mas_top);
        make.left.mas_equalTo(phoneNumImg.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    _phoneCodeText.delegate = self;
    
    [_phoneCodeText setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_phoneCodeText setBackgroundColor:[UIColor colorWithRed:123.0/255 green:121.0/255 blue:153.0/255 alpha:1]];
    [_phoneCodeText setPlaceholder:@"请输入您的手机验证码"];
    [_phoneCodeText setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];

    //注册按钮
    UIButton *registBtn = [[UIButton alloc]init];
    [bgView addSubview:registBtn];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    
    
    [registBtn setBackgroundColor:[UIColor colorWithRed:234.0/255.0f green:134.0/255.0f blue:150.0/255.0f alpha:1]];
    
    [registBtn addTarget:self action:@selector(zhuce:) forControlEvents:UIControlEventTouchUpInside];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneCodeText.mas_bottom).mas_equalTo(60 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
  
    }];
    

}
- (void)xieyi{
    zhucexieyiVC *xieyi = [zhucexieyiVC new];
    [self.navigationController pushViewController:xieyi animated:YES];
}

- (void)reKeyBoard
{

    [self.passWordText resignFirstResponder];
    [self.passWord2Text resignFirstResponder];
    [self.phoneNoText resignFirstResponder];
    [self.phoneCodeText resignFirstResponder];
    
}
- (void)fieldDelegate{
    self.imageData = [NSData new];

    self.passWordText.delegate = self;
    self.passWord2Text.delegate = self;
    self.phoneNoText.delegate = self;
    self.phoneCodeText.delegate = self;
    
    self.passWordText.clearsOnBeginEditing = YES;
    self.passWord2Text.clearsOnBeginEditing = YES;
    self.passWordText.secureTextEntry = YES;
    self.passWord2Text.secureTextEntry = YES;

}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    
   if (textField == self.passWord2Text){
       
        self.str2 = self.passWord2Text.text;
    }else if(textField == self.phoneNoText){
        if (![self.phoneNoText.text isValidateMobile]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的电话号码" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
        }else{
            self.str4 = textField.text;
            [self checkPhonePost];
        }
     
    }else if(textField == self.phoneCodeText){
        self.str5 = self.phoneCodeText.text;

    }else if(textField == self.verificationField){
        self.str7 =  self.verificationField.text;

    }
}


/**检测手机号是否已绑定*/
- (void)checkPhonePost{
    if (_str4.length == 0) {
        
    }else{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 设置请求格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0f;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置请求头
        [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
        [manager POST:@"http://mapi.loveyongtong.com/sysuser/ckmobile" parameters:@{@"mb":_str4} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] isEqualToString:@"111"]) {
                self.phoneNoText.text = @"";
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该手机号已注册" preferredStyle:UIAlertControllerStyleAlert];
                            [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
            [self presentViewController:alert animated:YES completion:nil];
        }];

    }
    
}
//获取验证码操作
- (void)huoquyanyanzhengma:(UIButton *)sender {
    [self verificationRequest];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self.controlView];
}

/**
 校检码视图
 */
- (void)verificationView{
    self.controlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.controlView setBackgroundColor:[UIColor clearColor]];
    UIView *aView = [UIView new];
    [aView setFrame:CGRectMake(50 , kScreenH - 216 - 120, kScreenW - 100 , 40)];
    [aView setBackgroundColor:[UIColor colorWithWhite:0.5 alpha:0.8]];
    [self.controlView addSubview:aView];
    
    self.verificationCode = [UIImageView new];
    [self.verificationCode setFrame:CGRectMake(3, 2.5, 60, 35)];
    [aView addSubview:self.verificationCode];
    
    
    self.verificationField  = [WQFTextField new];
    self.verificationField.placeholder = @"输入验证码";
    self.verificationField.keyboardType = UIKeyboardTypeNumberPad;
    self.verificationField.delegate = self;
    [self.verificationField setFont:[UIFont systemFontOfSize:13]];
    self.verificationField.borderStyle = UITextBorderStyleRoundedRect;
    [self.verificationField setFrame:CGRectMake(70, 2.5, 80, 35)];
    [aView addSubview:self.verificationField];
    
    UIButton *verButton  = [UIButton new];
     [verButton setTitle:@"确定" forState:UIControlStateNormal];
    [verButton setBackgroundImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    [aView addSubview:verButton];
    [verButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(50, 35));
        make.top.mas_offset(2.5);
        make.right.mas_offset(-3);
    }];
    
  
    [verButton addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
  
    
    
}
- (void)queding{
    [self.controlView removeFromSuperview];
    [self sendMsg];
}


- (void)sendMsg{
    if (_str7.length == 0 || _str4.length == 0 || _str6.length == 0 ){
        NSLog(@"str7:%@    str4:%@   str6:%@   ",_str7,_str4,_str6);
    }else{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 设置请求格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0f;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置请求头

        [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
        
        [manager POST:@"http://mapi.loveyongtong.com/syscom/sendMsg" parameters:@{@"code":_str7,@"mobile":_str4,@"encode":_str6} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

            NSString *str2 = [[dic objectForKey:@"desc"] stringByRemovingPercentEncoding]; //UTF8转汉字
            self.msgId = [[dic objectForKey:@"data"]objectForKey:@"msgId"];

            if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] isEqualToString:@"200"]) {
                NSLog(@"验证码错误");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已发送验证码" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
            }
            
            if ([str2 isEqualToString:@"验证码错误!"]) {
                NSLog(@"验证码错误");
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码错误" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            UIAlertController *alert = [UIAlertController internetErrorAlertShow];
            [self presentViewController:alert animated:YES completion:nil];
  }];}
}

- (void)verificationRequest{
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://mobile.loveyongtong.com/ajax/ccap"];
    NSURLSessionTask *task = [session dataTaskWithURL:url
                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                        self.imageData = data;
                                        dispatch_queue_t queue = dispatch_get_main_queue();
                                        dispatch_async(queue, ^{
                                            [self.verificationCode setImage:[UIImage imageWithData:self.imageData]];                                        });
                                        
                                        NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                                        
                                        for (NSHTTPCookie *cookie in [cookieJar cookies]) {
                                            self.str6 = cookie.value;
                                            NSLog(@"机串校检码");
                                            NSLog(@"%@",self.str6);
                                        }
}];
    [task resume];

}




- (void)zhuce:(UIButton *)sender {
    [self.passWordText resignFirstResponder];
    [self.passWord2Text resignFirstResponder];
    [self.phoneNoText resignFirstResponder];
    [self.phoneCodeText resignFirstResponder];
    
    self.str5 = self.phoneCodeText.text;

    
    NSLog(@"注册");
    
    if(![self.passWordText.text isEqualToString:self.passWord2Text.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的密码不同" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self  presentViewController:alert animated:YES completion:nil];
    }

    if ( _str2.length == 0 || _str4.length == 0 || _str5.length == 0 ||_msgId.length == 0){
    
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
            
            
        }];
        [alert addAction:cancelAction];
        [self  presentViewController:alert animated:YES completion:nil];

        
        
    } else if (_str2.length <= 5){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码长度最低为6位数" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self  presentViewController:alert animated:YES completion:nil];
    
    }
    else{
        NSLog(@"1");
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 设置请求格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0f;
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置请求头
        [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];

        [manager POST:@"http://mapi.loveyongtong.com/sysuser/register" parameters:@{@"pwd":_str2 ,@"mb":self.str4,@"msgid":self.msgId,@"mcode":_str5}  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            NSString *str2 = [[dic objectForKey:@"desc"] stringByRemovingPercentEncoding]; //UTF8转汉字
            if ([str2 isEqualToString:@"请求头验证sid信息缺失 ![手机验证码错误！]"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请求头验证sid信息缺失 ![手机验证码错误！]" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
            }else{
                
                //增加两个积分
                //获取当前时间
                NSDate *currentDate = [NSDate getInternetDate];
                
                //获取开始和结束时间
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                
                NSDate *startDate = [formatter dateFromString:@"2016-12-02 00:00:00"];
                
                NSDate *endDate = [formatter dateFromString:@"2016-12-04 23:59:59"];
                
                if (currentDate.timeIntervalSince1970 > startDate.timeIntervalSince1970 && currentDate.timeIntervalSince1970 < endDate.timeIntervalSince1970){
                    [self addMyScoreWithScore:2];
                }

                
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *	action) {
            
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:_phoneNoText.text forKey:@"phone"];
                    //保存手机号2
                    [defaults setObject:_phoneNoText.text forKey:@"phoneBackup"];
                    
                    [defaults synchronize];
                    
                    
                    //跳转回登录页传值
                    [self.delegate valuesBackToStatusVcWithUserName:self.phoneNoText.text password:self.passWord2Text.text];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }];
                [alert addAction:okAction];
            }

        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           
            UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
            [self presentViewController:alert animated:YES completion:nil];
        }];	

    }

}
//增加积分
- (void)addMyScoreWithScore:(int)score{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *param = @{@"mobile":self.phoneNoText.text,@"num": @(score)};
    
    [manager POST:@"http://mapi.loveyongtong.com/sysuser/accumulationIncreased" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"--------增加积分返回值%@",dic);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}



@end

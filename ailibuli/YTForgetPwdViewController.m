//
//  YTForgetPwdViewController.m
//  ailibuli
//
//  Created by ios on 16/10/25.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTForgetPwdViewController.h"
#import "WQFTextField.h"


@interface YTForgetPwdViewController ()<UITextFieldDelegate,NSURLConnectionDelegate>
@property (strong, nonatomic)WQFTextField *accountText;

@property (strong, nonatomic)WQFTextField *passWordText;

@property (strong, nonatomic)WQFTextField *passWord2Text;



@property (strong, nonatomic)WQFTextField *phoneCodeText;

@property (nonatomic, strong)WQFTextField *verificationField;

@property (nonatomic, strong)UIImageView *verificationCode;

@property (nonatomic, copy) NSString *account;//账号

@property (nonatomic, copy) NSString *pwd1;//密码1

@property (nonatomic, copy) NSString *pwd2;//密码2

@property (nonatomic, copy) NSString *phoneNum;//手机号码

@property (nonatomic, copy) NSString *msgVerfyCode;//短信验证码

@property (nonatomic, copy) NSString *str6;//验证码机校验串

@property (nonatomic, copy) NSString *mcode;//验证码

@property (nonatomic, copy) NSString *msgId;

@property (nonatomic, copy) NSData *imageData;
@end

@implementation YTForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    [self.view setBackgroundColor:[UIColor colorWithRed:73.0/255 green:187.0/255 blue:180.0/255 alpha:1]];
    
    [self initSubViews];
    
    [self verificationRequest];
    
}

- (void)initSubViews{
    
    UIView *bgView = [[UIView alloc]init];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor colorWithRed:32.0/255.0f green:32.0/255.0f blue:32.0/255.0f alpha:0.8];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //背景图布局
        make.top.mas_equalTo(32 * kScreenH / 568.0f);
        make.left.mas_equalTo(43 * kScreenW / 320.0f);
        make.right.mas_equalTo(-43 * kScreenW / 320.0f);
        make.bottom.mas_equalTo(-45-49 * kScreenH / 568.0f);
    }];
    
    UIImageView *yonghuImage = [UIImageView new];
    [bgView addSubview:yonghuImage];
    [yonghuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(29 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f ,30 * kScreenH / 568.0f));
    }];
    [yonghuImage setImage:[UIImage imageNamed:@"登录用户"]];
    
    self.accountText = [WQFTextField new];
    
    //数字键盘
    self.accountText.keyboardType = UIKeyboardTypeNumberPad;
    
    self.accountText.textColor = [UIColor whiteColor];
    [bgView addSubview:_accountText];
    
    self.accountText.delegate = self;
    [self.accountText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yonghuImage.mas_top);
        make.left.mas_equalTo(yonghuImage.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    [_accountText setBackgroundColor:[UIColor colorWithRed:44.0/255 green:44.0/255 blue:44.0/255 alpha:1]];
    _accountText.delegate = self;
    [_accountText setPlaceholder:@" 请输入您的手机号"];
    [_accountText setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_accountText setValue:[UIColor colorWithRed:118.0/255 green:118.0/255 blue:118.0/255 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    //密码
    UIImageView *mimaImage = [UIImageView new];
    [bgView addSubview:mimaImage];
    [mimaImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yonghuImage.mas_bottom).mas_equalTo(10 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    [mimaImage setImage:[UIImage imageNamed:@"用户密码"]];
    
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
    [_passWordText setBackgroundColor:[UIColor colorWithRed:44.0/255 green:44.0/255 blue:44.0/255 alpha:1]];
    [_passWordText setPlaceholder:@" 请输入您的新密码"];
    [_passWordText setValue:[UIColor colorWithRed:118.0/255 green:118.0/255 blue:118.0/255 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    _passWordText.secureTextEntry = YES;
    
    //重复密码
    UIImageView *mimaImage2 = [UIImageView new];
    [bgView addSubview:mimaImage2];
    [mimaImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mimaImage.mas_bottom).mas_equalTo(10 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    [mimaImage2 setImage:[UIImage imageNamed:@"用户密码"]];
    self.passWord2Text = [WQFTextField new];
    [bgView addSubview:_passWord2Text];
    self.passWord2Text.textColor = [UIColor whiteColor];
    
    [self.passWord2Text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mimaImage.mas_bottom).mas_equalTo(10 * kScreenH / 568.0f);
        make.left.mas_equalTo(yonghuImage.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    _passWord2Text.delegate = self;
    
    [_passWord2Text setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_passWord2Text setBackgroundColor:[UIColor colorWithRed:44.0/255 green:44.0/255 blue:44.0/255 alpha:1]];
    [_passWord2Text setPlaceholder:@" 请重复输入您的新密码"];
    [_passWord2Text setValue:[UIColor colorWithRed:118.0/255 green:118.0/255 blue:118.0/255 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    _passWord2Text.secureTextEntry = YES;
    
    
    
    //识别码
    
    self.verificationCode = [UIImageView new];
    [bgView addSubview:_verificationCode];
    [_verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_passWord2Text.mas_bottom).mas_equalTo(10 * kScreenH / 568.0f);
        make.left.mas_equalTo(yonghuImage.mas_left);
        make.size.mas_equalTo(CGSizeMake(60 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
//    [_verificationCode setImage:[UIImage imageNamed:@"手机1"]];
    
    
    //校检码框
    self.verificationField  = [WQFTextField new];
    [bgView addSubview:self.verificationField];
    self.verificationField.placeholder = @"  输入验证码";
    self.verificationField.delegate = self;
    [self.verificationField setFont:[UIFont systemFontOfSize:13 * kScreenH / 568.0f]];
//    self.verificationField.borderStyle = UITextBorderStyleRoundedRect;
    self.verificationField.textColor = [UIColor whiteColor];
    [self.verificationField setBackgroundColor:[UIColor colorWithRed:44.0/255 green:44.0/255 blue:44.0/255 alpha:1]];
    [self.verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_verificationCode.mas_top);
                make.left.mas_equalTo(_verificationCode.mas_right).mas_equalTo(10);
                make.right.mas_equalTo(-22 * kScreenW / 320.0f);
                make.height.mas_equalTo(30 * kScreenH / 568.0f);
    }];


    //获取验证码按钮
    UIButton *getVerfiyCode = [[UIButton alloc]init];
    [bgView addSubview:getVerfiyCode];
    [getVerfiyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getVerfiyCode setBackgroundImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    
    [getVerfiyCode setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    
    [getVerfiyCode addTarget:self action:@selector(sendMsg) forControlEvents:UIControlEventTouchUpInside];
    
    [getVerfiyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_verificationCode.mas_bottom).mas_equalTo(10 * kScreenH / 568.0f);
        make.left.mas_equalTo(yonghuImage.mas_left);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
    }];
    
    //验证码框
    UIImageView *verfyImg = [UIImageView new];
    [bgView addSubview:verfyImg];
    [verfyImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(getVerfiyCode.mas_bottom).mas_equalTo(10 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.size.mas_equalTo(CGSizeMake(30 * kScreenH / 568.0f, 30 * kScreenH /568.0f));
    }];
    [verfyImg setImage:[UIImage imageNamed:@"用户密码"]];
    
    verfyImg.backgroundColor = [UIColor colorWithRed:23.0 / 255.0 green:23.0 / 255.0 blue:23.0 / 255.0 alpha:1.0];
    
    self.phoneCodeText = [WQFTextField new];
    [bgView addSubview:_phoneCodeText];
    self.phoneCodeText.textColor = [UIColor whiteColor];
    
    [self.phoneCodeText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(verfyImg.mas_top);
        make.left.mas_equalTo(yonghuImage.mas_right);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];
    _phoneCodeText.delegate = self;
    
    [_phoneCodeText setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    [_phoneCodeText setBackgroundColor:[UIColor colorWithRed:44.0/255 green:44.0/255 blue:44.0/255 alpha:1]];
    [_phoneCodeText setPlaceholder:@"请输入您的手机验证码"];
    [_phoneCodeText setValue:[UIColor colorWithRed:118.0/255 green:118.0/255 blue:118.0/255 alpha:1.0] forKeyPath:@"_placeholderLabel.textColor"];
    
    //注册按钮
    UIButton *registBtn = [[UIButton alloc]init];
    [bgView addSubview:registBtn];
    [registBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [registBtn setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    
    [registBtn setBackgroundImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    
    [registBtn addTarget:self action:@selector(modifyPwd) forControlEvents:UIControlEventTouchUpInside];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_phoneCodeText.mas_bottom).mas_equalTo(60 * kScreenH / 568.0f);
        make.left.mas_equalTo(22 * kScreenW / 320.0f);
        make.right.mas_equalTo(-22 * kScreenW / 320.0f);
        make.height.mas_equalTo(30 * kScreenH / 568.0f);
        
    }];


}

//获取识别码请求
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


//发送短消息
- (void)sendMsg{
    if (_verificationField.text.length == 0 || _accountText.text.length == 0 || _str6.length == 0 ){
        NSLog(@"str7:%@    str4:%@   str6:%@   ",_verificationField.text,_accountText.text,_str6);
    }else{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 设置请求格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置请求头
    
        [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
        [manager POST:@"http://mapi.loveyongtong.com/syscom/sendMsg" parameters:@{@"code":_verificationField.text,@"mobile":_accountText.text,@"encode":_str6,@"type":@"forgot"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            
            NSLog(@"-----------忘记密码发送短信%@",dic);
            
            
            
            NSString *str2 = [[dic objectForKey:@"desc"] stringByRemovingPercentEncoding]; //UTF8转汉字
            self.msgId = [[dic objectForKey:@"data"]objectForKey:@"msgId"];
            
            NSLog(@"----------------");
            NSLog(@"%@",self.msgId);
            
            
            if ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]] isEqualToString:@"200"]) {
                NSLog(@"已发送验证码");
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
            NSLog(@"%@",error);
        }];}
    
}

//修改密码
- (void)modifyPwd{
    
    if(![self.passWordText.text isEqualToString:self.passWord2Text.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入的密码不同" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancelAction];
        [self  presentViewController:alert animated:YES completion:nil];
    }
    if ( _passWordText.text.length == 0 || _accountText.text.length == 0 || _phoneCodeText.text.length == 0 ||_msgId.length == 0){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请填写完整" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

        }];
        [alert addAction:cancelAction];
        [self  presentViewController:alert animated:YES completion:nil];
        
        
        
    } else if (_passWordText.text.length <= 5){
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
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置请求头
        [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
        
        //
        [manager POST:@"http://mapi.loveyongtong.com/sysuser/forgotAndUpdatePwd" parameters:@{@"newPwd":_passWordText.text ,@"mb":_accountText.text,@"msgId":self.msgId,@"mcode":_phoneCodeText.text}  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            
            NSLog(@"-----------修改密码后返回%@",dic);
            
            NSString *str2 = [[dic objectForKey:@"desc"] stringByRemovingPercentEncoding]; //UTF8转汉字
            if ([str2 isEqualToString:@"请求头验证sid信息缺失 ![手机验证码错误！]"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请求头验证sid信息缺失 ![手机验证码错误！]" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:cancelAction];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功" preferredStyle:UIAlertControllerStyleAlert];
                [self  presentViewController:alert animated:YES completion:nil];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *	action) {
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:okAction];
            }
            NSLog(@"%@",str2);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];	
        
    }

}

#pragma mark - 代理方法
#pragma mark - 判断是否是手机号码
-(BOOL) isValidateMobile:(NSString *)mobile
{
    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:mobile];

    
    if (isMatch1 || isMatch2 || isMatch3) {
        return YES;
    }else{
        return NO;
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.accountText) {
        if (![self  isValidateMobile:self.accountText.text]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的电话号码" preferredStyle:UIAlertControllerStyleAlert];
            [self  presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
        }else{
            
        
        
        
        }
  
    }
}


@end

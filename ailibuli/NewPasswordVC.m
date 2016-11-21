//
//  NewPasswordVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/4.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "NewPasswordVC.h"

@interface NewPasswordVC ()
{
    UIView      *userView;
    UIView      *headerView;
    UITextField     *nameLabel;
    UITextField     *phoneLabel;
  
}
@end

@implementation NewPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
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
    
    self.title = @"重置登录密码";
    [self createnewPassWordView];
    // Do any additional setup after loading the view.
}
- (void)createnewPassWordView{
    userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170 * kScreenH / 568.0f)];
    userView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0];
    [self.view addSubview:userView];
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, userView.frame.size.width - 30, userView.frame.size.height - 20)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [userView addSubview:bgView];
    
    
    UILabel *nameDec = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20* kScreenH / 568.0f)];
    nameDec.text = @"原密码";
    nameDec.font = [UIFont systemFontOfSize:12* kScreenH / 568.0f];
    nameDec.textColor = [UIColor whiteColor];
    [bgView addSubview:nameDec];
    
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(nameDec.frame), bgView.frame.size.width - 30, 40* kScreenH / 568.0f)];
    nameView.backgroundColor = [[UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:163 / 255.0 alpha:1] colorWithAlphaComponent:0.88f];
    [bgView addSubview:nameView];
    
    nameLabel = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, nameView.frame.size.width, nameView.frame.size.height)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameLabel setLeftViewMode:UITextFieldViewModeAlways];
    nameLabel.secureTextEntry = YES;
    [nameView addSubview:nameLabel];
    
    UILabel *phoneDec = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(nameView.frame) + 5, 100, 20* kScreenH / 568.0f)];
    phoneDec.text = @"新密码";
    phoneDec.font = [UIFont systemFontOfSize:12* kScreenH / 568.0f];
    phoneDec.textColor = [UIColor whiteColor];
    [bgView addSubview:phoneDec];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneDec.frame), bgView.frame.size.width - 30, 40* kScreenH / 568.0f)];
    phoneView.backgroundColor = [[UIColor colorWithRed:127 / 255.0 green:127 / 255.0 blue:163 / 255.0 alpha:1] colorWithAlphaComponent:0.88f];
    [bgView addSubview:phoneView];
    
    phoneLabel = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, phoneView.frame.size.width, nameView.frame.size.height)];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [phoneLabel setLeftViewMode:UITextFieldViewModeAlways];
    [phoneView addSubview:phoneLabel];
    phoneLabel.secureTextEntry = YES;

    UIButton *addAddress = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 55, 20, 44, 44)];
    addAddress.titleLabel.font = [UIFont systemFontOfSize:15];
    [addAddress setTitle:@"完成" forState:UIControlStateNormal];
    [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(quding) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addAddress];
}

- (void)quding{
    [self.view endEditing:YES];
    [self quding1];
}

- (void)quding1{

  
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 设置请求格式
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.requestSerializer.timeoutInterval = 10.0f;
    
        // 设置返回格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 设置请求头
        [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
        [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
            NSString *url = [NSString stringWithFormat:@"http://mapi.loveyongtong.com/sysuser/updatePwd"];
    [manager POST:url parameters:@{@"pwd":nameLabel.text,@"newPwd":phoneLabel.text} progress:nil success:^(NSURLSessionDataTask *_Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]]

 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

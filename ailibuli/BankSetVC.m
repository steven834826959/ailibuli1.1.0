//
//  BankSetVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/8.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "BankSetVC.h"
#import "BankAddressVC.h"
#import "BankNameVC.h"
#import "SecuritySettingVC.h"
//城市选择器相关
#import "HXProvincialCitiesCountiesPickerview.h"
#import "HXAddressManager.h"


@interface BankSetVC ()<BankSetAddDelegate,BankNameDelegate>
@property (nonatomic, strong)UITextField *city_idField;
@property (nonatomic, strong)UITextField *parent_bank_idField;

@property (nonatomic, copy)NSString *city_id;
@property (nonatomic, copy)NSString *parent_bank_id;


//选择器视图
@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;
@end

@implementation BankSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    [self.view setBackgroundColor:BGColor];
    [self creatBankSet];

}


- (void)creatBankSet{
    
    
    UIView *view3  = [UIView new];
    [view3 setBackgroundColor:[UIColor colorWithRed:67/ 255.0 green:76/ 255.0  blue:72/255.0 alpha:0.85]];
    [view3 setFrame:CGRectMake(10 , 64 + 10* kScreenH / 568.0f , self.view.frame.size.width  - 20,  64 * 3 * kScreenH / 568.0f - 30* kScreenH / 568.0f)];
    [self.view addSubview:view3];
    
    
    UILabel *lable2 = [UILabel new];
    [lable2 setFrame:CGRectMake(20 , 64 + 24 * kScreenH / 568.0f  , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    lable2.text = @"地址";
    lable2.font = [UIFont systemFontOfSize:14* kScreenH / 568.0f];
    lable2.textAlignment = NSTextAlignmentLeft;
    lable2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:lable2];

    self.city_idField = [UITextField new];
    [self.city_idField setFrame:CGRectMake(20 , 64 + 54* kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    [self.view addSubview:self.city_idField];
    [self.city_idField setTextColor: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    [self.city_idField setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];
    [self.city_idField setPlaceholder:@" 选择开户行地址"];
    [self.city_idField setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];
     [self.city_idField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    UILabel *lable3 = [UILabel new];
    [lable3 setFrame:CGRectMake(20 , 64 + 64 * 2* kScreenH / 568.0f  - 40* kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    lable3.text = @"银行";
    lable3.font = [UIFont systemFontOfSize:14* kScreenH / 568.0f];
    lable3.textAlignment = NSTextAlignmentLeft;
    lable3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self.view addSubview:lable3];

    self.parent_bank_idField = [UITextField new];
    [self.parent_bank_idField setFrame:CGRectMake(20 , 64 + 64 * 2* kScreenH / 568.0f - 10* kScreenH / 568.0f , self.view.frame.size.width  - 40, 30* kScreenH / 568.0f)];
    [self.view addSubview:self.parent_bank_idField];
    [self.parent_bank_idField setBackgroundColor:[UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1]];
    [self.parent_bank_idField setPlaceholder:@" 选择银行"];
    [self.parent_bank_idField setTextColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]];
    [self.parent_bank_idField setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];
     [self.parent_bank_idField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
    UIView *view = [UIView new];
    UIView *view2 = [UIView new];
    [view setFrame:self.city_idField.frame];
    [view2 setFrame:self.parent_bank_idField.frame];
    view.userInteractionEnabled = YES;
    view2.userInteractionEnabled = YES;
    [self.view addSubview:view];
    [self.view addSubview:view2];
    
    
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setBank)];
    [view addGestureRecognizer:tap1];
    
    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(setBankt)];
    [view2 addGestureRecognizer:tap2];
    
    
    
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:@"确定取消紫色"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(button) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f , 30* kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50* kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f , 30* kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50* kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [label setFont:[UIFont systemFontOfSize:14]];
    label.textColor = [UIColor whiteColor];
    label.text = @"下一步";
    label.textAlignment = NSTextAlignmentCenter;
    
    
}



- (void)setBank{
    //弹出地址选择器
//    NSString *address = self.city_idField.text;
//    NSArray *array = [address componentsSeparatedByString:@" "];
//    
//    NSString *province = @"";//省
//    NSString *city = @"";//市
//    NSString *county = @"";//县
//    if (array.count > 2) {
//        province = array[0];
//        city = array[1];
//        county = array[2];
//    } else if (array.count > 1) {
//        province = array[0];
//        city = array[1];
//    } else if (array.count > 0) {
//        province = array[0];
//    }
//    
//    [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];

    BankNameVC *bankname = [BankNameVC new];
    [self.navigationController pushViewController:bankname animated:YES];
    bankname.delegate = self;

}


- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
            __strong typeof(wself) self = wself;
            
            //修改文本框内的地址
            //            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName]);
            
//            wself.selectedCell.infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
            
            
            self.city_idField.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
            
            
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}






- (void)setBankt{
    BankAddressVC *bankadd = [BankAddressVC new];
    [self.navigationController pushViewController:bankadd animated:YES];
    bankadd.delegate = self;
}
- (void)button{
    [self renzhengR];
}

- (void)renzhengR{
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.cust_nm,@"cust_nm",self.certif_id,@"certif_id",self.capAcntNo,@"capAcntNo",self.city_id,@"city_id",self.parent_bank_id,@"parent_bank_id",@"rem",@"rem", nil];
    NSLog(@"--------------认证参数%@",parDic);
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible =YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    
    
    
    [manager POST:@"http://mapi.loveyongtong.com/sysuser/account/auth" parameters:parDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"---------绑定银行卡返回%@",dic);
        
        
      
        NSString *alertStr = [[dic objectForKey:@"desc"] componentsSeparatedByString:@"!"].lastObject;
        NSString *alertStr2 = [dic objectForKey:@"desc"];
        NSString *alertStr1 = [NSString stringWithFormat:@"%@  %@  %@",alertStr2,[[dic objectForKey:@"fyData"] objectForKey:@"mchnt_txn_ssn"] ? [[dic objectForKey:@"fyData"] objectForKey:@"mchnt_txn_ssn"] : @"",[[dic objectForKey:@"fyData"] objectForKey:@"description"]];
        
        
        NSString *compStr = @"姓名、身份证号、卡号、开户行地址有误，如有疑问请联系4000998875";
        
        if ([alertStr isEqualToString:@"[错误代码：5018]"]) {
            compStr = @"根据地区代码和行别找不到对应支行!";
        }else if ([alertStr isEqualToString:@"[错误代码：5019]"]){
            compStr = @"数据校验失败!";
        }else if ([alertStr isEqualToString:@"[错误代码：5343]"]){
            compStr = @"用户已开户!";
        }else if ([alertStr isEqualToString:@"[错误代码：5850]"]){
            compStr = @"已经存在相同银行卡号注册的用户!";
        }else if ([alertStr isEqualToString:@"[错误代码：5857]"]){
            compStr = @"实名验证失败,当日总验证次数超限!";
        }else if ([alertStr isEqualToString:@"[错误代码：100012]"]){
            compStr = @"证件号码不匹配!";
        }else if ([alertStr isEqualToString:@"[错误代码：100013]"]){
            compStr = @"实名验证失败,当日总验证次数超限!";
        }else if ([alertStr isEqualToString:@"[错误代码：5836]"]){
            compStr = @"不允许信用卡注册!";
        }else if ([alertStr isEqualToString:@"[错误代码：5855]"]){
            compStr = @"该手机号绑定卡号超过2张(在代收付系统解约)!";
        }else if ([alertStr isEqualToString:@"[错误代码：5837]"]){
            compStr = @"卡号和行别不一致!";
        }else if ([alertStr isEqualToString:@"[错误代码：55137]"]){
            compStr = @"证件类型为空或者内容不正确!";
        }else if ([alertStr isEqualToString:@"[错误代码：100011]"]){
            compStr = @"卡号或者户名不符!";
        }
        
        if ([[dic objectForKey:@"code"]intValue] == 100) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:compStr ? compStr : @"" preferredStyle:UIAlertControllerStyleAlert];
            [self  presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:cancelAction];
            
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[dic objectForKey:@"desc"] preferredStyle:UIAlertControllerStyleAlert];
            [self  presentViewController:alert animated:YES completion:nil];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                UIViewController *target = nil;
                for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
                    if ([controller isKindOfClass:[SecuritySettingVC class]]) { //这里判断是否为你想要跳转的页面
                        target = controller;
                    }
                }
                if (target) {
                    [self.navigationController popToViewController:target animated:YES]; //跳转
                }
                
            }];
              [alert addAction:cancelAction];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        UIAlertController *alert = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    

}

- (void)bankSetAdd:(NSMutableDictionary *)bankAdd{
    self.parent_bank_idField.text = [bankAdd objectForKey:@"name"];
    self.parent_bank_id = [bankAdd objectForKey:@"code"];
}
- (void)bankSetName:(NSMutableDictionary *)bankName{
    
    self.city_idField.text = [bankName objectForKey:@"name"];
    self.city_id = [bankName objectForKey:@"code"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

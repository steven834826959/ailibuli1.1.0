//
//  AddressInfoViewController.m
//  UICollectionViewDemo
//
//  Created by wuyao on 16/8/30.
//  Copyright © 2016年 MonetWu. All rights reserved.
//

/*屏幕宽高*/
#define KScreenWidth        [UIScreen mainScreen].bounds.size.width
#define KScreenHeight       [UIScreen mainScreen].bounds.size.height
// 导航栏高
#define KNavgationHeight    64.0f

#import "AddressInfoViewController.h"
#import "AddressInfoTableViewCell.h"
#import "NameSetVC.h"
#import "BankNameVC.h"


//城市选择器相关
#import "HXProvincialCitiesCountiesPickerview.h"
#import "HXAddressManager.h"


@interface AddressInfoViewController ()<UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,NameSetDelegate,BankNameDelegate>

//选择器视图
@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;

@property(nonatomic,strong)AddressInfoTableViewCell *selectedCell;

@end

static NSString *cellIdentifier = @"addressIdentifier";
@implementation AddressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.addArr.count == 0) {
        self.addArr = [NSMutableArray array];
    }
    
    self.title = @"新增收货地址";
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
    
    
    self.dic = [NSMutableDictionary new];
    self.cellTextArray = @[@"省份", @"详细地址", @"邮政编码"];
    
    self.tableView.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
    [self.view addSubview:self.tableView];
    [self _creatUI];
    
    
    UIButton *button = [UIButton new];
    [self.view addSubview:button];
    [button setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    [button addTarget:self action:@selector(baocun) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190* kScreenW / 320.0f, 30* kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50* kScreenH / 568.0f - 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    self.saveBtn = button;
    
    
    
    
    UILabel *label = [UILabel new];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(190 * kScreenW / 320.0f, 30 * kScreenH / 568.0f));
        make.bottom.mas_equalTo(-50* kScreenH / 568.0f- 49);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    [label setFont:[UIFont systemFontOfSize:14* kScreenH / 568.0f]];
    label.textColor = [UIColor whiteColor];
    label.text = @"保存";
    label.textAlignment = NSTextAlignmentCenter;
    
    self.saveLabel = label;
    
    
    
    if (_ifdelete) {
        UIButton *deleteAddress = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 55, 20, 44, 44)];
        deleteAddress.titleLabel.font = [UIFont systemFontOfSize:15];
        [deleteAddress setTitle:@"删除" forState:UIControlStateNormal];
        [deleteAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [deleteAddress addTarget:self action:@selector(deleteAddressAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteAddress];
        self.dic = [self.addArr objectAtIndex:self.cellNo];
    }
    
}

- (void)deleteAddressAction{
    [self.addArr removeObjectAtIndex:self.cellNo];
    [self AddbaocunRequest: @{@"postAddress":self.addArr}];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

- (void)_creatUI
{
    userView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170* kScreenH / 568.0f)];
    userView.backgroundColor = [[UIColor clearColor] colorWithAlphaComponent:0];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 10, userView.frame.size.width - 30, userView.frame.size.height - 20)];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.65];
    [userView addSubview:bgView];
    
    
    UILabel *nameDec = [[UILabel alloc] initWithFrame:CGRectMake(15, 10* kScreenH / 568.0f, 100, 20* kScreenH / 568.0f)];
    nameDec.text = @"收货人";
    nameDec.font = [UIFont systemFontOfSize:12* kScreenH / 568.0f];
    nameDec.textColor = [UIColor whiteColor];
    [bgView addSubview:nameDec];
    
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(nameDec.frame), bgView.frame.size.width - 30, 40* kScreenH / 568.0f)];
    nameView.backgroundColor = [[UIColor colorWithRed:144/255.0 green:142/255.0 blue:172/255.0 alpha:0.9] colorWithAlphaComponent:0.88f];
    [bgView addSubview:nameView];
    
    nameLabel = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, nameView.frame.size.width, nameView.frame.size.height)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [nameLabel setLeftViewMode:UITextFieldViewModeAlways];
    [nameView addSubview:nameLabel];
    
    UILabel *phoneDec = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(nameView.frame) + 5, 100, 20* kScreenH / 568.0f)];
    phoneDec.text = @"电话号码";
    phoneDec.font = [UIFont systemFontOfSize:12* kScreenH / 568.0f];
    phoneDec.textColor = [UIColor whiteColor];
    [bgView addSubview:phoneDec];
    
    UIView *phoneView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(phoneDec.frame), bgView.frame.size.width - 30, 40* kScreenH / 568.0f)];
    phoneView.backgroundColor = [[UIColor colorWithRed:144/255.0 green:142/255.0 blue:172/255.0 alpha:0.9] colorWithAlphaComponent:0.88f];
    [bgView addSubview:phoneView];
    
    phoneLabel = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, phoneView.frame.size.width, nameView.frame.size.height)];
    phoneLabel.textColor = [UIColor whiteColor];
    phoneLabel.clearButtonMode = UITextFieldViewModeWhileEditing;
    [phoneLabel setLeftViewMode:UITextFieldViewModeAlways];
    [phoneView addSubview:phoneLabel];
    
    self.tableView.tableHeaderView = userView;

    
    if (self.ifdelete) {
        nameLabel.text = [[self.addArr objectAtIndex:self.cellNo] objectForKey:@"name"];
        phoneLabel.text = [[self.addArr objectAtIndex:self.cellNo] objectForKey:@"mobile"];
    }
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[AddressInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    NSString *title;
    if (indexPath.row == 0) {
        title = [self.cellTextArray objectAtIndex:0];
        if (self.ifdelete) {
            
            [cell  setTitleText:title infoText:[[self.addArr objectAtIndex:self.cellNo] objectForKey:@"provinces"]];
            
        }else{
            
            [cell  setTitleText:title infoText:[self.dic objectForKey:@"provinces"]];
        }
        
    }else if (indexPath.row == 1){
        title = [self.cellTextArray objectAtIndex:1];
        if (self.ifdelete) {
            [cell  setTitleText:title infoText:[[self.addArr objectAtIndex:self.cellNo] objectForKey:@"add"]];
        }else{
            [cell  setTitleText:title infoText:[self.dic objectForKey:@"add"]];
        }
        
    }else if (indexPath.row == 2){
        title = [self.cellTextArray objectAtIndex:2];
        if (self.ifdelete) {
            [cell  setTitleText:title infoText:[[self.addArr objectAtIndex:self.cellNo] objectForKey:@"postal"]];
        }else{
            [cell  setTitleText:title infoText:[self.dic objectForKey:@"postal"]];

        }
    }
    return cell;
}

- (void)bankSetName:(NSMutableDictionary *)bankName{
    [self sendinput:[bankName objectForKey:@"name"] cell:0];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectedCell = cell;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    if (indexPath.row == 0) {
        BankNameVC *add = [BankNameVC new];
        add.delegate = self;
        [self.navigationController pushViewController:add animated:YES];
    }else{
        NameSetVC *nameSet = [NameSetVC new];
        nameSet.delegate = self;
        nameSet.i = indexPath.row;
        [self.navigationController pushViewController:nameSet animated:YES];

    }
    
}

- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
        __strong typeof(wself) self = wself;

            NSLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName]);
            
            wself.selectedCell.infoLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
   
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}



- (void)sendinput:(NSString *)str cell:(NSInteger)i{
    if (self.ifdelete) {
        if (i == 0) {
            [self.dic setObject:str forKey:@"provinces"];
            [self.addArr replaceObjectAtIndex:self.cellNo withObject:self.dic];
            
            [self.tableView reloadData];
            
        }else if(i == 1){
            [self.dic setObject:str forKey:@"add"];
            [self.addArr replaceObjectAtIndex:self.cellNo withObject:self.dic];
            
            [self.tableView reloadData];
            
        }else if(i == 2){
            [self.dic setObject:str forKey:@"postal"];
            [self.addArr replaceObjectAtIndex:self.cellNo withObject:self.dic];
            [self.tableView reloadData];
        }

    }else{
        if (i == 0) {
            [self.dic setObject:str forKey:@"provinces"];            
            [self.tableView reloadData];
            
        }else if(i == 1){
            [self.dic setObject:str forKey:@"add"];
            [self.tableView reloadData];
            
        }else if(i == 2){
            [self.dic setObject:str forKey:@"postal"];
            [self.tableView reloadData];
        }
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f * kScreenH / 568.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)baocun{
//    [self.view endEditing:YES];

    [self.dic setObject:nameLabel.text forKey:@"name"];
    [self.dic setObject:phoneLabel.text forKey:@"mobile"];
    if (self.ifdelete) {
        [self.addArr replaceObjectAtIndex:self.cellNo withObject:self.dic];
    }else{
        [self.addArr addObject:self.dic];

    }
    [self AddbaocunRequest: @{@"postAddress":self.addArr}];
    
}
- (void)AddbaocunRequest:(id)json{
    
    
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
    
    
    NSDictionary *dic = (NSDictionary *)json;
    NSLog(@"-------------保存地址参数%@",dic);

    [manager POST:@"http://mapi.loveyongtong.com/sysuser/updateInfo" parameters:json progress:^(NSProgress * _Nonnull uploadProgress) {
        

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

        
        //     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"更新成功" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:cancelAction];
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


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end

//
//  AddressViewController.m
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

#import "AddressViewController.h"
#import "AddressInfoViewController.h"
#import "AddressTableViewCell.h"
#import "BankNameVC.h"
@interface AddressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *addressArray;
@property (nonatomic,strong) UILabel *lb;

@end

static NSString *cellIdentifier = @"cellIdentifier";
@implementation AddressViewController

- (NSMutableArray *)addressArray
{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    
    return _addressArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self GRXXRequest];
    self.title = @"收货地址";
    
    UIButton *addAddress = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 55, 20, 44, 44)];
    addAddress.titleLabel.font = [UIFont systemFontOfSize:15];
    [addAddress setTitle:@"新增" forState:UIControlStateNormal];
    [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addAddress];
    
    //设置背景图
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
    
    self.tableView.frame = CGRectMake(0, 2, KScreenWidth, KScreenHeight);
    [self.view addSubview:self.tableView];
    
    self.lb = [UILabel new];
    [ self.lb setTextColor:[UIColor whiteColor]];
    self.lb.textAlignment = NSTextAlignmentCenter;
    self.lb.font = [UIFont systemFontOfSize:20];
    
    [ self.lb setFrame:CGRectMake(0, 200, self.view.frame.size.width, 25)];
    [self.tableView addSubview: self.lb];
    
}

- (void)addAddressAction:(UIButton *)sender
{
    AddressInfoViewController *vc = [[AddressInfoViewController alloc]init];
    vc.addArr = self.addressArray;
    [self.navigationController pushViewController:vc animated:YES];
}

// 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    }
    return _tableView;
}

#pragma mark -
#pragma mark - UITableViewDelegate && UITableViewDataSource -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.addressArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil]lastObject];
    }
    [cell.contentView setBackgroundColor:BGColor];
    [cell.bgView setFrame:cell.contentView.frame];
    
    cell.userName.text = [NSString stringWithFormat:@"  %@",[[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"name"] ? [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"name"]: @"无"];
    cell.userPhone.text = [NSString stringWithFormat:@"%@",[[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"mobile"] ? [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"mobile"] : @"无"];
    cell.ueerAddress.text = [NSString stringWithFormat:@"%@",[[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"add"] ? [[self.addressArray objectAtIndex:indexPath.row]objectForKey:@"add"] : @"无"];
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //添加城市选择器
        AddressInfoViewController *vc = [[AddressInfoViewController alloc]init];
        vc.addArr = self.addressArray;
        vc.cellNo = indexPath.row;
        vc.ifdelete = YES;
        [self.navigationController pushViewController:vc animated:YES];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120.f;
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
- (void)GRXXRequest{
    
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
    
    [manager GET:@"http://mapi.loveyongtong.com/sysuser/getUserInfo" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.addressArray = [[dic objectForKey:@"data"] objectForKey:@"postAddress"];
 
        [self.tableView reloadData];
        
        if (self.addressArray.count == 0) {
            self.lb.hidden = NO;
            self.lb.text = @"您还未添加地址,请新增地址!";

        }else{
            self.lb.hidden = YES;

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self GRXXRequest];
  
}


@end

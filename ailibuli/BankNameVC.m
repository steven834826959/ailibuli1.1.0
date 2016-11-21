//
//  BankNameVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/9.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "BankNameVC.h"

@interface BankNameVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *arr;
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)UITableView *tableone;
@property (nonatomic, strong)NSMutableArray *arrAdd;

@end

@implementation BankNameVC

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
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createTable];
    [self yinhangdaima];
    [self.table setSeparatorInset:UIEdgeInsetsZero];
    [self.table setLayoutMargins:UIEdgeInsetsZero];
    [self.tableone setSeparatorInset:UIEdgeInsetsZero];
    [self.tableone setLayoutMargins:UIEdgeInsetsZero];

}

- (void)yinhangdaima{
    
    self.arr = [NSMutableArray array];
    self.arrAdd = [NSMutableArray array];
    
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

    NSLog(@"%@",[defaults objectForKey:@"secretKey"]);
    NSLog(@"%@",[defaults objectForKey:@"sessionid"]);
    NSLog(@"%@",[defaults objectForKey:@"userId"]);

    [manager GET:@"http://mapi.loveyongtong.com/fypay/cityList" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        self.arr = [dic objectForKey:@"data"];
        
        [self.table reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];

}
- (void)createTable{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 120 , [UIScreen mainScreen].bounds.size.height - 50 - 64)];
    [self.table setBackgroundColor:[UIColor clearColor]];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [UIView new];
    self.table.tableHeaderView = [UIView new];
    [self.view addSubview:self.table];
    
    self.tableone = [[UITableView alloc]initWithFrame:CGRectMake(120, 64, self.view.frame.size.width - 120 , [UIScreen mainScreen].bounds.size.height - 50 - 64)];
    [self.tableone setBackgroundColor:[UIColor clearColor]];
    self.tableone.delegate = self;
    self.tableone.dataSource = self;
    self.tableone.tableFooterView = [UIView new];
    self.tableone.tableHeaderView = [UIView new];
    [self.view addSubview:self.tableone];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableone) {
        return self.arrAdd.count;
    }
    if (tableView == self.table) {
        return self.arr.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"Identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (tableView == self.table) {
        cell.textLabel.text = [[self.arr objectAtIndex:indexPath.row]objectForKey:@"name"];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.textColor = [UIColor blackColor];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if (tableView == self.tableone) {
        cell.textLabel.text = [[self.arrAdd objectAtIndex:indexPath.row]objectForKey:@"name"];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.textLabel.textColor = [UIColor blackColor];
        [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.table) {
        self.arrAdd = [[self.arr objectAtIndex:indexPath.row]objectForKey:@"children"];
        [self.tableone reloadData];

    }
    if (tableView == self.tableone) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate bankSetName:[self.arrAdd objectAtIndex:indexPath.row]];
    }
   
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

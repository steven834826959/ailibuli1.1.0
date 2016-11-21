//
//  BankAddressVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/9.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "BankAddressVC.h"
#import "BankSetVC.h"
@interface BankAddressVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)NSMutableArray *arr;
@end

@implementation BankAddressVC

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
    
    [self createTable];
    [self yinhangdaima];

}
- (void)yinhangdaima{
    
    self.arr = [NSMutableArray array];
    
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
    
    
    [manager GET:@"http://mapi.loveyongtong.com/fypay/bankList" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.arr = [dic objectForKey:@"data"];
        [self.table reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
}

- (void)createTable{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 50)];
    [self.table setBackgroundColor:BGColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableFooterView = [UIView new];
    self.table.tableHeaderView = [UIView new];
    [self.view addSubview:self.table];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
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
    cell.textLabel.text = [[self.arr objectAtIndex:indexPath.row]objectForKey:@"name"];
    [cell setBackgroundColor:BGColor];
    cell.textLabel.textColor = [UIColor whiteColor];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.delegate bankSetAdd:[self.arr objectAtIndex:indexPath.row]];
}


@end

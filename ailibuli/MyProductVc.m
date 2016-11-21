//
//  MyProductVC.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "MyProductVc.h"
#import "ProductView.h"
#import "JBView.h"
#import "ProductCell.h"
#import "ProductHeaderView.h"
// 产品详情
#import "ProductDetailsVc.h"
#import "MJRefresh/MJRefresh.h"

/**
 *  我的产品控制器
 */


@interface MyProductVc()<UITableViewDelegate,UITableViewDataSource>
/** tableView*/
@property (nonatomic ,strong) UITableView *tableview;
@property (nonatomic ,strong) JBView *jbView;
@property (nonatomic ,strong) NSMutableArray *arr;// 已购买数据;
@property (nonatomic ,assign)int i;// 页码;
@end

@implementation MyProductVc

- (NSMutableArray *)arr{
    if (_arr == nil){
        _arr = [NSMutableArray array];
    }
    return _arr;
}

static NSString * ID = @"productcell";


- (void)viewDidLoad{
    [super viewDidLoad];
    self.i = 1;
    [self setupUI];
    [self.tableview registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self yigoumai];
//    [self setupRefresh];
    [self YTBRequest];
    [self tongjirequest];
}
- (void)setupRefresh{

    [self updateRefresh];
}

- (void)updateRefresh{
    [self moreData];
}

// 设置UI
- (void)setupUI{
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
    
    self.navigationItem.title = @"我的产品";
    // 爱你妹
     ProductView *productView1 = [[ProductView alloc] init];
    [productView1.btn setImage:[UIImage imageNamed:@"11"] forState:0];
    productView1.text_label.text = @"爱你妹";
    productView1.text_label.textColor = [UIColor whiteColor];
    [self.view addSubview:productView1];
    
    [productView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(110);
    }];
   
    
    // 守卫侠
    ProductView *productView2 = [[ProductView alloc] init];
    [productView2.btn setImage:[UIImage imageNamed:@"12"] forState:0];
    productView2.text_label.text = @"守爱侠";
    productView2.text_label.textColor = [UIColor whiteColor];
    [self.view addSubview:productView2];
    
    [productView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(110);
    }];
    
    // 守卫侠
    ProductView *productView3 = [[ProductView alloc] init];
    [productView3.btn setImage:[UIImage imageNamed:@"13"] forState:0];
    productView3.text_label.text = @"潘多拉";
    productView3.text_label.textColor = [UIColor whiteColor];
    [self.view addSubview:productView3];
    
    [productView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(14);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(110);
    }];
    
    // 已获得永同币
     self.jbView = [JBView JbView];
    [self.view addSubview:self.jbView];
    [self.jbView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(productView1.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(73.0 / 568 *kScreenH);
    }];

    // 更多按钮
    UIButton *moreBtn = [UIButton new];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    moreBtn.backgroundColor = kColor(234,134,150);
    [moreBtn setTitle:@"更多" forState:0];

    [moreBtn addTarget:self action:@selector(setupRefresh) forControlEvents:UIControlEventTouchUpInside];
    [moreBtn setTintColor:[UIColor whiteColor]];
    [self.view addSubview:moreBtn];
    
  
    
    // 产品列表
    self.tableview = [[UITableView alloc] init];
    self.tableview.delegate = self;


    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.rowHeight = 27.0 / 568 * kScreenH;
    self.tableview.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableview];
    
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(64);
        make.right.mas_equalTo(-64);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.top.mas_equalTo(self.tableview.mas_bottom).offset(30);
        if (kScreenH == 568) {
            make.top.mas_equalTo(self.tableview.mas_bottom).offset(10);
        }
    }];
    
    
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo( 27.0 / 568 * kScreenH * 7-2);
        make.top.mas_equalTo(self.jbView.mas_bottom).offset(15);
        
    }];
    // 设置header
    
    ProductHeaderView *headerView = [ProductHeaderView headerView];
    headerView.frame = CGRectMake(0, 0, kScreenW, 27.0 / 568 * kScreenH);
    self.tableview.tableHeaderView = headerView;
    
}


//TableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath.row %2 == 0){
        
        UIImageView *cellBackIV =[[UIImageView alloc]initWithFrame:cell.frame];
        UIImage *ima = [UIImage imageNamed:@"产品"];
        cellBackIV.image = ima;
        cell.backgroundView = cellBackIV;
        
    }else{
        
        UIImageView *cellBackIV =[[UIImageView alloc]initWithFrame:cell.frame];
        UIImage *ima = [UIImage imageNamed:@"产品2"];
        cellBackIV.image = ima;
        cell.backgroundView = cellBackIV;
        
    }
    
    cell.productNameLabel.text = [[self.arr objectAtIndex:indexPath.row]objectForKey:@"name"];
    cell.countLabel.text = [NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row]objectForKey:@"buyNum"]];
   
    if ([[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row]objectForKey:@"status"]] isEqualToString:@"1"]) {
    cell.haveLabel.text = @"拥有中";
    }else if ([[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row]objectForKey:@"status"]] isEqualToString:@"2"]) {
        cell.haveLabel.text = @"赎回中";
    }else if ([[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row]objectForKey:@"status"]] isEqualToString:@"3"]) {
        cell.haveLabel.text = @"赎回成功";
    }
    cell.buyMoneyLabel.text = [NSString stringWithFormat:@"%d元",[[[self.arr objectAtIndex:indexPath.row]objectForKey:@"totalCost"]intValue] / 100];

    
     cell.buyTimeLabel.text = [[[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row]objectForKey:@"buyTime"]] substringToIndex:10]stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        // 产品详情控制器
        ProductDetailsVc *pdVc = [ProductDetailsVc new];
        pdVc._id =  [NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row]objectForKey:@"_id"]];
        [self.navigationController pushViewController:pdVc animated:YES];
}


// 点击更多
- (void)clickMoreBtn{
//    [self.tableview trig];
    [self.tableview.mj_footer beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self yigoumai];
}


// 数据请求
- (void)yigoumai{
    
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
    
    [manager GET:@"http://mapi.loveyongtong.com/loan/get-myLoans" parameters:@{@"size":@"6",@"index":@"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"--------------已经购买:  %@",dic);
        self.arr = [dic objectForKey:@"data"];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        UIAlertController *alert = [UIAlertController internetErrorAlertShow];
    
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }];
}




// 请求更多
- (void)moreData{
    self.i ++;
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
    NSString *str = [NSString stringWithFormat:@"%d",self.i];
    [manager GET:@"http://mapi.loveyongtong.com/loan/get-myLoans" parameters:@{@"size":@"6",@"index":str} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.arr addObjectsFromArray:[dic objectForKey:@"data"]];
        [self.tableview reloadData];
        [self.tableview.mj_footer endRefreshing];
        [self.tableview setContentOffset:CGPointMake(0, self.tableview.bounds.size.height - 30) animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableview.mj_footer endRefreshing];
       
       UIAlertController *alert = [UIAlertController internetErrorAlertShow];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }];
}


- (void)YTBRequest{
    
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
        NSLog(@"%@",dic);
        self.jbView.ygbCount.textColor = [UIColor whiteColor];
        self.jbView.ygbCount.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"accumulation"] ? [[dic objectForKey:@"data"]objectForKey:@"accumulation"] : @"**"];
        [self.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
// 统计请求
- (void)tongjirequest{
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
    
    [manager GET:@"http://mapi.loveyongtong.com/loan/statistic" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        self.jbView.ainimeiCount.text = [NSString stringWithFormat:@"%@", [[[dic objectForKey:@"data"]objectAtIndex:1]objectForKey:@"count"]];
        self.jbView.ainimeiCount.textColor = [UIColor whiteColor];
        
        self.jbView.shouaixiaCount.text = [NSString stringWithFormat:@"%@", [[[dic objectForKey:@"data"]objectAtIndex:2]objectForKey:@"count"]];
        self.jbView.shouaixiaCount.textColor = [UIColor whiteColor];
        
        self.jbView.xingfuCount.text = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectAtIndex:0]objectForKey:@"count"]];
        self.jbView.xingfuCount.textColor = [UIColor whiteColor];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
 
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
@end

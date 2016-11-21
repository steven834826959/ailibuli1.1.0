//
//  DealRecodVc.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "DealRecodVc.h"
#import "DealRecodView.h"
#import "DealRecodCell.h"

/**
 *  交易记录控制器
 */

@interface DealRecodVc ()<UITableViewDataSource>


@property (nonatomic ,strong) UITableView *dealreocdTableView;
@property (nonatomic ,strong) NSMutableArray *arr;

@end

@implementation DealRecodVc

static NSString *ID = @"drcell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
    self.arr = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.dealreocdTableView registerNib:[UINib nibWithNibName:@"DealRecodCell" bundle:nil] forCellReuseIdentifier:ID];
    self.dealreocdTableView.rowHeight = 27.0/568.0f *kScreenH;
    [self xiangqing];
    
}




// 设置UI
- (void)setupUI{
    self.title = @"交易记录";
    
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
    
    _dealreocdTableView = [UITableView new];
    _dealreocdTableView.backgroundColor = [UIColor clearColor];
    _dealreocdTableView.dataSource = self;
    _dealreocdTableView.scrollEnabled = YES;
    _dealreocdTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:_dealreocdTableView];
    
    [_dealreocdTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(self.view.frame.size.height - 70 - 52);
    }];
    
    DealRecodView *headerView = [DealRecodView dealrecodView];
    headerView.height = 27.0/568 *kScreenH;
    self.dealreocdTableView.tableHeaderView = headerView;
    self.dealreocdTableView.tableFooterView = [UIView new];
}

//- (void)xiangqing{
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 设置请求格式
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    // 设置返回格式
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    // 设置请求头
//    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
//    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
//    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
//    [manager GET:@"http://114.215.96.97:20002/fypay/queryDetails?user_ids=13916263585&start_day=20160801&end_day=20160830" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//     
//        self.arr = [[[[[[[dic objectForKey:@"data"]objectForKey:@"opResultSet"]objectForKey:@"opResult"] objectAtIndex:0] objectForKey:@"details"]objectAtIndex:0] objectForKey:@"detail"];
//        NSLog(@"个数:%ld",self.arr.count);
//
//        
//        [self.dealreocdTableView reloadData];
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //        NSLog(@"%@",error);
//    }];
//
//}

- (NSString *)GetTomorrowDay:(NSDate *)aDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:aDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init] ;
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

- (void)xiangqing{

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    
    NSDate *date = [NSDate date];
    
    NSString *dateStr = [self GetTomorrowDay:date];
    
    NSString *Str = [NSString stringWithFormat:@"http://mapi.loveyongtong.com/fypay/queryCostList?user_ids=%@&start_day=2016-09-01&end_day=%@&index=1&size=200",[defaults objectForKey:@"phone"],dateStr];
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager GET:Str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"---------交易记录返回值%@",dic);
        

        self.arr = [[dic objectForKey:@"data"]objectForKey:@"list"];

        NSLog(@"%@",self.arr);
        [self.dealreocdTableView reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];

}


// 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DealRecodCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    NSString *str = [NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row] objectForKey:@"rechargeType"]];
    
    if ([str isEqualToString:@"1"]) {
        cell.productNameLabel.text = @"充值";
    }else if ([str isEqualToString:@"2"]) {
        cell.productNameLabel.text = @"消费";
    }else if ([str isEqualToString:@"3"]) {
        cell.productNameLabel.text = @"收益";
    }else if ([str isEqualToString:@"4"]) {
        cell.productNameLabel.text = @"提现";
    }else if ([str isEqualToString:@"5"]) {
        cell.productNameLabel.text = @"赎回";
    }
    
  
//    cell.countLabel;
    
//     购买金额
    int i = [[[self.arr objectAtIndex:indexPath.row] objectForKey:@"count"] intValue] / 100;
    
    cell.buyMoneyLabel.text = [NSString stringWithFormat:@"%d元",i];
    

//     交易日期
    cell.buyDateLabel.text = [NSString stringWithFormat:@"%@",[[[self.arr objectAtIndex:indexPath.row] objectForKey:@"createDate"]substringToIndex:10]];

    
    return cell;
}





@end

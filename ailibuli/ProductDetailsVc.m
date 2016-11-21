//
//  ProductDetailsVc.m
//  ailibuli
//
//  Created by user on 16/7/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductDetailsVc.h"
#import "WQFButton.h"
#import "ProductListVC.h"
#import "ServiceVC.h"
#import "YTBasicServiceViewController.h"

/**
 *  产品详情控制器
 */


@interface ProductDetailsVc ()<UITableViewDataSource>

//@property (nonatomic, strong) UIImageView *imageView;

/** 数组*/
@property (nonatomic ,strong) NSArray *detailsArray;

/** tableview*/
@property (nonatomic ,strong) UITableView *pdTableView;

/** 数据数组*/
@property (nonatomic ,strong) NSMutableArray *dataArray;


@property (nonatomic ,copy) NSString *loanCategory;

@property (nonatomic, strong) NSMutableArray *loanCategoryArr;


@property (nonatomic, copy) NSString *loanID;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong)UILabel *sLabel;
@end

@implementation ProductDetailsVc

static NSString *ID = @"pdcell";



- (NSArray *)detailsArray{
    if (_detailsArray == nil) {
        _detailsArray = [NSArray array];
        _detailsArray = @[@"数量",@"购买时间",@"产品期限",@"已计息天数",@"期限剩余天数",@"购买金额",@"拥有状态"];
    }
    return _detailsArray;
}

//- (UIImageView *)imageView{
//    
//    if (_imageView == nil) {
//        
//        _imageView = [UIImageView new];
//        _imageView.frame = CGRectMake(20, 94, 150,50);
//        [self.view addSubview:_imageView];
//    }
//    return _imageView;
//}




- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
    [self yigoumai];
    
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(0, 64, self.view.frame.size.width, 41)];
    [view setBackgroundColor:kColor(41 , 140, 134)];
    [self.view addSubview:view];
    UILabel *label1 = [UILabel new];
    [label1 setFrame:CGRectMake(20, 0, self.view.frame.size.width - 20, 41)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = [UIColor whiteColor];
    label1.text = @"产品名称";
    label1.font = [UIFont systemFontOfSize:15];
    [view addSubview:label1];
    
    
    
    self.sLabel = [UILabel new];
    [self.sLabel setFrame:CGRectMake(0, 0, self.view.frame.size.width - 20, 41)];
    self.sLabel.textAlignment = NSTextAlignmentRight;
    self.sLabel.textColor = [UIColor whiteColor];
    self.sLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:self.sLabel];
    
    
}
- (void)chanpinXinxi{
    ProductListVC *view = [ProductListVC new];
    view.chanpin = self.loanCategoryArr;
    view.state = self.status;
    [self.navigationController pushViewController:view animated:YES];

}

- (void)chakanFuwu{
    YTBasicServiceViewController *view = [YTBasicServiceViewController new];

    [self.navigationController pushViewController:view animated:YES];

}


- (void)shuhui{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"点是否赎回" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"赎回" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self shuhuiRequest];
        
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)shuhuiRequest{
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

    [manager GET:@"http://mapi.loveyongtong.com/loan/takeBack" parameters:@{@"loanId":self.loanID} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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

- (void)setupUI{
    self.title = @"产品详情";
    self.view.backgroundColor = kColor(81, 188, 179);
    self.pdTableView  = [UITableView new];
    [self.pdTableView  setFrame:CGRectMake(0, 41, self.view.frame.size.width, 41 * 9 )];
    self.pdTableView .dataSource = self;
    self.pdTableView .scrollEnabled = NO;
    self.pdTableView .separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.pdTableView ];
    
    // 产品信息按钮
    WQFButton *infoBtn = [WQFButton new];
    [infoBtn setTitle:@"产品信息" forState:0];
    [infoBtn setBackgroundImage:[UIImage imageNamed:@"紫色条"] forState:0];
    infoBtn.backgroundColor = [UIColor whiteColor];
    [infoBtn addTarget:self action:@selector(chanpinXinxi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoBtn];
    // 查看服务按钮
    WQFButton *sericeBtn = [WQFButton new];
    [sericeBtn setTitle:@"查看服务" forState:0];
    [sericeBtn setBackgroundImage:[UIImage imageNamed:@"紫色条"] forState:0];
    [sericeBtn addTarget:self action:@selector(chakanFuwu) forControlEvents:UIControlEventTouchUpInside];

    sericeBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:sericeBtn];
    

    
    
    // 赎回按钮
    WQFButton *redeemBtn = [WQFButton new];
    [redeemBtn setTitle:@"赎回" forState:0];

    [redeemBtn addTarget:self action:@selector(shuhui) forControlEvents:UIControlEventTouchUpInside];
    [redeemBtn setBackgroundColor:[UIColor colorWithRed:36/255.0 green:117/255.0 blue:123/255.0 alpha:1]];
    
    [self.view addSubview:redeemBtn];
    
    
    [infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.width.mas_equalTo((kScreenW-40-2)/3.0);
        make.right.mas_equalTo(sericeBtn.mas_left).offset(-1);
        make.top.mas_equalTo(self.pdTableView.mas_bottom).offset(25);
        
    }];
    [sericeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pdTableView.mas_bottom).offset(25);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.right.mas_equalTo(redeemBtn.mas_left).offset(-1);
        make.width.mas_equalTo((kScreenW-40-2)/3.0);

    }];
    [redeemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pdTableView.mas_bottom).offset(25);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.right.mas_equalTo(-20);

    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.detailsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row %2 == 0){
        cell.backgroundColor = kColor(66, 118, 112);
    }else{
        cell.backgroundColor = kColor(64, 144, 136);
    }
    
    cell.textLabel.text = self.detailsArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if (self.dataArray.count == 0) {
        
    }else{
        cell.detailTextLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    }
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}
// 数据请求
- (void)yigoumai{
    self.dataArray = [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager GET:@"http://mapi.loveyongtong.com/loan/myLoanDetails" parameters:@{@"id":self._id} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"已经购买:  %@",dic);
        NSString *buyNum = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"buyCount"]];
        NSString *buyTime =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"buyDate"]];
        NSString *xianqi = [NSString stringWithFormat:@"%@", [[dic objectForKey:@"data"]objectForKey:@"loanInterval"]];
        NSString *yijixi = [NSString stringWithFormat:@"%@", [[dic objectForKey:@"data"]objectForKey:@"yieldDays"]];
        NSString *shengyuitan = [NSString stringWithFormat:@"%@", [[dic objectForKey:@"data"]objectForKey:@"overDays"]];
        NSString *totalCost = [NSString stringWithFormat:@"%d", [[[dic objectForKey:@"data"]objectForKey:@"totalCost"]intValue]/100];
        NSString *status = [NSString string];
        NSLog(@"%@",[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"status"]]);
        if ([[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"status"]] isEqualToString:@"1"]) {
            status = @"已拥有";
        }else if ([[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"status"]] isEqualToString:@"2"]){
            status = @"赎回中";
        }else if ([[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"]objectForKey:@"status"]] isEqualToString:@"3"]){
            status = @"赎回成功";
        }
        self.loanCategory = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loanCategory"] objectForKey:@"_id"]];
        self.loanID = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"myLoanId"]];
        self.status = [NSString stringWithFormat:@"%@",[[[dic objectForKey:@"data"]objectForKey:@"loanCategory"] objectForKey:@"loveStatus"]];
        [_dataArray addObject:buyNum];
        [_dataArray addObject:buyTime];
        [_dataArray addObject:xianqi];
        [_dataArray addObject:yijixi];
        [_dataArray addObject:shengyuitan];
        [_dataArray addObject:totalCost];
        [_dataArray addObject:status];
        [self.pdTableView reloadData];
        
        if ([self.status isEqualToString:@"married"]){
            self.sLabel.text = @"潘多拉";
        }else if ([self.status isEqualToString:@"single"]){
            self.sLabel.text = @"爱你妹";

        }else if ([self.status isEqualToString:@"inLove"]){
            self.sLabel.text = @"守爱侠";

        }
        
        
        [self chanpin:self.loanCategory];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}
- (void)chanpin:(NSString *)str{
    self.loanCategoryArr = [NSMutableArray array];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager POST:@"http://mapi.loveyongtong.com/loan/getList" parameters:    @{@"size":@"4",@"index":@"1",@"categoryId":str}
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             self.loanCategoryArr = [dic objectForKey:@"data"];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

             UIAlertController *alert = [UIAlertController internetErrorAlertShow];
             [self presentViewController:alert animated:YES completion:nil];
             
             
         }];
    

}


@end

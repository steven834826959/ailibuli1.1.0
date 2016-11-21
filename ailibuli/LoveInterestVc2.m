//
//  LoveInterestVc2.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "LoveInterestVc2.h"
#import "LoveInteresCell.h"
#import "LoveInterestHeaderView.h"
#import "WQFButton.h"
#import "GoOnPayBtn.h"
#import "MJRefresh/MJRefresh.h"
#import "GivenObjectVC.h"
/**
 *  爱的利息-已兑换控制器
 */

@interface LoveInterestVc2 ()<UITableViewDataSource,UITableViewDelegate>
/** tablevieq*/
@property (nonatomic ,strong) UITableView *loveTableView;
/** arr*/
@property (nonatomic ,strong) NSMutableArray *arr;
/** 选中*/
@property (nonatomic ,strong) NSMutableArray *selectArr;

/** 是否选中*/
@property (nonatomic ,assign) BOOL isSelected;
@end

@implementation LoveInterestVc2

- (NSMutableArray *)selectArr{
    if (_selectArr == nil) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}

- (NSMutableArray *)arr {
    if (_arr == nil) {
        _arr = [NSMutableArray array];
        // 初始化一些数据
    }
    return _arr;
}

static NSString *ID = @"licell2";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self yigoumaiRequest];

}







- (void)viewDidLoad {
    
    [super viewDidLoad];
  
    [self yigoumaiRequest];

    [self setupUI];
    
    [self.loveTableView registerNib:[UINib nibWithNibName:@"LoveInteresCell" bundle:nil] forCellReuseIdentifier:ID];
    
//    [self.arr addObjectsFromArray:@[@1,@2,@2,@3,@4,@4]];
//    [self setupRefresh];
}
//- (void)setupRefresh{
//    
//    self.loveTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateRefresh)];
//}
//
//- (void)updateRefresh{
//    [self moreData];
//}
//
//- (void)moreData{
//
//    [self.loveTableView reloadData];
//    [self.loveTableView.mj_footer endRefreshing];
//
//}

- (void)setupUI{
    
    self.title = @"爱的利息-已兑换";
    
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
    
    GoOnPayBtn *btn = [GoOnPayBtn new];
    btn.backgroundColor = kColor(234, 134, 150);
    [btn setTitle:@"您已经兑换" forState:0];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(25/568.0 *kScreenH);

    }];
    
   
    
    self.loveTableView = [UITableView new];
    self.loveTableView.dataSource = self;
    self.loveTableView.delegate = self;
//    self.loveTableView.scrollEnabled = NO;
    self.loveTableView.rowHeight = 27.0/568.0f *kScreenH;
    self.loveTableView.backgroundColor = [UIColor colorWithRed:134.0/255 green:124.0/255 blue:214.0/255 alpha:1];
    self.loveTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.loveTableView];
    
    [self.loveTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(btn.mas_bottom).offset(20);
        make.bottom.mas_equalTo(-150);
    }];
     LoveInterestHeaderView *headerView = [LoveInterestHeaderView loveInter2];
    headerView.height = 27.0/568.0f * kScreenH;
    self.loveTableView.tableHeaderView = headerView;


//增送
    /*
    UIButton *songBtn = [UIButton new];
    [songBtn setTitle:@"赠送" forState:0];
    [songBtn setBackgroundImage:[UIImage imageNamed:@"紫色条"] forState:0];
    [songBtn addTarget:self action:@selector(clickSongBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:songBtn];
    
    [songBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.left.mas_equalTo(100);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.bottom.mas_equalTo(-90);
    }];
     */
    
}
// TableView 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoveInteresCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
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
    cell.gifCountLabel.text = @"1";
    cell.giftNameLabel.text = [[self.arr objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoveInteresCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.isSelected == YES) {
        cell.clickImageView.image = [UIImage imageNamed:@"32"];
        cell.isSelected = NO;
        [self.selectArr removeObject:[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row] objectForKey:@"_id"]]];
    } else {
        cell.isSelected = YES;
        cell.clickImageView.image = [UIImage imageNamed:@"31"];
        cell.index = (int)indexPath.row;
        [self.selectArr addObject:[NSString stringWithFormat:@"%@",[[self.arr objectAtIndex:indexPath.row] objectForKey:@"_id"]]];

    }
    [self.loveTableView reloadData];
}


// 已购买请求
- (void)yigoumaiRequest{
    
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
    
    [manager GET:@"http://mapi.loveyongtong.com/services/myExchanged" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"-------已换购的产品%@",dic);
        
        
        
        self.arr = [dic objectForKey:@"data"];
        [self.loveTableView reloadData];
        
//        NSLog(@"%@",self.arr);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}

// 按钮点击 点击更多
- (void)clickMoreBtn{
    
}
// 点击增送
- (void)clickSongBtn{
    
//    for(LoveInteresCell *cell in self.selectArr){
//        NSLog(@"%d",cell.index);
//    }
    
    GivenObjectVC *give = [GivenObjectVC new];
    give.arr = self.selectArr;
    [self.navigationController pushViewController:give animated:YES];
    

}

@end

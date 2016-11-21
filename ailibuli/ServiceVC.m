//
//  ServiceVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ServiceVC.h"
#import "YongtongView.h"
#import "ServiceDetailsVC.h"
#import "ChooseView.h"
#import "ServiceVCell.h"
@interface ServiceVC ()<ServiceDetailsDelegate,ChooseViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UIView *controlView;
@property (nonatomic, strong)UILabel *bimageLabel;

@property (nonatomic, strong)NSMutableArray *YTArr;
@property (nonatomic, strong)YongtongView *ytView;
@property (nonatomic, strong)UITableView *table;
@end

@implementation ServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];

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
 
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([[defaults objectForKey:@"state"] isEqualToString:@"单身"] ||[[defaults objectForKey:@"state"] isEqualToString:@"single"]) {
        //        [self YTlistRequset:@{@"loveStatus":@"single"}];
        self.state = @"单身";
        
    }else if ([[defaults objectForKey:@"state"] isEqualToString:@"恋爱"]||[[defaults objectForKey:@"state"] isEqualToString:@"inLove"]) {
        //        [self YTlistRequset:@{@"loveStatus":@"inLove"}];
        self.state = @"恋爱";
        
    }else if ([[defaults objectForKey:@"state"] isEqualToString:@"已婚"]||[[defaults objectForKey:@"state"] isEqualToString:@"married"]) {
        
        self.state = @"已婚";
        
    }

    self.navigationItem.title = @"服务列表";
    
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    
    
    UIImageView *bimage = [UIImageView new];
//    [bimage setImage:[UIImage imageNamed:@"确定取消紫色"]];
    bimage.backgroundColor = [UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1];
    [bimage setFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [self.view addSubview:bimage];
    self.bimageLabel = [UILabel new];
    self.bimageLabel.textColor = [UIColor whiteColor];
    self.bimageLabel.textAlignment = NSTextAlignmentCenter;
    [self.bimageLabel setFrame:CGRectMake(0, 0, self.view.frame.size.width, 36)];
    self.bimageLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.bimageLabel];
    self.bimageLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.bimageLabel addGestureRecognizer:tap1];
    
    NSLog(@"%@",self.state);
    if (self.state.length == 0) {
        self.bimageLabel.text = @"恋爱   >   快乐的虐狗团";
        [self YTlistRequset:@{@"loveStatus":@"inLove",@"type":self.type}];
        
    }else{
        [self getStatus];

    }
    
    [self createTable];
}
- (void)tap{
    [self createChooseView:@"3"];
}

- (void)getStatus{
    if ([self.state isEqualToString:@"单身"]) {
        self.bimageLabel.text = @"单身   >   孤独的单身狗";
        
        [self YTlistRequset:@{@"loveStatus":@"single",@"type":self.type}];
    }else if ([self.state isEqualToString:@"恋爱"]) {
        self.bimageLabel.text = @"恋爱   >   快乐的虐狗团";
        
        [self YTlistRequset:@{@"loveStatus":@"inLove",@"type":self.type}];
        
    }else if ([self.state isEqualToString:@"已婚"]) {
        self.bimageLabel.text = @"已婚   >   淡定的过日子";
        
        [self YTlistRequset:@{@"loveStatus":@"married",@"type":self.type}];
        
    }

    
}

- (void)sendState:(NSString *)str{
    self.state = str;
}

- (void)createChooseView:(NSString *)str{
    
    self.controlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.controlView setBackgroundColor:[UIColor clearColor]];
    
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self.controlView];
    
    UIView *aView = [UIView new];
    [aView setFrame:CGRectMake(25 , kScreenH / 3.5, kScreenW - 50 , 200)];
    [aView setBackgroundColor:[UIColor colorWithRed:86.0 /255 green:83.0 /255 blue:133.0 /255 alpha:1.0]];
    [self.controlView addSubview:aView];

    ChooseView *choose = [ChooseView new];
    [choose setFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 200)];
    choose.type = str;
    choose.delegate = self;
    
    [choose createView];
    [aView addSubview:choose];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, aView.frame.size.height - 25, aView.frame.size.width, 30 * kScreenH / 568.0f)];
    [imageView setImage:[UIImage imageNamed:@"确定取消紫色"]];
    imageView.userInteractionEnabled = YES;
    [aView addSubview:imageView];
    
    UIButton *quxiao = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30 * kScreenH / 568.0f)];
    [imageView addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao.titleLabel setFont:[UIFont systemFontOfSize:13 *kScreenH / 568.0f]];
    
    UIButton *queding = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width - 50, 0, 50, 30 * kScreenH / 568.0f)];
    [imageView addSubview:queding];
    [queding.titleLabel setFont:[UIFont systemFontOfSize:13 * kScreenH / 568.0f]];
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    
    [quxiao addTarget:self action:@selector(quxiaoButton) forControlEvents:UIControlEventTouchUpInside];
    [queding addTarget:self action:@selector(quedingButton) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)quxiaoButton{
    [self.controlView removeFromSuperview];
    
}
- (void)quedingButton{
    
    [self.controlView removeFromSuperview];
    
    if ([self.state isEqualToString:@"单身"]) {
        self.bimageLabel.text = @"单身   >   孤独的单身狗";
        
        [self YTlistRequset:@{@"loveStatus":@"single"}];
    }else if ([self.state isEqualToString:@"恋爱"]) {
        self.bimageLabel.text = @"恋爱   >   快乐的虐狗团";
        
        [self YTlistRequset:@{@"loveStatus":@"inLove"}];
        
    }else if ([self.state isEqualToString:@"已婚"]) {
        self.bimageLabel.text = @"已婚   >   淡定的过日子";
        
        [self YTlistRequset:@{@"loveStatus":@"married"}];
        
    }

}
//- (void)creatYTView{
//  self.ytView = [YongtongView new];
//    [self.ytView setFrame:CGRectMake(0, 64 + 37, self.view.frame.size.width, self.view.frame.size.height - 64 - 37)];
//    self.ytView.delegate = self;
//    self.ytView.arr = self.YTArr;
//    self.ytView.allowsSelected = YES;
//    [self.view addSubview:self.ytView];
//}

- (void)createTable{
    
    
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100 - 50)];
    [self.table setBackgroundColor:[UIColor clearColor]];
    
    
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.YTArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"Identify";
    ServiceVCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[ServiceVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell.line setFrame:CGRectMake(0, 100, tableView.frame.size.width, 4)];
    [cell.line setBackgroundColor:[UIColor colorWithRed:151/255.0 green:142/255.0 blue:200/255.0 alpha:1]];

    [cell.hImage setFrame:CGRectMake(0, 0, 150, 100)];
    [cell.hImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[self.YTArr objectAtIndex:indexPath.row] objectForKey:@"poster"]objectAtIndex:1]]]];
    
    
    cell.name.text = [NSString stringWithFormat:@"%@",[[self.YTArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [cell.name setFrame:CGRectMake(150 + 10, 10, tableView.frame.size.width - 150 - 10 - 35, 60)];
    cell.name.textColor = [UIColor grayColor];
    cell.name.font = [UIFont systemFontOfSize:15];
    cell.name.numberOfLines = 0;
    cell.name.textAlignment = NSTextAlignmentLeft;

    
    [cell.jiantou setImage:[UIImage imageNamed:@"向右"]];
    [cell.jiantou setFrame:CGRectMake(tableView.frame.size.width - 20, 40, 10, 20)];
    
    
    cell.YTB.text = [NSString stringWithFormat:@"积分 : %@",[[self.YTArr objectAtIndex:indexPath.row]  objectForKey:@"YTCoins"]];
    [cell.YTB setFrame:CGRectMake(150 + 10, 104 - 25, tableView.frame.size.width - 150 - 10 - 35, 15)];
    cell.YTB.textColor = [UIColor colorWithRed:194.0/255 green:121.0/255 blue:190.0/255 alpha:1];
    cell.YTB.font = [UIFont systemFontOfSize:15];
    cell.YTB.textAlignment = NSTextAlignmentLeft;
    
    
    [cell addSubview:cell.jiantou];
    [cell addSubview:cell.name];
    [cell addSubview:cell.line];
    [cell addSubview:cell.hImage];
    [cell addSubview:cell.YTB];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailsVC *ser = [ServiceDetailsVC new];
    ser.dic = [self.YTArr objectAtIndex:indexPath.row];;
    [self.navigationController pushViewController:ser animated:YES];

}



- (void)YTlistRequset:(id)json{
    self.YTArr = [NSMutableArray array];
    
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
    
    NSLog(@"请求服务");
    
    NSLog(@"%@",[defaults objectForKey:@"secretKey"]);
    NSLog(@"%@",[defaults objectForKey:@"sessionid"]);
    NSLog(@"%@",[defaults objectForKey:@"userId"]);
    
    
    [manager GET:@"http://mapi.loveyongtong.com/services/list" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
  
        self.YTArr = [dic objectForKey:@"data"];

        [self.table reloadData];
        NSLog(@"--------------请求服务%@",dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];
}

- (void)WhichService:(int)i{
    
    ServiceDetailsVC *ser = [ServiceDetailsVC new];
    ser.dic = [self.YTArr objectAtIndex:i - 1];;
    [self.navigationController pushViewController:ser animated:YES];
}

- (void)WhichServiceBuy:(NSMutableArray *)arrbuy{
    
}
@end

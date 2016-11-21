//
//  LoveInterestVc.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "LoveInterestVc.h"

/**
 *  爱的利息-可兑换控制器
 */

#import "YongtongView.h"
#import "ServiceDetailsVC.h"
#import "ServiceVCell.h"
@interface LoveInterestVc ()<ServiceDetailsDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSMutableArray *YTArr;
//@property (nonatomic, strong)YongtongView *ytView;
@property (nonatomic, strong)UILabel *YTB;

@property (nonatomic, strong)NSMutableArray *jsonArr;

@property (nonatomic, strong)NSString *fuwuid;

@property (nonatomic, strong)UITableView *table;
@property (nonatomic, strong)UILabel *xuanze;

@property (nonatomic, strong)NSMutableArray *arrbuy;

@property (nonatomic, strong)UIImageView *jiantou;

@property (nonatomic, strong)UIView *chooseView;
@property (nonatomic, strong)UIButton *classBtn;

@property (nonatomic, assign)int g;
@end

@implementation LoveInterestVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"爱的利息-兑换";
    [self YTlistRequset:@{@"loveStatus":@"inLove"}];
    self.arrbuy = [NSMutableArray new];
    [self creatYTView];
    self.g = 1;
}
- (void)creatYTView{
    
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
    
    self.classBtn  = [UIButton new];
    [self.classBtn setFrame:CGRectMake(0, 0, self.view.frame.size.width , 41)];
    [self.classBtn setTitle:@"分类" forState:0];
    [self.classBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.classBtn setBackgroundColor:kColor(234, 134, 150)];
    [self.view addSubview:self.classBtn];
    [self.classBtn addTarget:self action:@selector(fenlei) forControlEvents:UIControlEventTouchUpInside];
    
    self.jiantou = [UIImageView new];
    [self.jiantou setImage:[UIImage imageNamed:@"向下"]];
    [self.classBtn addSubview:self.jiantou];
    [self.jiantou setFrame:CGRectMake(self.classBtn.frame.size.width - 34, 41/2 -10, 23, 20)];
    
    self.chooseView = [UIView new];
    [self.chooseView setFrame:CGRectMake(0, -42.5, self.view.frame.size.width, 41.5 * 3)];
    [self.chooseView setBackgroundColor:kColor(234, 134, 150)];
    [self.view addSubview:self.chooseView];
    
    UIButton *btn = [UIButton new];
    [self.chooseView addSubview:btn];
    [btn setFrame:CGRectMake(0, 0.5, self.view.frame.size.width, 41)];
    [btn setTitle:@"单身 > 孤独的单身狗" forState:0];
    [btn addTarget:self action:@selector(danshen) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton new];
    [self.chooseView addSubview:btn1];
    [btn1 setFrame:CGRectMake(0, 41.5, self.view.frame.size.width, 41)];
    [btn1 setTitle:@"恋爱 > 快乐的虐狗团" forState:0];
    [btn1 addTarget:self action:@selector(lianai) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn2 = [UIButton new];
    [self.chooseView addSubview:btn2];
    [btn2 setFrame:CGRectMake(0, 83, self.view.frame.size.width, 41)];
    [btn2 setTitle:@"已婚 > 淡定的过日子" forState:0];
    [btn2 addTarget:self action:@selector(yihun) forControlEvents:UIControlEventTouchUpInside];

 
    
    UIView *line1 = [UIView new];
    [self.chooseView addSubview:line1];
    [line1 setFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.5)];
    [line1 setBackgroundColor:[UIColor whiteColor]];

    UIView *line2 = [UIView new];
    [self.chooseView addSubview:line2];
    [line2 setFrame:CGRectMake(0, 42, self.view.frame.size.width, 0.5)];
    [line2 setBackgroundColor:[UIColor whiteColor]];
    
    UIView *line3 = [UIView new];
    [self.chooseView addSubview:line3];
    [line3 setFrame:CGRectMake(0, 41.5 +41 , self.view.frame.size.width, 0.5)];
    [line3 setBackgroundColor:[UIColor whiteColor]];

    self.YTB = [UILabel new];
    [self.YTB setFrame:CGRectMake(0,  41, self.view.frame.size.width , 41)];
    [self.view addSubview:self.YTB];
    self.YTB.text = @"积分: ***个";
    self.YTB.textAlignment = NSTextAlignmentCenter;
    self.YTB.font = [UIFont systemFontOfSize:15];
    self.YTB.textColor = [UIColor whiteColor];
    [self.YTB setBackgroundColor:kColor(72, 65, 106)];
    [self YTBRequest];

    [self createTable];
  
    [self.view bringSubviewToFront:self.classBtn];

    
   
    
//    UIButton *songBtn = [UIButton new];
//    [songBtn setTitle:@"兑换" forState:0];
//    [songBtn setBackgroundColor:kColor(72, 65, 106)];
//    [songBtn addTarget:self action:@selector(clickSongBtn) forControlEvents:UIControlEventTouchUpInside];
//    [songBtn setFrame:CGRectMake(0, self.view.frame.size.height  - 50 - 41, self.view.frame.size.width, 41)];
//    [self.view addSubview:songBtn];

}


- (void)createTable{
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0,41 + 41, self.view.frame.size.width, self.view.frame.size.height - 64  -40 -41 - 50)];
    [self.table setBackgroundColor:[UIColor clearColor]];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    
    UILongPressGestureRecognizer *longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    longPressGr.minimumPressDuration = 0.5f;
    longPressGr.numberOfTouchesRequired = 1;
    [self.table addGestureRecognizer:longPressGr];
    
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
    [cell.line setBackgroundColor:[UIColor colorWithRed:133/225.0 green:103/225.0 blue:202/225.0 alpha:1]];
    
    [cell.hImage setFrame:CGRectMake(0, 0, 150, 100)];
    [cell.hImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[self.YTArr objectAtIndex:indexPath.row] objectForKey:@"poster"]objectAtIndex:1]]]];
    
    cell.name.text = [NSString stringWithFormat:@"%@",[[self.YTArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [cell.name setFrame:CGRectMake(150 + 10, 10, tableView.frame.size.width - 150 - 10 - 35, 60)];
    cell.name.textColor = [UIColor grayColor];
    cell.name.font = [UIFont systemFontOfSize:15];
    cell.name.numberOfLines = 0;
    cell.name.textAlignment = NSTextAlignmentLeft;
    [cell.name sizeToFit];
    
    [cell.jiantou setImage:[UIImage imageNamed:@"向右"]];
    [cell.jiantou setFrame:CGRectMake(tableView.frame.size.width - 20, 40, 10, 20)];
    
    
    cell.YTB.text = [NSString stringWithFormat:@"积分 : %@",[[self.YTArr objectAtIndex:indexPath.row]  objectForKey:@"YTCoins"]];
    [cell.YTB setFrame:CGRectMake(150 + 10, 104 - 25, tableView.frame.size.width - 150 - 10 - 35, 15)];
    cell.YTB.textColor = [UIColor colorWithRed:194.0/255 green:121.0/255 blue:190.0/255 alpha:1];
    cell.YTB.font = [UIFont systemFontOfSize:15];
    cell.YTB.textAlignment = NSTextAlignmentLeft;
    
    
    [cell.xuanze setFrame:CGRectMake(tableView.frame.size.width -33 - 23, 100 - 28, 23, 23)];
    BOOL isbool = [self.arrbuy containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (isbool ) {
        [cell.xuanze setImage:[UIImage imageNamed:@"对勾"]];
    }else{
        [cell.xuanze setImage:nil];
        
    }
    
    
    
    [cell addSubview:cell.jiantou];
    [cell addSubview:cell.name];
    [cell addSubview:cell.line];
    [cell addSubview:cell.hImage];
    [cell addSubview:cell.YTB];
    [cell addSubview:cell.xuanze];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceDetailsVC *ser = [ServiceDetailsVC new];
    ser.dic = [self.YTArr objectAtIndex:indexPath.row];
    ser.duihuan  = YES;
    [self.navigationController pushViewController:ser animated:YES];
    
    
    
}


- (void)clickSongBtn{
    
    if (self.jsonArr.count == 0) {
        
    }else{
        self.fuwuid = [NSString stringWithFormat:@"%@",[self.jsonArr objectAtIndex:0]];
        for (int i = 1; i < self.jsonArr.count; i++) {
            self.fuwuid = [self.fuwuid stringByAppendingString:[NSString stringWithFormat:@";%@",[self.jsonArr objectAtIndex:i]]];
        }
        NSLog(@"%@",self.fuwuid);
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否兑换" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            [self duihuanRequset:@{@"service_id":self.fuwuid}];
            
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        

    }
    
}

- (void)duihuanRequset:(id)json{
    
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
    
    NSLog(@"%@",json);
    [manager POST:@"http://mapi.loveyongtong.com/services/exchange" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
  

        NSLog(@"-------------兑换服务返回值%@",dic);
        
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:        [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]]
 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
       
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
- (void)yihun{
    [self YTlistRequset:@{@"loveStatus":@"married"}];
    [UIView animateWithDuration:0.3 animations:^{
        [self.chooseView setFrame:CGRectMake(0, 41 - 42 * 4, self.view.frame.size.width, 42 *3)];
        [self.view bringSubviewToFront:self.classBtn];
    }];
    [self.jiantou setImage:[UIImage imageNamed:@"向下"]];
    
    self.g = 1;
}
- (void)danshen{
    [self YTlistRequset:@{@"loveStatus":@"single"}];
    [UIView animateWithDuration:0.3 animations:^{
        [self.chooseView setFrame:CGRectMake(0, 41 - 42 * 4, self.view.frame.size.width, 42 *3)];
        [self.view bringSubviewToFront:self.classBtn];
    }];
    [self.jiantou setImage:[UIImage imageNamed:@"向下"]];
    
    self.g = 1;
    
}
- (void)lianai{
    
    [self YTlistRequset:@{@"loveStatus":@"inLove"}];
    [UIView animateWithDuration:0.3 animations:^{
        [self.chooseView setFrame:CGRectMake(0, 41 - 42 * 4, self.view.frame.size.width, 42 *3)];
        [self.view bringSubviewToFront:self.classBtn];
    }];
    [self.jiantou setImage:[UIImage imageNamed:@"向下"]];
    
    self.g = 1;
    
}

- (void)fenlei{
    if (self.g == 1) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view bringSubviewToFront:self.chooseView];
            [self.view bringSubviewToFront:self.classBtn];
            [self.chooseView setFrame:CGRectMake(0, 41, self.view.frame.size.width, 42 * 3)];
        }];
        [self.jiantou setImage:[UIImage imageNamed:@"向上"]];

        self.g = 2;
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            [self.chooseView setFrame:CGRectMake(0, 41 - 42 * 4, self.view.frame.size.width, 42 *3)];
            [self.view bringSubviewToFront:self.classBtn];
        }];
        [self.jiantou setImage:[UIImage imageNamed:@"向下"]];

        self.g = 1;
    }
    
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
    
    [manager GET:@"http://mapi.loveyongtong.com/services/list" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        self.YTArr = [dic objectForKey:@"data"];
        [self.table reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
- (void)WhichService:(int )i{
    
    ServiceDetailsVC *ser = [ServiceDetailsVC new];
    ser.dic = [self.YTArr objectAtIndex:i - 1];;
    [self.navigationController pushViewController:ser animated:YES];
    
}
- (void)WhichServiceBuy:(NSMutableArray *)arrbuy{
    self.jsonArr = [NSMutableArray array];
    for (NSString *i in arrbuy) {
        
       [self.jsonArr addObject:[[self.YTArr objectAtIndex:[i intValue] - 1] objectForKey:@"_id"]];
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [longPress locationInView:self.table];
        
        NSIndexPath *indexPath = [self.table indexPathForRowAtPoint:point]; // 可以获取我们在哪个cell上长按
        BOOL isbool = [self.arrbuy containsObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
        if (isbool ) {
        NSString *str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [self.arrbuy removeObject:str];
        [self.table reloadData];
 
        }else{

        NSString *str = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [self.arrbuy addObject:str];
        [self.table reloadData];
        }

        
        
        if (indexPath != nil) {
            
            self.jsonArr = [NSMutableArray array];
            for (NSString *i in self.arrbuy) {
                
                [self.jsonArr addObject:[[self.YTArr objectAtIndex:[i intValue]] objectForKey:@"_id"]];
            }
        }
        
    }
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
        
        self.YTB.text = [NSString stringWithFormat:@"积分: %@",        [[dic objectForKey:@"data"]objectForKey:@"accumulation"]];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self YTBRequest];
}

@end

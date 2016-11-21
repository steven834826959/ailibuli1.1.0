//
//  BuyVC.m
//  
//
//  Created by qiaofeng wu on 16/7/11.
//
//

#import "BuyVC.h"
#import "YongtongView.h"
#import "ServiceDetailsVC.h"
#import "BuyDetermineVC.h"
@interface BuyVC ()<ServiceDetailsDelegate>

@property (nonatomic ,strong)UITableView *table;
@property (nonatomic ,strong)NSMutableArray *YTArr;
@property (nonatomic, assign)int i;//购买数量
@property (nonatomic, assign)int j;//选择第几个
@property (nonatomic, strong) UILabel  *money;

@end

@implementation BuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"守爱侠的服务";
    [self.view setBackgroundColor:BGColor];
    self.i = 1;
    self.j = 0;
    [self createTable];
}

- (void)createTable{
    
    self.table = [UITableView new];
    self.table.frame =CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height - 2);
    [self.table setBackgroundColor:BGColor];
    
    [self.view addSubview:self.table];
    [self headerView];
    [self YTlistRequset:@{@"loveStatus":self.state}];
    
}



- (void)headerView{
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(0, 0, self.table.frame.size.width, 315)];
    [view setBackgroundColor:[UIColor colorWithRed:65.0/255 green:74.0/255 blue:70.0 /255 alpha:1]];
    self.table.tableHeaderView = view;
    
    UIImageView *image1 = [UIImageView new];
    UIImageView *image2 = [UIImageView new];
    UIImageView *image3 = [UIImageView new];
    UIImageView *image4 = [UIImageView new];
    
    image1.image  = [UIImage imageNamed:@"确定取消紫色"];
    image2.image  = [UIImage imageNamed:@"确定取消紫色"];
    image3.image  = [UIImage imageNamed:@"确定取消紫色"];
    image4.image  = [UIImage imageNamed:@"确定取消紫色"];
    
    
    [image1 setFrame:CGRectMake(0, 0, view.frame.size.width, 35)];
    [image2 setFrame:CGRectMake(0, 35 * 2, view.frame.size.width, 35)];
    [image3 setFrame:CGRectMake(0, 35 * 4, view.frame.size.width, 35)];
    [image4 setFrame:CGRectMake(0, 35 * 7, view.frame.size.width, 35)];

    [view addSubview:image1];
    [view addSubview:image2];
    [view addSubview:image3];
    [view addSubview:image4];
    
    
    
    UILabel *label1 = [UILabel new];
    UILabel *label2 = [UILabel new];
    UILabel *label3 = [UILabel new];
    UILabel *label4 = [UILabel new];
    label1.text = @"数量";
    label2.text = @"金额";
    label3.text = @"期限";
    label4.text = @"积分";
    [view addSubview:label1];
    [view addSubview:label2];
    [view addSubview:label3];
    [view addSubview:label4];
    [label1 setFrame:CGRectMake(20, 0, view.frame.size.width, 35)];
    [label2 setFrame:CGRectMake(20, 35 * 2, view.frame.size.width, 35)];
    [label3 setFrame:CGRectMake(20, 35 * 4, view.frame.size.width, 35)];
    [label4 setFrame:CGRectMake(20, 35 * 7, view.frame.size.width, 35)];
    [label1 setTextColor:[UIColor whiteColor]];
    [label2 setTextColor:[UIColor whiteColor]];
    [label3 setTextColor:[UIColor whiteColor]];
    [label4 setTextColor:[UIColor whiteColor]];
    label1.font = [UIFont systemFontOfSize:14];
    label2.font = [UIFont systemFontOfSize:14];
    label3.font = [UIFont systemFontOfSize:14];
    label4.font = [UIFont systemFontOfSize:14];


    self.number = [UILabel new];
    [self.number setFont:[UIFont systemFontOfSize:13]];
    self.number.text = [NSString stringWithFormat:@"%d",self.i];
    self.number.textAlignment = NSTextAlignmentCenter;
    [self.number setTextColor:[UIColor whiteColor]];
    [view addSubview:self.number];
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30,35));
        make.top.mas_equalTo(35);
        make.centerX.equalTo(view.mas_centerX);
    }];
    
    
    UIButton *addBtn = [UIButton new];
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addi) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 35));
        make.top.mas_equalTo(35);
        make.left.mas_equalTo(self.number.mas_right).offset(2.5);
    }];

    UIButton *deleteBtn  = [UIButton new];
    [deleteBtn setTitle:@"-" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deletei) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 35));
        make.top.mas_equalTo(35);
        make.right.mas_equalTo(self.number.mas_left).offset(2.5);
    }];
    
    
    self.price = [UILabel new];
    [self.price setText:[NSString stringWithFormat:@"%@", [[self.chanpin objectAtIndex:0]objectForKey:@"minBuy"]]];
    [self.price  setTextColor:[UIColor whiteColor]];
    [self.price setFont:[UIFont systemFontOfSize:12]];
    [self.price setTextAlignment:NSTextAlignmentCenter];
    [view addSubview:self.price];
    [self.price setFrame:CGRectMake(0, 35 * 3, view.frame.size.width, 35)];
    
    
    self.timeLimit1 = [UIButton new];
    self.timeLimit2 = [UIButton new];
    self.timeLimit3 = [UIButton new];
    self.timeLimit4 = [UIButton new];
    

    [self.timeLimit1 setFrame:CGRectMake(view.frame.size.width / 4 / 3, 35 * 5 + 27.5, 15, 15)];
    [self.timeLimit2 setFrame:CGRectMake((view.frame.size.width - view.frame.size.width / 6) / 4 + view.frame.size.width / 4 / 3, 35 * 5+ 27.5, 15, 15)];
    [self.timeLimit3 setFrame:CGRectMake((view.frame.size.width - view.frame.size.width / 6) / 2 + 1.5 * view.frame.size.width / 4 / 3 , 35 * 5 + 27.5, 15, 15)];
    [self.timeLimit4 setFrame:CGRectMake((view.frame.size.width - view.frame.size.width / 6) / 4 * 3  +  2 * view.frame.size.width / 4 / 3, 35 * 5 + 27.5, 15, 15)];
    
    [view addSubview:self.timeLimit1];
    [view addSubview:self.timeLimit2];
    [view addSubview:self.timeLimit3];
    [view addSubview:self.timeLimit4];

    [self.timeLimit1 addTarget:self action:@selector(btn1) forControlEvents:UIControlEventTouchUpInside];
    [self.timeLimit2 addTarget:self action:@selector(btn2) forControlEvents:UIControlEventTouchUpInside];
    [self.timeLimit3 addTarget:self action:@selector(btn3) forControlEvents:UIControlEventTouchUpInside];
    [self.timeLimit4 addTarget:self action:@selector(btn4) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *time1 = [UILabel new];
    UILabel *time2 = [UILabel new];
    UILabel *time3 = [UILabel new];
    UILabel *time4 = [UILabel new];
    
    [view addSubview:time1];
    [view addSubview:time2];
    [view addSubview:time3];
    [view addSubview:time4];
    
    
    time1.text = [NSString stringWithFormat:@"%@天", [[self.chanpin objectAtIndex:0]objectForKey:@"timeInterval"]];
    
    time2.text = [NSString stringWithFormat:@"%@天", [[self.chanpin objectAtIndex:1]objectForKey:@"timeInterval"]];
    time3.text = [NSString stringWithFormat:@"%@天", [[self.chanpin objectAtIndex:2]objectForKey:@"timeInterval"]];
    time4.text = [NSString stringWithFormat:@"%@天", [[self.chanpin objectAtIndex:3]objectForKey:@"timeInterval"]];
    
    time1.textColor = [UIColor whiteColor];
    time2.textColor = [UIColor whiteColor];
    time3.textColor = [UIColor whiteColor];
    time4.textColor = [UIColor whiteColor];
    [time1 setFont:[UIFont systemFontOfSize:12]];
    [time2 setFont:[UIFont systemFontOfSize:12]];
    [time3 setFont:[UIFont systemFontOfSize:12]];
    [time4 setFont:[UIFont systemFontOfSize:12]];
		

    [time1 setFrame:CGRectMake(self.timeLimit1.frame.size.width +self.timeLimit1.frame.origin.x + 3, 35 * 5 + 27.5, 40, 15)];
    [time2 setFrame:CGRectMake(self.timeLimit2.frame.size.width +self.timeLimit2.frame.origin.x + 3, 35 * 5 + 27.5, 40, 15)];
    [time3 setFrame:CGRectMake(self.timeLimit3.frame.size.width +self.timeLimit3.frame.origin.x + 3, 35 * 5 + 27.5, 40, 15)];
    [time4 setFrame:CGRectMake(self.timeLimit4.frame.size.width +self.timeLimit4.frame.origin.x + 3, 35 * 5 + 27.5, 40, 15)];

    
    
    [self btn1];
    
    
    
    self.money = [UILabel new];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];
    [view addSubview:self.money];
    self.money.font = [UIFont systemFontOfSize:12];
    self.money.textColor = [UIColor whiteColor];
    self.money.textAlignment = NSTextAlignmentCenter;
    [self.money setFrame:CGRectMake(0, 35 * 8, view.frame.size.width, 35)];
    
    
    
    
}
- (void)btn1{
    self.j = 0;

    [self.timeLimit1 setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [self.timeLimit2 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit3 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit4 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.price setText:[NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue] * self.i]];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];

}

- (void)btn2{
    self.j = 1;

    [self.timeLimit1 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit2 setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [self.timeLimit3 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit4 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.price setText:[NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue] * self.i]];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];

}

- (void)btn3{
    self.j = 2;

    [self.timeLimit1 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit2 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit3 setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [self.timeLimit4 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.price setText:[NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue] * self.i]];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];

}
- (void)btn4{
    self.j = 3;

    [self.timeLimit1 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit2 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit3 setImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [self.timeLimit4 setImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [self.price setText:[NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue] * self.i]];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];

}




- (void)FoodView{

    UIView *view = [UIView new];
    [view setFrame:CGRectMake(0, 0, self.table.frame.size.width, 150 +  160 * (self.YTArr.count / 3) + 30  )];
    self.table.tableFooterView = view;
    [view setBackgroundColor:BGColor];
    
    YongtongView *ytView = [YongtongView new];
    [ytView setBackgroundColor:BGColor];
    ytView.delegate = self;
    ytView.arr = self.YTArr;
    [ytView setFrame:CGRectMake(0, 37, view.frame.size.width, 160 * (self.YTArr.count / 3) + 30  )];
    [view addSubview:ytView];
    
    UIButton *buy = [UIButton new];
    [buy setImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buyBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:buy];
    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(150, 25));
        make.centerX.mas_equalTo(ytView.mas_centerX);
    }];
    
    UILabel *buyLabel = [UILabel new];
    [buyLabel setFrame:CGRectMake(0, 0, 150, 25)];
    [buyLabel setText:@"购买"];
    buyLabel.textAlignment = NSTextAlignmentCenter;
    buyLabel.textColor = [UIColor whiteColor];
    [buyLabel setFont:[UIFont systemFontOfSize:14]];
    [buy addSubview:buyLabel];
    
    
    
    UILabel *label = [UILabel new];
    [label setFrame:CGRectMake(0, ytView.frame.size.height + 20, self.table.frame.size.width, 15)];
    [label setBackgroundColor:[UIColor colorWithRed:113.0/255 green:201.0/255 blue:195.0/255 alpha:1]];
    [view addSubview:label];
    label.text = @"I M P O R T A N T    N O T E ";
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    
    UILabel *label1 = [UILabel new];
    [label1 setFont:[UIFont systemFontOfSize:14]];
    label1.text = @"重要说明 - 产品收益";
    label1.textColor  = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 setFrame:CGRectMake(0, ytView.frame.size.height + 15+ 20, self.table.frame.size.width , 35)];
    
    UILabel *label2 = [UILabel new];
    label2.textColor  = [UIColor whiteColor];
    label2.numberOfLines = 0;
    [label2 setFrame:CGRectMake(35, ytView.frame.size.height + 35+ 20, self.table.frame.size.width, 100)];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"1、每月实物+虚拟物品返还\n2、实物以快递形式发送\n3、虚礼物品以代金券等发送\n4、以下物品仅供参考,以当月派送为准"];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:8];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [@"1、每月实物+虚拟物品返还\n2、实物以快递形式发送\n3、虚礼物品以代金券等发送\n4、以下物品仅供参考,以当月派送为准" length])];
    label2.attributedText = attributedString;
    [label2 setFont:[UIFont systemFontOfSize:12]];

    [view addSubview:label1];
    [view addSubview:label2];
    
    
    
}

- (void)buyBtn{
    
    BuyDetermineVC *buydet = [BuyDetermineVC new];
    int i  = [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue];
    buydet.str = [NSString stringWithFormat:@"%d",i * self.i];
    buydet.json =@{@"loanId":[[self.chanpin objectAtIndex:self.j]objectForKey:@"_id"]
                   ,@"buyNum":[NSString stringWithFormat:@"%d",self.i],@"name":[[self.chanpin objectAtIndex:self.j]objectForKey:@"name"],@"mark":@"123123"};
    [self.navigationController pushViewController:buydet animated:YES];
}


- (void)deletei{
    self.i --;
    if (self.i == 0) {
        self.i = 1;
    }
    self.number.text = [NSString stringWithFormat:@"%d",self.i];
    
    [self.price setText:[NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue] * self.i]];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];

}
- (void)addi{
    self.i ++;
    self.number.text = [NSString stringWithFormat:@"%d",self.i];
    [self.price setText:[NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"minBuy"]intValue] * self.i]];
    self.money.text = [NSString stringWithFormat:@"%d个", [[[self.chanpin objectAtIndex:self.j]objectForKey:@"ytCoins"]intValue] * self.i];
    
    
    
    
}



- (void)WhichService:(int)i{
    ServiceDetailsVC *ser = [ServiceDetailsVC new];
    ser.dic = [self.YTArr objectAtIndex:i - 1];;
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
    
    [manager GET:@"http://mapi.loveyongtong.com/services/list" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.YTArr = [dic objectForKey:@"data"];
        [self FoodView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}
- (void)WhichServiceBuy:(NSMutableArray *)arrbuy{
    
}



@end

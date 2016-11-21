
//
//  ServiceDetailsVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ServiceDetailsVC.h"
#import "SerViceDetailsVCell.h"
#import "UIAlertController+InternetErrorAlert.h"



@interface ServiceDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UILabel *title1;
@property (nonatomic, strong)UILabel *shuoming1;
@property (nonatomic, strong)UILabel *shuoming2;
@property (nonatomic, strong)UILabel *shuoming3;
@property (nonatomic, strong)UILabel *shuoming4;
@property (nonatomic, strong)UITableView *table;


@end

@implementation ServiceDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
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
    
    self.title = @"服务详情";
    [self createTable];
    [self createView];
    
    
}
- (void)createTable{
    
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 113)];

    [self.table setBackgroundColor:[UIColor clearColor]];
    
    self.table.delaysContentTouches = YES;

    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];

    [self createView];
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 268 + 41;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"Identify";
    SerViceDetailsVCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(cell == nil)
    {
        cell = [[SerViceDetailsVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
    [cell.hImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[self.dic objectForKey:@"poster"]objectAtIndex:1]]]];
    
    [cell.label setText:@"照片说明"];
    [cell.label setFrame:CGRectMake(30, 268, self.view.frame.size.width - 60, 41)];
    [cell.hImage setFrame:CGRectMake(0, 0, self.view.frame.size.width, 268)];
    [cell.baseView setFrame:CGRectMake(0, 268, self.view.frame.size.width, 41)];

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)createView{

    UIView *view = [UIView new];
    self.table.tableHeaderView = view;
    [view setFrame:CGRectMake(0, 0, self.table.frame.size.width, 14+22.5+40)];
    
    
    UILabel *label1 = [UILabel new];
    label1.text = @"I N S T R U C T I O N S";
    label1.font = [UIFont systemFontOfSize:9];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = [UIColor whiteColor];
    [label1 setBackgroundColor:[UIColor colorWithRed:131 / 255.0 green:127 / 255.0 blue:179 / 255.0 alpha:1]];
    [label1 setFrame:CGRectMake(0, 0, self.view.frame.size.width, 14)];
    [view addSubview:label1];
    
    
    UILabel *label2 = [UILabel new];
    label2.text = @"使用说明";
    [label2 setBackgroundColor:[UIColor colorWithRed:234.0/255 green:134.0/255 blue:150.0/255 alpha:1]];
    label2.font = [UIFont systemFontOfSize:14];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [label2 setFrame:CGRectMake(0,  14, self.view.frame.size.width, 22.5)];
    [view addSubview:label2];
    
    self.title1 = [UILabel new];
    _title1.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"name"]];
    _title1.font = [UIFont systemFontOfSize:16];
    _title1.textColor = [UIColor colorWithRed:234.0/255 green:134.0/255 blue:150.0/255 alpha:1];
    [_title1 setBackgroundColor:[UIColor colorWithRed:131 / 255.0 green:127 / 255.0 blue:179 / 255.0 alpha:1]];
    _title1.textAlignment = NSTextAlignmentCenter;
    _title1.numberOfLines = 0;
    [_title1 setFrame:CGRectMake(0,  14 + 22.5, self.view.frame.size.width, 40)];
    [view addSubview:self.title1];

    //尾部视图
    UIView *footerView = [UIView new];
    
    
    [footerView setBackgroundColor:[UIColor clearColor]];
    [footerView setFrame:CGRectMake(0, 0, self.table.frame.size.width, 41*3 + 150)];

    for (int i = 0; i < 4; i++) {
        UIView *view = [UIView new];
        if (i % 2 == 1) {
            [view setBackgroundColor:[UIColor clearColor]];

        }else {
            [view setBackgroundColor:[UIColor colorWithRed:123.0 /255 green:118.0 /255 blue:172.0/255 alpha:1]];

        }
        if (i == 3) {
              [view setFrame:CGRectMake(0, 23 + i * 41, self.view.frame.size.width , 300)];
        }else{
            [view setFrame:CGRectMake(0,  23 + i * 41, self.view.frame.size.width , 41)];

        }
        [footerView addSubview:view];

        UILabel *label = [UILabel new];
        [label setFrame:CGRectMake(20, 23 + i * 41, 80, 41)];
        label.font = [UIFont systemFontOfSize:15];
        [label setTextColor:[UIColor whiteColor]];
        label.textAlignment = NSTextAlignmentLeft;
        if (i == 0) {
            [label setText:@"积分"];
        }if (i == 1) {
            [label setText:@"使用有效期"];
        }if (i == 2) {
            [label setText:@"库存"];
        }if (i == 3) {
            [label setText:@"备注"];
        }
        [footerView addSubview:label];

        
        UILabel *xian = [UILabel new];
        [xian setFrame:CGRectMake(105,23 + i * 41 , 8, 41)];
        xian.font = [UIFont systemFontOfSize:25];
        [xian setTextColor:[UIColor whiteColor]];
        xian.textAlignment = NSTextAlignmentLeft;
        xian.text = @"|";
        [footerView addSubview:xian];

    }
    
    self.shuoming1 = [UILabel new];
    self.shuoming2 = [UILabel new];
    self.shuoming3 = [UILabel new];
    self.shuoming4 = [UILabel new];
    
    [footerView addSubview:self.shuoming1];
    [footerView addSubview:self.shuoming2];
    [footerView addSubview:self.shuoming3];
    [footerView addSubview:self.shuoming4];

    
    _shuoming1.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"YTCoins"]];
    _shuoming1.font = [UIFont systemFontOfSize:15];
    _shuoming1.textColor = [UIColor whiteColor];
    [_shuoming1 setFrame:CGRectMake(120, 23, self.view.frame.size.width - 140, 41)];
    _shuoming2.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"endDate"]];
    _shuoming2.font = [UIFont systemFontOfSize:15];
    _shuoming2.textColor = [UIColor whiteColor];
    [_shuoming2 setFrame:CGRectMake(120,23 + 41 * 1 , self.view.frame.size.width - 140, 41)];
    _shuoming3.text = [NSString stringWithFormat:@"%@",[self.dic objectForKey:@"totalNum"]];
    _shuoming3.font = [UIFont systemFontOfSize:14];
    _shuoming3.textColor = [UIColor whiteColor];
    [_shuoming3 setFrame:CGRectMake(120,23 + 41 * 2 , self.view.frame.size.width - 140, 41)];
    
    _shuoming4.font = [UIFont systemFontOfSize:15];
    _shuoming4.textColor = [UIColor whiteColor];
    [_shuoming4 setFrame:CGRectMake(120, 23 + 41  * 3 + 10, self.view.frame.size.width - 140, 200)];
    _shuoming4.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",[self.dic objectForKey:@"remark"]]];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[NSString stringWithFormat:@"%@",[self.dic objectForKey:@"remark"]] length])];
    _shuoming4.attributedText = attributedString;
    [_shuoming4 sizeToFit];
    
    

    UIView *diView = [UIView new];
    if (_shuoming4.frame.size.height < 41.0) {
        [diView setFrame:CGRectMake(0, 41 +_shuoming4.frame.origin.y, self.view.frame.size.width, 105)];
    }else{
       [diView setFrame:CGRectMake(0, _shuoming4.frame.size.height +_shuoming4.frame.origin.y, self.view.frame.size.width, 105)];

    }
    
    UIView *a  = [UIView new];
    [a setFrame:CGRectMake(0, 0, self.view.frame.size.width, 23)];
    [a setBackgroundColor:[UIColor clearColor]];
    [diView addSubview:a];
    
    UIView *b = [UIView new];
    [b setFrame:CGRectMake(0, 23, self.view.frame.size.width, 82)];
    
    [b setBackgroundColor:[UIColor clearColor]];
    [diView addSubview:b];
    
    
    
    //兑换按钮
    UIButton *btn =  [UIButton new];
    [btn setFrame:CGRectMake((self.view.frame.size.width - 225) / 2, 41 / 2, 225, 41)];
    [btn setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    [btn addTarget:self action:@selector(duihuanwupin) forControlEvents:UIControlEventTouchUpInside];
    
    [btn setTitle:@"兑换" forState:UIControlStateNormal];
    
    [btn setFont:[UIFont systemFontOfSize:15]];
    
    [b  addSubview:btn];
    
    
    /*
    UILabel *goumai = [UILabel new];
    [goumai setFrame:CGRectMake(0, 0, btn.frame.size.width, 41)];
    [goumai setText:@"兑换"];
    [goumai setFont:[UIFont systemFontOfSize:15]];
    [goumai setTextColor:[UIColor whiteColor]];
    [goumai setTextAlignment:NSTextAlignmentCenter];
    [btn addSubview:goumai];
     */
    if (self.duihuan) {
        [footerView addSubview:diView];
        [footerView setFrame:CGRectMake(0, 0, self.table.frame.size.width, 41*3 + 130 +  _shuoming4.frame.size.height)];
    }else{
         [footerView setFrame:CGRectMake(0, 0, self.table.frame.size.width, 41*3 +  _shuoming4.frame.size.height + 20 + 40)];
    }
  
    self.table.tableFooterView = footerView;
}


- (void)duihuanwupin{
 
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否兑换" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //兑换之后发出请求
                [self duihuanRequset:@{@"service_id":[self.dic objectForKey:@"_id"]}];
                
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            
            [self presentViewController:alertController animated:YES completion:nil];


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
      
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:        [NSString stringWithFormat:@"%@",[dic objectForKey:@"desc"]]
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            
            [alertController addAction:cancelAction];
            
            
            [self presentViewController:alertController animated:YES completion:nil];
   
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
            [self presentViewController:alert animated:YES completion:nil];

        }];
        
    }
    

@end

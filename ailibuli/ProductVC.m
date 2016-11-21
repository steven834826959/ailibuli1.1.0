//
//  ProductVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductVC.h"
#import <Masonry.h>
#import "ProductVCell.h"
#import "ProductListVC.h"
#import "sys/utsname.h"
#import "ProductDetailsVc.h"
@interface ProductVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *table;
@property (nonatomic, assign)float i;
@property (nonatomic, copy)NSString *shouaixiaID;
@property (nonatomic, copy)NSString *ainimeiID;
@property (nonatomic, copy)NSString *panduolaID;

@property (nonatomic, strong)NSMutableArray *shouaixiaArr;
@property (nonatomic, strong)NSMutableArray *ainimeiArr;
@property (nonatomic, strong)NSMutableArray *panduolaArr;


@end

@implementation ProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    self.navigationItem.title = @"产品";
    
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    [self huoquchanping];
    [self textview];
}



- (void)huoquchanping{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:@"http://mapi.loveyongtong.com/loan/getCategories" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        self.shouaixiaID = [[[responseObject objectForKey:@"data"]objectAtIndex:0]objectForKey:@"_id"];
        self.ainimeiID = [[[responseObject objectForKey:@"data"]objectAtIndex:1]objectForKey:@"_id"];
        self.panduolaID = [[[responseObject objectForKey:@"data"]objectAtIndex:2]objectForKey:@"_id"];
        [self chanpin:self.shouaixiaID];
        [self chanpin:self.ainimeiID];
        [self chanpin:self.panduolaID];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


- (void)chanpin:(NSString *)str{
    
    self.shouaixiaArr = [NSMutableArray new];
    self.ainimeiArr = [NSMutableArray new];
    self.panduolaArr = [NSMutableArray new];

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager POST:@"http://mapi.loveyongtong.com/loan/getList" parameters:    @{@"size":@"4",@"index":@"1",@"categoryId":str}
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
             if ([str isEqualToString:self.shouaixiaID]) {
                 self.shouaixiaArr = [dic objectForKey:@"data"];
             }else if ([str isEqualToString:self.ainimeiID]) {
                 self.ainimeiArr = [dic objectForKey:@"data"];

             }else if ([str isEqualToString:self.panduolaID]) {
                 self.panduolaArr = [dic objectForKey:@"data"];

             }
             
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];     [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (void)textview{
    
    self.i = 1;

    //背景图片
    UIImageView *textimage = [UIImageView new];
    textimage.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 49  );
    
    //图片设置
    [textimage setImage:[UIImage imageNamed:@"产品列表"]];
    
    [self.view addSubview:textimage];
    [textimage setUserInteractionEnabled:YES];

    //添加button
    UIButton *button1 = [UIButton new];
    UIButton *button2 = [UIButton new];
    UIButton *button3 = [UIButton new];
    [textimage addSubview: button1];
    [textimage addSubview: button2];
    [textimage addSubview: button3];
    
    [button1 setFrame:CGRectMake(0, 0, self.view.frame.size.width,textimage.frame.size.height/ 3)];
    [button2 setFrame:CGRectMake(0, button1.frame.origin.y + textimage.frame.size.height/ 3, self.view.frame.size.width, textimage.frame.size.height/ 3)];
    [button3 setFrame:CGRectMake(0, button1.frame.origin.y + textimage.frame.size.height/ 3 * 2, self.view.frame.size.width, textimage.frame.size.height/ 3)];
    
    [button1 setTag:201607210];
    [button2 setTag:201607211];
    [button3 setTag:201607212];

    [button1 addTarget:self action:@selector(xiangqin:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(xiangqin:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(xiangqin:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)chanp:(NSString *)str{
    NSLog(@"123123");
    if ([str isEqualToString:@"守爱侠"]) {
        ProductListVC *view = [ProductListVC new];
        view.title = @"守爱侠";
        view.state = @"inLove";
        view.chanpin = self.shouaixiaArr;
        [self.navigationController pushViewController:view animated:YES];
        
    }
}


- (void)xiangqin:(UIButton *)btn{
    
    if (btn.tag == 201607210) {
        ProductListVC *view = [ProductListVC new];
        view.chanpin = self.ainimeiArr;
        view.state = @"single";
        view.title = @"爱你妹";
        view.testIndex = 0;
        [self.navigationController pushViewController:view animated:YES];
    }
    if (btn.tag == 201607211) {
        ProductListVC *view = [ProductListVC new];
        view.title = @"守爱侠";
        view.state = @"inLove";
        view.chanpin = self.shouaixiaArr;
        view.testIndex = 1;
        [self.navigationController pushViewController:view animated:YES];
    }
    if (btn.tag == 201607212) {
        ProductListVC *view = [ProductListVC new];
        view.title = @"潘多拉";
        view.state = @"married";
        view.chanpin = self.panduolaArr;
        view.testIndex = 2;
        [self.navigationController pushViewController:view animated:YES];
    }
 
}

@end

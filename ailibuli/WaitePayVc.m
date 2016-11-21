//
//  WaitePayVc.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "WaitePayVc.h"
#import "WaitePayView.h"
#import "WaitPayCell.h"
#import "GoOnPayBtn.h"

/**
 *  等待付款控制器
 */


@interface WaitePayVc ()<UITableViewDataSource>
/** tableView*/
@property (nonatomic ,strong) UITableView *waitpayTableView;
/** array*/
@property (nonatomic ,strong) NSArray *waiteArray;
@end

@implementation WaitePayVc

static NSString *ID = @"wpcell";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
         [self.waitpayTableView registerNib:[UINib nibWithNibName:@"WaitPayCell" bundle:nil] forCellReuseIdentifier:ID];
    self.waitpayTableView.rowHeight = 27.0 / 568 * kScreenH;
}

- (void)setupUI{
    self.title = @"等待付款";
    [self.view setBackgroundColor:[UIColor colorWithRed:81.0/255 green:188.0/255 blue:179.0/255 alpha:1]];
    
    
    
    GoOnPayBtn *btn = [GoOnPayBtn new];
    btn.backgroundColor = kColor(229, 109, 130);
   
    [btn setTitle:@"您可以继续付款" forState:0];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(84);
        make.height.mas_equalTo(25/568.0 *kScreenH);
        
    }];
    
    _waitpayTableView = [UITableView new];
    _waitpayTableView.dataSource = self;
    _waitpayTableView.backgroundColor = [UIColor whiteColor];
    _waitpayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _waitpayTableView.scrollEnabled = NO;
    [self.view addSubview:_waitpayTableView];
    
    [_waitpayTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(btn.mas_bottom).offset(20);
        make.height.mas_equalTo(4*27.0 / 568 * kScreenH);
    }];
    
    WaitePayView *wpView = [WaitePayView waitePayView];
    wpView.frame = CGRectMake(0, 0, kScreenW, 27.0 / 568 * kScreenH);
    _waitpayTableView.tableHeaderView = wpView;
    
    
    
    // 付款按钮
    UIButton *payBtn = [UIButton new];

    [payBtn setTitle:@"付款" forState:0];
    [payBtn setBackgroundImage:[UIImage imageNamed:@"紫色条"] forState:0];
    [payBtn setTitleColor:[UIColor whiteColor] forState:0];
    [payBtn addTarget:self action:@selector(clickPayBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:payBtn];
    // 删除按钮
    UIButton *deleteBtn = [UIButton new];
    [deleteBtn setTitle:@"删除" forState:0];
    [deleteBtn setBackgroundImage:[UIImage imageNamed:@"紫色条"] forState:0];
    [deleteBtn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.left.mas_equalTo(100);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.bottom.mas_equalTo(-90);
    }];
    
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-100);
        make.left.mas_equalTo(100);
        make.height.mas_equalTo(30.0/568 *kScreenH);
        make.bottom.mas_equalTo(deleteBtn.mas_top).offset(-35);
    }];
}
// 数据源TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.row %2 == 0){
        printf("??/");
        cell.backgroundColor = kColor(52, 102, 95);
    }else{
        cell.backgroundColor = kColor(56, 145, 136);
    }
    return cell;
}

// 点击事件 点击付款
- (void)clickPayBtn{
    NSLog(@"付款");
}
// 点击删除
- (void)clickDeleteBtn{
    NSLog(@"删除");
}

@end

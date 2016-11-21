//
//  YTActivityCollectionViewController.m
//  ailibuli
//
//  Created by ios on 16/10/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTActivityCollectionViewController.h"
#import "HiddenLine.h"
#import "YTACtivityCollectionCell.h"
#import "YTActivityViewController.h"
#import "YTActivityNewViewController.h"
#import "YTLuckyDrawViewController.h"
#import "NSDate+getInternetDate.h"

@interface YTActivityCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *images;
@end

@implementation YTActivityCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动";
    
    
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
    
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    
    //初始化tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];

    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    YTACtivityCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTACtivityCollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.categoryImg.image = [UIImage imageNamed:self.images[indexPath.row]];
    
    
    return cell;
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{
    
    return 155 * kScreenH / 568.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取当前时间
    NSDate *currentDate = [NSDate getInternetDate];
    
    //获取开始和结束时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSDate *startDate = [formatter dateFromString:@"2016-12-02 00:00:00"];
    
    NSDate *endDate = [formatter dateFromString:@"2016-12-04 23:59:59"];
    
    if (indexPath.row == 0) {
        //        YTActivityNewViewController *activity = [[YTActivityNewViewController alloc]init];
        //
        //        [self.navigationController pushViewController:activity animated:YES];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else{
        //还没有开始
        if (currentDate.timeIntervalSince1970 < startDate.timeIntervalSince1970) {
            //            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
            //
            //            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            //            [alert addAction:action];
            //            [self presentViewController:alert animated:YES completion:nil];
            
            //测试用
            YTLuckyDrawViewController *lucky = [[YTLuckyDrawViewController alloc]init];
            
            [self.navigationController pushViewController:lucky animated:YES];
            
            
        }else if (currentDate.timeIntervalSince1970 > startDate.timeIntervalSince1970 && currentDate.timeIntervalSince1970 < endDate.timeIntervalSince1970){
            YTLuckyDrawViewController *lucky = [[YTLuckyDrawViewController alloc]init];
            
            [self.navigationController pushViewController:lucky animated:YES];
        }else if(currentDate.timeIntervalSince1970 > endDate.timeIntervalSince1970){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已结束" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
        
    }
    
}


- (NSArray *)images{
    if (_images == nil) {
        _images = @[@"首页大图",@"金博会"];
        //_images = @[@"首页大图",@"金博会@2X-1"];
    }
    return _images;
    
}

@end

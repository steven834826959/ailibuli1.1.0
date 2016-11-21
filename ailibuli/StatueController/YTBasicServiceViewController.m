//
//  YTBasicServiceViewController.m
//  ailibuli
//
//  Created by ios on 16/10/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTBasicServiceViewController.h"
#import "HiddenLine.h"
#import "YTBasicServiceCell.h"
#import "ChooseView.h"
#import "ServiceVC.h"
#import "YTActivityCollectionViewController.h"

@interface YTBasicServiceViewController ()<UITableViewDelegate,UITableViewDataSource,ChooseViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)UILabel *bimageLabel;
@property (nonatomic, copy)NSString *state;
@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)UIImageView *bimage;

@end

@implementation YTBasicServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"服务列表";
    
    //背景颜色
    UIImageView *backIV = [[UIImageView alloc]init];
    [backIV setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:backIV];
    UIImage *image = [UIImage imageNamed:@"背景@2x-1"];
    backIV.image = image;
//    [self.view setBackgroundColor:[UIColor colorWithRed:73.0/255 green:187.0/255 blue:180.0/255 alpha:1]];
//    self.view.backgroundColor = [UIColor whiteColor];

    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    
    //初始化tableview
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -2 * kScreenH / 568.0f, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    YTBasicServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[YTBasicServiceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
 
        cell.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
 
    cell.categoryImg.image = [UIImage imageNamed:self.images[indexPath.row]];
    
    
    return cell;


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPat{

    return (self.view.frame.size.height - 49 + 4 * kScreenH / 568.0f) / 4.0f;
}


- (NSArray *)images{
    if (_images == nil) {
        _images = @[@"活动区",@"折扣区",@"抵用区",@"体验区"];
    }
    return _images;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        YTActivityCollectionViewController *collection = [[YTActivityCollectionViewController alloc]init];
        [self.navigationController pushViewController:collection animated:YES];
  
    }else{
        
        ServiceVC *sevice = [[ServiceVC alloc]init];
        sevice.type = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        [self.navigationController pushViewController:sevice animated:YES];
    
    }

   
}






@end

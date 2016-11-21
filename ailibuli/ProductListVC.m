//
//  ProductListVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/7.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductListVC.h"
#import "ProductListVCell.h"
#import "BuyVC.h"
#import "ProListCell.h"
#import "BuyDetermineVC.h"
#import "YUFoldingTableView.h"

#import "YTProductCell.h"
#import "YTActivityViewController.h"


@interface ProductListVC ()<YUFoldingTableViewDelegate,UITextViewDelegate>
@property (nonatomic, strong)YUFoldingTableView *table;
@property (nonatomic, assign)NSInteger i; //第几种产品
@property (nonatomic, assign)int j; // 数量;
@property (nonatomic, assign)float b; //cell高度;
@property (nonatomic, copy)NSString *proDetails;
@property (nonatomic, strong)UIButton *cellBtn;
@property (nonatomic, assign)BOOL ifcellON;//是否打开

@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;

@property(nonatomic,assign)int amountMoney;//合计的钱
@property(nonatomic,assign)NSInteger currentSection;//当前的section

@property(nonatomic,strong)NSArray *ruleAerray;

@property(nonatomic,assign)int ruleCount;//活动栏目数

@property(nonatomic,assign)int cloCount;

@property (assign, nonatomic) int startMoney;


@end

@implementation ProductListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTable];
    
    self.i = 0;
    self.j = 1;
    
    self.ruleCount = 6;
    self.cloCount = 3;
}
//创建tableView
- (void)createTable{
    
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 112)];
    
    UIImageView *backIV = [[UIImageView alloc]init];
    [backIV setFrame:CGRectMake(0, -1, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"背景@2x-1"];
    backIV.image = image;
    UIImageView *topIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *imageTop = [UIImage imageNamed:@"上背景"];
    topIV.userInteractionEnabled = YES;
    
    topIV.image = imageTop;
    [backIV addSubview:topIV];
    backIV.userInteractionEnabled = YES;
    [self.view addSubview:backIV];
    
    foldingTableView.backgroundColor = [UIColor clearColor];
    self.table = foldingTableView;
    
    [self.view addSubview:self.table];
    foldingTableView.foldingDelegate = self;
  
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.table registerNib:[UINib nibWithNibName:@"YTProductCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    

    [topIV addSubview:self.table];
    [self headerView];
    [self FoodView];

    
}
#pragma mark - 框架代理方法

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return YUFoldingSectionHeaderArrowPositionRight;
}

- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return self.chanpin.count;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return 1;
}
- (CGFloat)yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 44;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    //获取网络数据
    return [NSString stringWithFormat:@"%@",[[self.chanpin objectAtIndex:section]objectForKey:@"name"]];
    
    
}


- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section{
    return  [NSString stringWithFormat:@"%@天",[[self.chanpin objectAtIndex:section]objectForKey:@"timeInterval"]];
}

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section{
    
    return [UIColor clearColor];
}

- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YTProductCell *cell = [yuTableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.deletedBtn addTarget:self action:@selector(deletei) forControlEvents:UIControlEventTouchUpInside];
    [cell.addBtn addTarget:self action:@selector(addi) forControlEvents:UIControlEventTouchUpInside];
    
    cell.descProductLabel.text = [self xiangqinglabel:nil andtestIndex:self.testIndex];
    
    cell.startMoney.text = [NSString stringWithFormat:@"%@元",[[self.chanpin objectAtIndex:indexPath.section]objectForKey:@"minBuy"]];

    cell.buyBtn.tag = indexPath.section;
    
    self.currentSection = cell.buyBtn.tag;
    
    [cell.buyBtn addTarget:self action:@selector(buyBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.startMoney = cell.startMoney.text.intValue;
    
    cell.numCountTF.delegate = self;
    cell.numCountTF.keyboardType = UIKeyboardTypeNumberPad;
    //数量
    cell.numCountTF.text = [NSString stringWithFormat:@"%d",self.j];
    
    //永同币
    cell.ytCoin.text = [NSString stringWithFormat:@"%d", [[[self.chanpin objectAtIndex:indexPath.section]objectForKey:@"ytCoins"]intValue] * self.j];
    
    
    cell.allMoney.text = [NSString stringWithFormat:@"%d",cell.startMoney.text.intValue * self.j];
    
    self.amountMoney = cell.allMoney.text.intValue;
    
    return cell;
}



- (void)yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



}

//头部视图
- (void)headerView{
    UIView *View = [UIView new];
    [View setFrame:CGRectMake(0, 0, self.table.frame.size.width, 172 * kScreenH / 568.0f)];
    
    self.table.tableHeaderView = View;
    
    self.table.showsVerticalScrollIndicator = NO;

    //头部头像
    UIImageView *headerImage = [UIImageView new];
    [headerImage setFrame:CGRectMake(0, 0, self.table.frame.size.width, 150 * kScreenH / 568.0f)];
    
    headerImage.image = [UIImage imageNamed:@"首页大图"];
    
    headerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headimgTaped)];
    
    [headerImage addGestureRecognizer:tap];
    
    [View addSubview:headerImage];

    //说明view
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, headerImage.frame.size.height, self.table.frame.size.width, 22 * kScreenH / 568.0f)];
    desLabel.backgroundColor = [UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1];
    desLabel.text = @"爱的期限";
    desLabel.textAlignment = NSTextAlignmentCenter;
    [desLabel setFont:[UIFont systemFontOfSize:13 * kScreenH / 568.0f]];
    [desLabel setTextColor:[UIColor whiteColor]];
    [View addSubview:desLabel];
}

//跳转到活动页
- (void)headimgTaped{

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}

//尾部视图
- (void)FoodView{
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(0, 0, self.table.frame.size.width, 16 * kScreenH / 568.0f + 40 * kScreenH / 568.0f * 6 + 40 * kScreenH / 568.0f)];
   
    [view setBackgroundColor:[UIColor clearColor]];
    
    UILabel *label = [UILabel new];
    [label setFrame:CGRectMake(0, 0, self.table.frame.size.width, 16 * kScreenH / 568.0f)];
    [label setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0 / 255 alpha:1]];
    [view addSubview:label];
    label.text = @"N O T I C E   B O A R D";
    label.font = [UIFont systemFontOfSize:10 * kScreenH / 568.0f];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];

    //活动规则label
    UILabel *rulLabel = [UILabel new];
    [rulLabel setFont:[UIFont systemFontOfSize:14 * kScreenH / 568.0f]];
    rulLabel.text = @"活动规则";
    rulLabel.textColor  = [UIColor whiteColor];
    rulLabel.textAlignment = NSTextAlignmentCenter;
    [rulLabel setFrame:CGRectMake(0, CGRectGetMaxY(label.frame), self.table.frame.size.width, 40 * kScreenH / 568.0f)];
    [view addSubview:rulLabel];
    //分割线
    UIView *labellineTop = [UIView new];
    [labellineTop setFrame:CGRectMake(0, CGRectGetMaxY(rulLabel.frame), self.view.frame.size.width, 1.2)];
    [labellineTop setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0 / 255 alpha:1]];
    [view addSubview:labellineTop];
    
    for (int i = 0; i < 6; i++) {
        UIView *ruleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(labellineTop.frame) + i * 40 * kScreenH / 568.0f, self.view.frame.size.width, 40 * kScreenH / 568.0f)];
        
        UIView *labelline = [UIView new];
        [labelline setFrame:CGRectMake(0, CGRectGetMaxY(ruleView.frame)- 1.2, self.view.frame.size.width, 0.6)];
        [labelline setBackgroundColor:[UIColor whiteColor]];
        labelline.alpha = 0.4;
        //最后一条线不要添加
        if (i < 5) {
            [view addSubview:labelline];
        }
        
        for (int j = 0; j < 3; j++) {
            UILabel *label = [UILabel new];
            [label setFont:[UIFont systemFontOfSize:12 * kScreenH / 568.0f]];
            label.text = self.ruleAerray[i][j];
            label.textColor  = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            [label setFrame:CGRectMake(j * self.table.frame.size.width / 3.0,0,self.table.frame.size.width / 3.0, ruleView.frame.size.height)];
            [ruleView addSubview:label];
        }
      
        [view addSubview:ruleView];
        
    }
    
     self.table.tableFooterView = view;
    
}


#pragma mark - tableView delegate方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        self.i = indexPath.row;
        [self.table reloadData];
    }
    
}

//详细页面
- (void)xiangqinglabel:(UILabel *)label{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[[self.chanpin objectAtIndex:self.i]objectForKey:@"desc"]];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[[self.chanpin objectAtIndex:self.i]objectForKey:@"desc"] length])];
    label.attributedText = attributedString;
    self.b = label.frame.size.height + label.frame.origin.y;
    
}

//此方法代替上面的方法
- (NSString *)xiangqinglabel:(UILabel *)label andtestIndex:(NSInteger)testIndex {
    
    
    if (testIndex == 0) {
    return @"在爱情还没来临之前，积累一定的财富，荣升高富帅/白富美，走向人生巅峰，当爱情降临时自然就得心应手啦~";
    }else if(testIndex == 1){
        return @"谈恋爱之后是不是发现这是件非常费钱的事情？沉着冷静别惊慌，合理的规划能够使你的爱情生活更加甜蜜哦~";
    }else {
    return @"有一定的经济基础是美满婚姻的一大保障，打开潘多拉的魔盒，发现你满满的小金库，想想都有点兴奋呢~";
    }

}

//删除数量
- (void)deletei{
    self.j --;
    if (self.j == 0) {
        self.j = 1;
    }
    [self.table reloadData];
    self.amountMoney = self.startMoney * self.j;
    NSLog(@"-------购买总额%d",self.amountMoney);
    [self limitOut];
}
//增加数量
- (void)addi{
    NSString *maxBuy = [NSString stringWithFormat:@"%@",[[self.chanpin objectAtIndex:self.currentSection]objectForKey:@"maxBuy"]];
    NSLog(@"--------最大购买额%@",maxBuy);
    NSLog(@"-----当前section %ld",(long)self.currentSection);
    
    
    self.j ++;
    [self.table reloadData];
    self.amountMoney = self.startMoney * self.j;
    NSLog(@"-------购买总额%d",self.amountMoney);
    [self limitOut];
}

//超出金额
- (void)limitOut{
    
    NSString *maxBuy = [NSString stringWithFormat:@"%@",[[self.chanpin objectAtIndex:self.currentSection]objectForKey:@"maxBuy"]];
    
    if (self.amountMoney > maxBuy.intValue) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"金额超出超出上限，无法购买！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

//购买按钮触发
- (void)buyBtn:(UIButton *)sender{
    
    NSString *maxBuy = [NSString stringWithFormat:@"%@",[[self.chanpin objectAtIndex:sender.tag]objectForKey:@"maxBuy"]];
    
    if (self.amountMoney > maxBuy.intValue ) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"金额超出超出上限，无法购买！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        BuyDetermineVC *buydet = [BuyDetermineVC new];
        int i  = [[[self.chanpin objectAtIndex:sender.tag]objectForKey:@"minBuy"]intValue];
        buydet.str = [NSString stringWithFormat:@"%d",i * self.j];
        buydet.json =@{@"loanId":[[self.chanpin objectAtIndex:sender.tag]objectForKey:@"_id"]
                       ,@"buyNum":[NSString stringWithFormat:@"%d",self.j],@"name":[[self.chanpin objectAtIndex:sender.tag]objectForKey:@"name"],@"mark":@"123123",@"totalCost":[NSString stringWithFormat:@"%d",self.amountMoney]};
        buydet.shouyi = [NSString stringWithFormat:@"%@",[[[self.chanpin objectAtIndex:sender.tag]objectForKey:@"profitRate"]objectAtIndex:0]];

        [self.navigationController pushViewController:buydet animated:YES];

    }

}


//规则数组
- (NSArray *)ruleAerray{
    if (_ruleAerray == nil) {
        _ruleAerray = @[@[@"充值金额",@"原赠送数量",@"活动期间赠送数量"],@[@"100",@"1",@"2"],@[@"500",@"6",@"12"],@[@"1000",@"13",@"26"],@[@"1500",@"21",@"42"],@[@"2000",@"30",@"60"]];
    }

    return _ruleAerray;
}

#pragma mark - UitextFiledDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.j = (int)textField.text.integerValue;
    self.amountMoney = self.startMoney * self.j;
    [self.table reloadData];
    [self limitOut];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end

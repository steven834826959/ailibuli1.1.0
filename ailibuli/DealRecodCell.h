//
//  DealRecodCell.h
//  ailibuli
//
//  Created by user on 16/7/22.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealRecodCell : UITableViewCell
// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
// 购买数量
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
// 购买金额
@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;
// 交易日期
@property (weak, nonatomic) IBOutlet UILabel *buyDateLabel;
@end

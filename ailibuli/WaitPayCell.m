//
//  WaitPayCell.m
//  ailibuli
//
//  Created by user on 16/7/22.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "WaitPayCell.h"

@interface  WaitPayCell()
// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
// 购买数量
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
// 购买金额
@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;
// 付款状态
@property (weak, nonatomic) IBOutlet UILabel *payStateLabel;
@end

@implementation WaitPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

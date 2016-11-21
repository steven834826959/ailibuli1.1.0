//
//  ProductCell.h
//  ailibuli
//
//  Created by user on 16/7/12.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UITableViewCell
// 产品名称
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
// 数量
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
// 购买时间
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLabel;
// 购买金额
@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;
// 状态
@property (weak, nonatomic) IBOutlet UILabel *haveLabel;
@end

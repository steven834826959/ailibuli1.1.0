//
//  YTProductCell.h
//  ailibuli
//
//  Created by ios on 16/10/20.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startMoney;
@property (weak, nonatomic) IBOutlet UILabel *ytCoin;
@property (weak, nonatomic) IBOutlet UILabel *allMoney;
@property (weak, nonatomic) IBOutlet UIButton *deletedBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UIButton *buyBtn;

@property (weak, nonatomic) IBOutlet UITextField *numCountTF;


@property (weak, nonatomic) IBOutlet UILabel *descProductLabel;




@end

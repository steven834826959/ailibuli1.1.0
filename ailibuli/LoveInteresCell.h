//
//  LoveInteresCell.h
//  ailibuli
//
//  Created by user on 16/7/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoveInteresCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *clickImageView;
//礼品名称
@property (weak, nonatomic) IBOutlet UILabel *giftNameLabel;
//礼品数量
@property (weak, nonatomic) IBOutlet UILabel *gifCountLabel;

/** 是否选中*/
@property (nonatomic ,assign) bool isSelected;

@property (nonatomic, assign) int index;
@end

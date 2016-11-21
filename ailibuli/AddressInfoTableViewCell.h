//
//  AddressInfoTableViewCell.h
//  UICollectionViewDemo
//
//  Created by wuyao on 16/8/30.
//  Copyright © 2016年 MonetWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *bgView;
/*imageview*/
@property (strong, nonatomic) UIView *leftView;

// 其他Cell
- (void)creatCells;
- (void)setTitleText:(NSString *)text infoText:(NSString *)info;

@end

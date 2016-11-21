//
//  AddressInfoTableViewCell.m
//  UICollectionViewDemo
//
//  Created by wuyao on 16/8/30.
//  Copyright © 2016年 MonetWu. All rights reserved.
//

#import "AddressInfoTableViewCell.h"

@implementation AddressInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)creatCells{
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectZero];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.45];
        [self.contentView addSubview:_bgView];
        //左边小图标颜色
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(15, 8, 90, self.frame.size.height - 1)];
        [self addSubview:self.leftView];
        self.leftView.backgroundColor = [UIColor colorWithRed:234/255.0 green:134/255.0 blue:150/255.0 alpha:1];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.leftView addSubview:self.titleLabel];
        
        self.infoLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.infoLabel.textAlignment = NSTextAlignmentRight;
        self.infoLabel.textColor = [UIColor whiteColor];
        self.infoLabel.font = [UIFont systemFontOfSize:11];
        [self.leftView addSubview:self.infoLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellHeight = self.contentView.frame.size.height;
    CGFloat cellWidth = self.contentView.frame.size.width;
    _bgView.frame = CGRectMake(15, 8, cellWidth - 30, cellHeight - 16);
    self.titleLabel.frame = CGRectMake(15, 0, 80, _bgView.frame.size.height);
    self.infoLabel.frame = CGRectMake(80+15, 0, _bgView.frame.size.width - 80 - 50, _bgView.frame.size.height);
    
}


- (void)setTitleText:(NSString *)text infoText:(NSString *)info{
    self.titleLabel.text = text;
    self.infoLabel.text = info;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

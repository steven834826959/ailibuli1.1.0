//
//  AddressTableViewCell.m
//  UICollectionViewDemo
//
//  Created by wuyao on 16/8/30.
//  Copyright © 2016年 MonetWu. All rights reserved.
//

#import "AddressTableViewCell.h"

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame{
    
    frame.size.width -= 40;
    frame.origin.x += 20;
    frame.size.height -= 20;
    
    [super setFrame:frame];
}
@end

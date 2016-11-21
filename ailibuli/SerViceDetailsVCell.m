//
//  SerViceDetailsVCell.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/25.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "SerViceDetailsVCell.h"

@implementation SerViceDetailsVCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.label = [UILabel new];
        self.hImage = [UIImageView new];
        
        
        self.label.font  = [UIFont systemFontOfSize:15];
        [self.label setTextColor:[UIColor whiteColor]];
        self.label.textAlignment = NSTextAlignmentLeft;
        
        self.baseView = [UIView new];
        [self.baseView setBackgroundColor:kColor(133, 127, 186)];
        [self addSubview:self.baseView];
        
        [self addSubview:self.hImage];
        [self addSubview:self.label];
        
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

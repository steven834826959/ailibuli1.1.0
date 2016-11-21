//
//  ServiceVCell.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/24.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ServiceVCell.h"

@implementation ServiceVCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.hImage = [UIImageView new];
        self.YTB = [UILabel new];
        self.name = [UILabel new];
        self.line = [UIView new];
        self.jiantou = [UIImageView new];
        self.xuanze = [UIImageView new];
        
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

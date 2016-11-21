//
//  ProductVCell.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductVCell.h"
@implementation ProductVCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.mainImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width, 175)];
        [self addSubview:self.mainImage];
        [self setBackgroundColor:[UIColor colorWithRed:81.0/255 green:188.0/255 blue:179.0/255 alpha:1]];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

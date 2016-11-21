//
//  ProListCell.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProListCell.h"

@implementation ProListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;

        self.chooseImage = [UIImageView new];
        self.leftLabel = [UILabel new];
        self.leftLabel.font = [UIFont systemFontOfSize:15];
        [self.leftLabel setTextColor:[UIColor whiteColor]];
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
       

        self.rightLabel = [UILabel new];
        self.rightLabel.font = [UIFont systemFontOfSize:15];
        [self.rightLabel setTextColor:[UIColor whiteColor]];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        
        self.centerLabel = [UILabel new];
        self.centerLabel.font = [UIFont systemFontOfSize:15];
        [self.centerLabel setTextColor:[UIColor whiteColor]];
        self.centerLabel.textAlignment = NSTextAlignmentCenter;
        
        self.lineView = [UIView new];
        [self.lineView setBackgroundColor:[UIColor colorWithRed:31.0/255 green:141.0/255 blue:135.0/255 alpha:1]];
        
        
        
         self.addBtn = [UIButton new];
        [self.addBtn setTitle:@"+" forState:UIControlStateNormal];
       

        
        self.deleteBtn  = [UIButton new];
        [self.deleteBtn setTitle:@"-" forState:UIControlStateNormal];
        
        
        self.buyBtn  = [UIButton new];
        self.buyLabel = [UILabel new];
        self.buyLabel.font = [UIFont systemFontOfSize:15];
        [self.buyLabel setTextColor:[UIColor whiteColor]];
        self.buyLabel.textAlignment = NSTextAlignmentCenter;
        

        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  YTBasicServiceCellTableViewCell.m
//  ailibuli
//
//  Created by ios on 16/10/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTBasicServiceCell.h"

@implementation YTBasicServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (UIImageView *)categoryImg{
    if (_categoryImg == nil) {
        _categoryImg = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_categoryImg];
        
//        _categoryImg.frame = self.contentView.frame;
        
        _categoryImg.contentMode = UIViewContentModeScaleToFill;
        
    }
    return _categoryImg;

}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    
    self.categoryImg.frame = CGRectMake(0, 2 * kScreenH / 568.0f, self.frame.size.width, self.frame.size.height -4 * kScreenH / 568.0f );

}

@end

//
//  YTACtivityCollectionCell.m
//  ailibuli
//
//  Created by ios on 16/10/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTACtivityCollectionCell.h"

@implementation YTACtivityCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UIImageView *)categoryImg{
    if (_categoryImg == nil) {
        _categoryImg = [[UIImageView alloc]init];
        
        [self.contentView addSubview:_categoryImg];
        
        _categoryImg.contentMode = UIViewContentModeScaleToFill;
        
    }
    return _categoryImg;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.categoryImg.frame = CGRectMake(0, 5 * kScreenH / 568.0f, self.frame.size.width, self.frame.size.height - 5 * kScreenH / 568.0f);
}

@end

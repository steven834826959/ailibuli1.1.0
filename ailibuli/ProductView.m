//
//  ProductView.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductView.h"
#import "WQFButton.h"
@interface ProductView()



@end

@implementation ProductView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        _btn = [WQFButton new];
        [self addSubview:_btn];
        
        _text_label = [UILabel new];
        _text_label.font = [UIFont systemFontOfSize:15];
        _text_label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_text_label];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
   
    self.btn.frame = CGRectMake(0, 0, self.width, self.width);
    self.btn.layer.cornerRadius = self.width *0.5;
    
    
    self.text_label.frame = CGRectMake(0, self.width+10, self.width, self.height-self.width-10);
}


@end

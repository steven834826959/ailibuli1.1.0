//
//  WQFTextField.m
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "WQFTextField.h"

@implementation WQFTextField

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setColor];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setColor];
    }
    return self;
}

- (void)setColor{
    
    [self setValue:[UIColor colorWithRed:139.0 /255 green:139.0 /255 blue:139.0 /255 alpha:1] forKeyPath:@"self.placeholderLabel.textColor"];
}

@end

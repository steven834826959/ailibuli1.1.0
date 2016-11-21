//
//  YongtongView.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/12.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YongtongView.h"
#import "ServiceDetailsVC.h"


@implementation YongtongView



- (void)layoutSubviews{
    
    self.ifSelected = NO;
    [self createView];
    
}


- (void)createView {
    float j = self.frame.size.width;
    
    self.arrbuy = [NSMutableArray array];
    for (int i = 0 ; i < self.arr.count ; i++) {

        UIButton *button = [UIButton new];        
        [button sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[[self.arr objectAtIndex:i]objectForKey:@"icon"]objectAtIndex:1]]] forState:UIControlStateNormal];
        [button setFrame:CGRectMake(0.093 * j+ 0.234 *j * (i % 3) + self.frame.size.width / 12 * (i % 3), 0.2 *j + 0.156 *j * (i / 3) + 0.125 * j * (i / 3) - 37, 0.187 * j, 0.234 *j)];
        [self addSubview:button];
        [button setTag:i + 201607120];
        [button addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
        
        if (!self.allowsSelected) {
            //button长按事件
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
            longPress.minimumPressDuration = 0.5; //定义按的时间
            [button addGestureRecognizer:longPress];
        }else{
           
        }
        
        if ([self.str isEqualToString:@"可兑换"]) {
            UIImageView *image = [UIImageView new];
            [button addSubview:image];
            [image setFrame:CGRectMake(0, 0, 20, 20)];
            [image setTag:i + 201608250];
        }
    
    }
    
}
- (void)btnLong:(UILongPressGestureRecognizer *)btn{
    
    if (btn.state == UIGestureRecognizerStateBegan) {
    UIImageView *image = (UIImageView *)[self viewWithTag:btn.view.tag - 201607120 + 201608250];
        if ([image.image isEqual:[UIImage imageNamed:@"31"]]) {
            image.image = nil;
            NSInteger aa = btn.view.tag - 201607120 + 1;
            NSString *str = [NSString stringWithFormat:@"%ld",aa];
            [self.arrbuy removeObject:str];
        }else{
            
            image.image = [UIImage imageNamed:@"31"];
            NSInteger aa = btn.view.tag - 201607120 + 1;
            NSString *str = [NSString stringWithFormat:@"%ld",aa];
            [self.arrbuy addObject:str];
        }
        

        [self.delegate WhichServiceBuy:self.arrbuy];
        
    }
    
    
}

- (void)button:(UIButton *)btn{
    [self.delegate WhichService:(int)btn.tag - 201607120 + 1];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

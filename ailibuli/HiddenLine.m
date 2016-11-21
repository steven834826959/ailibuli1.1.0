
//
//  HiddenLine.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "HiddenLine.h"

@implementation HiddenLine
- (void)hiddenNavbarheixian:(UINavigationController *)nav{
    self.navBarHairlineImageView = [self findHairlineImageViewUnder:nav.navigationBar];
    self.navBarHairlineImageView.hidden = YES;
    
    // 标题白字
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    // 背景色
//     nav.navigationBar.barTintColor =[UIColor colorWithRed:122.0/255 green:203.0/255 blue:188.0/255 alpha:1];

}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

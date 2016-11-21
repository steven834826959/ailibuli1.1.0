//
//  JBView.m
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "JBView.h"

@interface JBView()


@end

@implementation JBView
+ (instancetype)JbView{
    return [[NSBundle mainBundle] loadNibNamed:@"JBView" owner:nil options:nil].lastObject;
    
}
- (void)layoutSubviews{

}

@end

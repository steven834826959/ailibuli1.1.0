//
//  ProductHeaderView.m
//  ailibuli
//
//  Created by user on 16/7/12.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductHeaderView.h"

@implementation ProductHeaderView

+ (instancetype)headerView{
    return [[NSBundle mainBundle] loadNibNamed:@"ProductHeaderView" owner:nil options:nil].lastObject;
}

@end

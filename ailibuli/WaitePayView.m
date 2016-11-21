//
//  waitePayView.m
//  ailibuli
//
//  Created by user on 16/7/22.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "WaitePayView.h"

@implementation WaitePayView

+ (instancetype)waitePayView{
    return [[NSBundle mainBundle] loadNibNamed:@"WaitePayView" owner:nil options:nil].lastObject;
}

@end

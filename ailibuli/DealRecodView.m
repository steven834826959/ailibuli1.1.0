//
//  DealRoadView.m
//  ailibuli
//
//  Created by user on 16/7/22.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "DealRecodView.h"

@implementation DealRecodView

+ (instancetype)dealrecodView{
    return [[NSBundle mainBundle] loadNibNamed:@"DealRecodView" owner:nil options:nil].lastObject;
}
@end

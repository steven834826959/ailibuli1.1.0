//
//  SaveTool.m
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "SaveTool.h"

@implementation SaveTool

+ (void)setObject :(id)object forKey:(NSString *)key{
    
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    
}


//根据key值从偏好设置中获取指定的值
+ (id) objectForKey:(NSString *)key {
    
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

@end

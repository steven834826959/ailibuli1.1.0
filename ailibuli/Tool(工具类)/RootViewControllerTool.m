//
//  RootViewControllerTool.m
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "RootViewControllerTool.h"
#import "NewFeatureController.h"

#import "WQFTabBar.h"
#import "StatutVC.h"
#import "ProductVC.h"
#import "ServiceVC.h"
#import "ManageVC.h"
#import "MyVC.h"
#import "WQFTabBar.h"


#import "SaveTool.h"


#define SaveCurVersion @"CurVersion"

@interface RootViewControllerTool()
@property (strong, nonatomic) WQFTabBar *bar;


@end
@implementation RootViewControllerTool


- (UIViewController *)returenVc{
    
    
    // 获取保存的版本号 和  系统当前版本号
    
    NSString *saveVersion = [SaveTool objectForKey:SaveCurVersion];
    
    NSString *curVersion =  [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    NSLog(@"%@-%@",saveVersion,curVersion);
    // 如果两个版本号不同 ->第一次进入程序,记录当前版本号    相同: 第二次进入程序
    
    if ([saveVersion isEqualToString:curVersion]) {

        
        
        return [WQFTabBar new];
        
        

    }else{
        
        [SaveTool setObject:curVersion forKey:SaveCurVersion];

        return [NewFeatureController new];

    }
    
    
    
}


@end

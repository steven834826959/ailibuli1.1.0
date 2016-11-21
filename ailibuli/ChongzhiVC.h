//
//  ChongzhiVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ChongzhiVC : UIViewController
@property (nonatomic,copy) NSString *Str; //金额

@property (strong, nonatomic) JSContext *context;

@end

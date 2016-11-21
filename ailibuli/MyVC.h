//
//  MyVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/16.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LogoutDelegate <NSObject>

- (void)Logout:(NSString *)logout;

@end
@interface MyVC : UIViewController
@property (nonatomic, assign)id<LogoutDelegate>delegate;

@end

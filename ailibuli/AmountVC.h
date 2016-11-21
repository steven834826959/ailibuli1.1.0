//
//  AmountVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/19.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmountVC : UIViewController
@property (nonatomic, assign)BOOL chongzhiORtixian; //是充值还是提现
@property (nonatomic, copy)NSString *j;//银行编码;
@property (nonatomic, copy)NSString *yinhangid;
@end

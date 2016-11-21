//
//  BankNameVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/9.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BankNameDelegate <NSObject>
- (void)bankSetName:(NSMutableDictionary *)bankName;


@end
@interface BankNameVC : UIViewController
@property (nonatomic, assign)id<BankNameDelegate>delegate;
@end

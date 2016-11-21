//
//  BankAddressVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/9.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BankSetAddDelegate <NSObject>
- (void)bankSetAdd:(NSMutableDictionary *)bankAdd;

@end
@interface BankAddressVC : UIViewController
@property (nonatomic, assign)id<BankSetAddDelegate>delegate;
@end

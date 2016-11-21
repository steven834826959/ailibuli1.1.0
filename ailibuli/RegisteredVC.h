//
//  RegisteredVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/6/23.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RegisteredVCDelegate<NSObject>

- (void)valuesBackToStatusVcWithUserName:(NSString *)userName password:(NSString *)password;

@end

@interface RegisteredVC : UIViewController

@property(nonatomic,weak)id<RegisteredVCDelegate>delegate;
@end

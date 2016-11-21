//
//  NameSetVC.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NameSetDelegate <NSObject>
@optional
- (void)sendinput:(NSString *)str cell:(NSInteger)i;
@end
@interface NameSetVC : UIViewController
@property (nonatomic, assign)NSInteger i;
@property (nonatomic, assign)id<NameSetDelegate>delegate;
@end

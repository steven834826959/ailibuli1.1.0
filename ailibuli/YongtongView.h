//
//  YongtongView.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/12.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ServiceDetailsDelegate <NSObject>

- (void)WhichService:(int )i;

- (void)WhichServiceBuy:(NSMutableArray *)arrbuy;

@end

@interface YongtongView : UIView
@property (nonatomic , copy)NSString *str;
@property (nonatomic , strong)NSMutableArray *arr;
@property (nonatomic , strong)NSMutableArray *arrbuy;
@property (nonatomic, assign)id<ServiceDetailsDelegate>delegate;
@property (nonatomic, assign)BOOL ifSelected;
@property (nonatomic, assign)BOOL allowsSelected;
@end

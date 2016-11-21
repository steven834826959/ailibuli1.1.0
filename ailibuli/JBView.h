//
//  JBView.h
//  ailibuli
//
//  Created by user on 16/7/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JBView : UIView
// 爱你妹数
@property (weak, nonatomic) IBOutlet UILabel *ainimeiCount;
// 守爱侠数
@property (weak, nonatomic) IBOutlet UILabel *shouaixiaCount;
// 幸福家庭数
@property (weak, nonatomic) IBOutlet UILabel *xingfuCount;
// 已获得由共同币数
@property (weak, nonatomic) IBOutlet UILabel *ygbCount;
+ (instancetype)JbView;
@end

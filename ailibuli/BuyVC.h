//
//  BuyVC.h
//  
//
//  Created by qiaofeng wu on 16/7/11.
//
//

#import <UIKit/UIKit.h>

@interface BuyVC : UIViewController
@property (nonatomic, copy)NSString *state;
@property (nonatomic, strong)UILabel *number; // 数量
@property (nonatomic, strong)UILabel *price; // 金额
@property (nonatomic, strong)UIButton *timeLimit1; // 期限1
@property (nonatomic, strong)UIButton *timeLimit2; // 期限2
@property (nonatomic, strong)UIButton *timeLimit3; // 期限3
@property (nonatomic, strong)UIButton *timeLimit4; // 期限4
@property (nonatomic, strong)NSMutableArray *chanpin;
@end

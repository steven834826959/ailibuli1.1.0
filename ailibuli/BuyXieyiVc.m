//
//  BuyXieyiVc.m
//  
//
//  Created by qiaofeng wu on 16/9/18.
//
//

#import "BuyXieyiVc.h"

@interface BuyXieyiVc ()
@property (weak, nonatomic) IBOutlet UITextView *contentView;

@end

@implementation BuyXieyiVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"债权转让协议";
    
    self.contentView.editable = NO;

}

@end

//
//  YTAddressInfoViewController.m
//  ailibuli
//
//  Created by ios on 16/11/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTAddressInfoViewController.h"

@interface YTAddressInfoViewController ()

@end

@implementation YTAddressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveLabel.hidden = YES;
    [self.saveBtn setTitle:@"保存并提交" forState:UIControlStateNormal];
 
}

- (void)setSaveBtn:(UIButton *)saveBtn{
    
    self.saveBtn = saveBtn;
    
    [saveBtn setTitle:@"保存并提交" forState:UIControlStateNormal];

}

- (void)setSaveLabel:(UILabel *)saveLabel{
    
    self.saveLabel = saveLabel;
    
    self.saveLabel.hidden = YES;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)baocun{
    //保存地址
    [self.dic setObject:nameLabel.text forKey:@"name"];
    [self.dic setObject:phoneLabel.text forKey:@"mobile"];
    if (self.ifdelete) {
        [self.addArr replaceObjectAtIndex:self.cellNo withObject:self.dic];
    }else{
        [self.addArr addObject:self.dic];
        
    }
    [self AddbaocunRequest: @{@"postAddress":self.addArr}];
    
    
    //提交地址
    NSLog(@"抽奖地址已经被提交-----------！！！");
    
    
}

@end

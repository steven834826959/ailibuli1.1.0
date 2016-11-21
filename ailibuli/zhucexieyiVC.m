//
//  zhucexieyiVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "zhucexieyiVC.h"

@interface zhucexieyiVC ()
@property (weak, nonatomic) IBOutlet UITextView *contenTextView;

@end

@implementation zhucexieyiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册协议";
    self.contenTextView.editable = NO;
}



@end

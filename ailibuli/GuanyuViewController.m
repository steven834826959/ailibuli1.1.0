//
//  GuanyuViewController.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "GuanyuViewController.h"

@interface GuanyuViewController ()
@property (weak, nonatomic) IBOutlet UITextView *aboutusConent;

@end

@implementation GuanyuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    
    self.aboutusConent.editable = NO;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

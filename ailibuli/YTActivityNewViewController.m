//
//  YTActivityNewViewController.m
//  ailibuli
//
//  Created by ios on 16/10/26.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTActivityNewViewController.h"

@interface YTActivityNewViewController ()

@end

@implementation YTActivityNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"欢乐送";
    [self.view setBackgroundColor:BGColor];
    HiddenLine *hidden =[[HiddenLine alloc]init];
    [hidden hiddenNavbarheixian:self.navigationController];
    
    
    //    self.navigationItem.backBarButtonItem.title = @"返回";
    
    self.navigationController.navigationBar.barTintColor =[UIColor colorWithRed:49.0/255 green:178.0/255 blue:170.0/255 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    
    
    //    self.navigationController.navigationBar.
    
    
    //背景图
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.size.width, self.view.size.height - 49)];
    
    bgView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *bgTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgtaped)];
    
    [bgView addGestureRecognizer:bgTap];
    bgView.image = [UIImage imageNamed:@"图层-1"];
    [self.view addSubview:bgView];
}
- (void)bgtaped{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待..." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

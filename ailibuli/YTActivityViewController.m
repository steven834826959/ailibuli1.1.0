//
//  YTActivityViewController.m
//  ailibuli
//
//  Created by ios on 16/10/20.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTActivityViewController.h"
#import "HiddenLine.h"
@interface YTActivityViewController ()

@end

@implementation YTActivityViewController

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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)sharedSingleton{
    static YTActivityViewController *shareSingleton;
    static  dispatch_once_t  onceToken;
    dispatch_once ( &onceToken, ^ {
        
        shareSingleton = [[YTActivityViewController alloc]init] ;
        
    } );
    return shareSingleton;
}
@end

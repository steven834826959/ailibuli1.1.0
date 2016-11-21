
//
//  TixianVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "TixianVC.h"
#import "BalanceVC.h"
#import <JavaScriptCore/JavaScriptCore.h>


@interface TixianVC ()<UIWebViewDelegate>

@end

@implementation TixianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载网页
    [self createWebView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.title = @"提现";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0,0,44,4)];
    [button addTarget:self action:@selector(addAddressAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = barButtonItem;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}




- (void)addAddressAction{
    UIViewController *target = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
        if ([controller isKindOfClass:[BalanceVC class]]) { //这里判断是否为你想要跳转的页面
            target = controller;
        }
    }
    if (target) {
        [self.navigationController popToViewController:target animated:YES]; //跳转
    }
    
}
- (void)createWebView{
    UIWebView *webview = [UIWebView new];
    webview.delegate = self;
    [webview setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    webview.dataDetectorTypes = UIDataDetectorTypeAll;
    // 1. URL 定位资源,需要资源的地址
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.loveyongtong.com/h5/drawings?no=%@&amt=%@",[defaults objectForKey:@"phone"],self.Str];
    NSLog(@"%@",urlStr);
 
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    
    // 3. 发送请求给服务器
    [webview loadRequest:request];
    [self.view addSubview:webview];	
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;


}


@end

//
//  ChongzhiVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ChongzhiVC.h"
#import "BalanceVC.h"

@interface ChongzhiVC ()<UIWebViewDelegate>

@end

@implementation ChongzhiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.title = @"充值";
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

    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.loveyongtong.com/h5/recharge?no=%@&amt=%@",[defaults objectForKey:@"phone"],self.Str];
  
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

#pragma mark - 代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"友情提示" message:@"请确认此手机号是否为银行卡对应预留手机号" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
    
    
    //发送请求
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    
    // 以 JSExport 协议关联 native 的方法
    self.context[@"native"] = self;
    
    // 以 block 形式关联 JavaScript function
    self.context[@"log"] =
    ^(NSString *str)
    {
        NSLog(@"%@", str);
    };
    
    // 以 block 形式关联 JavaScript function
    self.context[@"alert"] =
    ^(NSString *str)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"msg from js" message:str delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    };


    NSString *back = [webView stringByEvaluatingJavaScriptFromString:@"app500003_sendBtn"];
    
    
}






@end

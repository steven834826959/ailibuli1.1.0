//
//  MijiVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "MijiVC.h"
#import <YYKit.h>
@interface MijiVC ()<UITextViewDelegate>
@property(nonatomic,copy)NSString *titleStr;
@property(nonatomic,copy)NSString *contentStr;
@end

@implementation MijiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    [self getTitleAndContent];
    self.title = self.titlea;
    
    //设置背景图
    UIImageView *backIV = [[UIImageView alloc]init];
    [backIV setFrame:CGRectMake(0, -1, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *image = [UIImage imageNamed:@"背景@2x-1"];
    backIV.image = image;
    UIImageView *topIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    UIImage *imageTop = [UIImage imageNamed:@"上背景"];
    topIV.image = imageTop;
    [backIV addSubview:topIV];
    backIV.userInteractionEnabled = YES;
    [self.view addSubview:backIV];
    
    
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0) {
        previous = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@""
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20 - 102)];
    bgView.backgroundColor = [UIColor colorWithRed:134/255.0 green:134/255.0 blue:210/255.0 alpha:.8];
    [self.view addSubview:bgView];
    
    [self layoutTextViews];
    
    
    
    

}

- (void)layoutTextViews{

    CGSize size = [self.titleStr sizeWithAttributes: @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-Bold" size:20 * kScreenH / 568.0f]}];


    UITextView *titleTextView = [[UITextView alloc]initWithFrame:CGRectMake(32, 40, self.view.frame.size.width - 64, size.height + 40)];

    titleTextView.editable = NO;
    
    titleTextView.textColor = [UIColor whiteColor];
    titleTextView.textAlignment = NSTextAlignmentCenter;
    
    titleTextView.font = [UIFont fontWithName:@"Helvetica-Bold" size:20 * kScreenH / 568.0f];
    
    titleTextView.text = self.titleStr;
    titleTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:titleTextView];
    
    
    
    
    
    UITextView *contentTextView = [[UITextView alloc]initWithFrame:CGRectMake(32,CGRectGetMaxY(titleTextView.frame) + 10, self.view.frame.size.width  -64, self.view.frame.size.height - 49 - CGRectGetMaxY(titleTextView.frame)- 5- 64 - 18)];
    contentTextView.textColor = [UIColor whiteColor];

    
    
    
    
    
    contentTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:contentTextView];
    
    contentTextView.editable = NO;
    contentTextView.showsVerticalScrollIndicator = NO;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 8;// 字体的行间距
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:14 * kScreenH / 568.0f],
                                 
                                 NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    
    contentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.contentStr attributes:attributes];
    



}



- (void)getTitleAndContent{
//    UIWebView *webview = [UIWebView new];
    
//    [webview setFrame:CGRectMake(5, 0, self.view.frame.size.width-10, self.view.frame.size.height - 50)];
    
    
//    webview.dataDetectorTypes = UIDataDetectorTypeAll;
    
//    webview.backgroundColor = [UIColor greenColor];
    // 1. URL 定位资源,需要资源的地址
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.loveyongtong.com/secret/%@",self.idd];
//    NSLog(@"%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //网页字符串
    NSString *htmlStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *titleArray = [htmlStr componentsSeparatedByString:@"<h1>"];
    
    NSString *titleStr = [titleArray.lastObject componentsSeparatedByString:@"</h1>"].firstObject;
    
    self.titleStr = titleStr;
    
    
    NSArray *contentArray = [titleArray.lastObject componentsSeparatedByString:@"<article>"];
    
    //正文内容
    NSString *contentStr = [contentArray.lastObject componentsSeparatedByString:@"</article>"].firstObject;
    
    self.contentStr = contentStr;

    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 3. 发送请求给服务器
//    [webview loadRequest:request];
//    [self.view addSubview:webview];
    
    
}



@end

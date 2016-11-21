//
//  NameSetVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/8/11.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "NameSetVC.h"
#define KScreenWidth        [UIScreen mainScreen].bounds.size.width
#define KScreenHeight       [UIScreen mainScreen].bounds.size.height
@interface NameSetVC ()
@property (nonatomic, strong)UITextField *input;
@end

@implementation NameSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:BGColor];
    [self createView];
    
}

- (void)createView{
    UIView *view = [UIView new];
    [view setFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, 30)];
    [self.view addSubview:view];
    //背景图
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
    
    UILabel *label = [UILabel new];
    label.textColor = [UIColor whiteColor];
    if (self.i == 0) {
        label.text = @"省份";
    }else if (self.i == 1) {
        label.text = @"详细地址";

    }else if (self.i == 2) {
        label.text = @"邮政编码";

    }
    label.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:label];
    [label setFrame:CGRectMake(20, 10,  self.view.frame.size.width - 40, 30)];
    
    UIView *veiw1 = [UIView new];
    [veiw1 setBackgroundColor:[UIColor colorWithRed:43/255.0 green:43/255.0 blue:43/255.0 alpha:1]];
    [self.view addSubview:veiw1];
    [veiw1 setFrame:CGRectMake(10, 40, self.view.frame.size.width - 20, 40)];
    
    self.input = [UITextField new];
    [self.input setFrame:CGRectMake(20, 40, self.view.frame.size.width - 40, 40)];
    [self.view addSubview:self.input];
    self.input.textColor = [UIColor whiteColor];
    [self.input setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    UIButton *addAddress = [[UIButton alloc] initWithFrame:CGRectMake(KScreenWidth - 55, 20, 44, 44)];
    addAddress.titleLabel.font = [UIFont systemFontOfSize:15];
    [addAddress setTitle:@"完成" forState:UIControlStateNormal];
    [addAddress setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(quding) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addAddress];
    
    
}

- (void)quding{
    
    [self.input resignFirstResponder];
    if (self.i == 0) {
        [self.delegate sendinput:self.input.text cell:self.i];
    }
    if (self.i == 1) {
        [self.delegate sendinput:self.input.text cell:self.i];
    }
    if (self.i == 2) {
        [self.delegate sendinput:self.input.text cell:self.i];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



@end

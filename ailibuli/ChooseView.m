//
//  ChooseView.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/6.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ChooseView.h"

@implementation ChooseView
- (void)createView{
    self.backgroundColor = [UIColor clearColor];
    if ([self.type isEqualToString:@"1"]) {
        UILabel *label1 = [UILabel new];
        UILabel *label2 = [UILabel new];
        UILabel *label3 = [UILabel new];
        label1.text = @"单身   >   孤独的单身狗";
        label2.text = @"恋爱   >   快乐的虐狗团";
        label3.text = @"已婚   >   淡定的过日子";
        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:label3];
    
        [label1 setFrame:CGRectMake(15, 25, self.frame.size.width - 60, 30)];
        [label2 setFrame:CGRectMake(15, 75, self.frame.size.width - 60, 30)];
        [label3 setFrame:CGRectMake(15, 125, self.frame.size.width - 60, 30)];
        [label1 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:125.0/255 blue:183.0/255 alpha:1]];
        [label1 setTextColor:[UIColor whiteColor]];
        [label2 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:125.0/255 blue:183.0/255 alpha:1]];
        [label2 setTextColor:[UIColor whiteColor]];
        [label3 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:125.0/255 blue:183.0/255 alpha:1]];
        [label3 setTextColor:[UIColor whiteColor]];
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label3.textAlignment = NSTextAlignmentCenter;
        
        
        
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn1)];
        [label1 addGestureRecognizer:tap1];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn2)];
        [label2 addGestureRecognizer:tap2];
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn3)];
        [label3 addGestureRecognizer:tap3];
        
        [label1 setUserInteractionEnabled:YES];
        [label2 setUserInteractionEnabled:YES];
        [label3 setUserInteractionEnabled:YES];

        
        
        UILabel *lableBtn1 = [UILabel new];
        UILabel *lableBtn2 = [UILabel new];
        UILabel *lableBtn3 = [UILabel new];
        [lableBtn1 setFrame:CGRectMake(15 + label1.frame.size.width, 25, 30, 30)];
        [lableBtn2 setFrame:CGRectMake(15 + label1.frame.size.width, 75, 30, 30)];
        [lableBtn3 setFrame:CGRectMake(15 + label1.frame.size.width, 125, 30, 30)];
        
        self.btn1 = [UIButton new];
        self.btn2 = [UIButton new];
        self.btn3 = [UIButton new];

        [self.btn1 setFrame:CGRectMake(20 + label1.frame.size.width, 30, 20, 20)];
        [self.btn2 setFrame:CGRectMake(20 + label1.frame.size.width, 80, 20, 20)];
        [self.btn3 setFrame:CGRectMake(20 + label1.frame.size.width, 130, 20, 20)];
        //设置选择和未选择的按钮背景颜色
        [lableBtn1 setBackgroundColor:[UIColor colorWithRed:130.0/255 green:125.0/255 blue:183.0/255 alpha:1]];
        [lableBtn2 setBackgroundColor:[UIColor colorWithRed:130.0/255 green:125.0/255 blue:183.0/255 alpha:1]];
        [lableBtn3 setBackgroundColor:[UIColor colorWithRed:130.0/255 green:125.0/255 blue:183.0/255 alpha:1]];
        [self addSubview:lableBtn1];
        [self addSubview:lableBtn2];
        [self addSubview:lableBtn3];
        
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        
        
        if ([self.state isEqualToString:@"单身"]) {
            [self actionBtn1];
            
        }else if([self.state isEqualToString:@"恋爱"]){
            [self actionBtn2];

        }else if ([self.state isEqualToString:@"已婚"]){
            [self actionBtn3];
        }
        
        
        [self.btn1 addTarget:self action:@selector(actionBtn1) forControlEvents:UIControlEventTouchUpInside];
        [self.btn2 addTarget:self action:@selector(actionBtn2) forControlEvents:UIControlEventTouchUpInside];
        [self.btn3 addTarget:self action:@selector(actionBtn3) forControlEvents:UIControlEventTouchUpInside];

    }else if([self.type isEqualToString:@"2"]){
        
        UILabel *label1 = [UILabel new];
        UILabel *label2 = [UILabel new];
        label1.text = @"是";
        label2.text = @"否";
        [self addSubview:label1];
        [self addSubview:label2];
        
        [label1 setFrame:CGRectMake(15, 25, self.frame.size.width - 60, 30)];
        [label2 setFrame:CGRectMake(15, 75, self.frame.size.width - 60, 30)];
        [label1 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:126.0/255 blue:181.0/255 alpha:1]];
        [label1 setTextColor:[UIColor whiteColor]];
        [label2 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:126.0/255 blue:181.0/255 alpha:1]];
        [label2 setTextColor:[UIColor whiteColor]];
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        
        UILabel *lableBtn1 = [UILabel new];
        UILabel *lableBtn2 = [UILabel new];
        [lableBtn1 setFrame:CGRectMake(15 + label1.frame.size.width, 25, 30, 30)];
        [lableBtn2 setFrame:CGRectMake(15 + label1.frame.size.width, 75, 30, 30)];
        
        self.btn1 = [UIButton new];
        self.btn2 = [UIButton new];
        
        [self.btn1 setFrame:CGRectMake(20 + label1.frame.size.width, 30, 20, 20)];
        [self.btn2 setFrame:CGRectMake(20 + label1.frame.size.width, 80, 20, 20)];
        
        [lableBtn1 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:126.0/255 blue:181.0/255 alpha:1]];
        [lableBtn2 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:126.0/255 blue:181.0/255 alpha:1]];
        [self addSubview:lableBtn1];
        [self addSubview:lableBtn2];
        
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        
        [self actionBtn1];
        
        if ([self.bachelordom isEqualToString:@"是"]) {
            [self actionBtn1];
            
        }else if([self.bachelordom isEqualToString:@"否"]){
            [self actionBtn2];
            
        }
        
        
        [self.btn1 addTarget:self action:@selector(actionBtn1) forControlEvents:UIControlEventTouchUpInside];
        [self.btn2 addTarget:self action:@selector(actionBtn2) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn1)];
        [label1 addGestureRecognizer:tap1];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn2)];
        [label2 addGestureRecognizer:tap2];
        [label1 setUserInteractionEnabled:YES];
        [label2 setUserInteractionEnabled:YES];
        
    }else if([self.type isEqualToString:@"3"]){
        UILabel *label1 = [UILabel new];
        UILabel *label2 = [UILabel new];
        UILabel *label3 = [UILabel new];
        label1.text = @"单身   >   孤独的单身狗";
        label2.text = @"恋爱   >   快乐的虐狗团";
        label3.text = @"已婚   >   淡定的过日子";
        [self addSubview:label1];
        [self addSubview:label2];
        [self addSubview:label3];
        
        [label1 setFrame:CGRectMake(15, 25, self.frame.size.width - 60, 30)];
        [label2 setFrame:CGRectMake(15, 75, self.frame.size.width - 60, 30)];
        [label3 setFrame:CGRectMake(15, 125, self.frame.size.width - 60, 30)];
        [label1 setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1]];
        [label1 setTextColor:[UIColor whiteColor]];
        [label2 setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1]];
        [label2 setTextColor:[UIColor whiteColor]];
        [label3 setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1]];
        [label3 setTextColor:[UIColor whiteColor]];
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        label3.textAlignment = NSTextAlignmentCenter;
        
        UILabel *lableBtn1 = [UILabel new];
        UILabel *lableBtn2 = [UILabel new];
        UILabel *lableBtn3 = [UILabel new];
        [lableBtn1 setFrame:CGRectMake(15 + label1.frame.size.width, 25, 30, 30)];
        [lableBtn2 setFrame:CGRectMake(15 + label1.frame.size.width, 75, 30, 30)];
        [lableBtn3 setFrame:CGRectMake(15 + label1.frame.size.width, 125, 30, 30)];
        
        self.btn1 = [UIButton new];
        self.btn2 = [UIButton new];
        self.btn3 = [UIButton new];
        
        [self.btn1 setFrame:CGRectMake(20 + label1.frame.size.width, 30, 20, 20)];
        [self.btn2 setFrame:CGRectMake(20 + label1.frame.size.width, 80, 20, 20)];
        [self.btn3 setFrame:CGRectMake(20 + label1.frame.size.width, 130, 20, 20)];
        
        [lableBtn1 setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1]];
        [lableBtn2 setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1]];
        [lableBtn3 setBackgroundColor:[UIColor colorWithRed:133.0/255 green:127.0/255 blue:186.0/255 alpha:1]];
        [self addSubview:lableBtn1];
        [self addSubview:lableBtn2];
        [self addSubview:lableBtn3];
        
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        
        [self actionBtn1];
        
        
        [self.btn1 addTarget:self action:@selector(actionBtn1) forControlEvents:UIControlEventTouchUpInside];
        [self.btn2 addTarget:self action:@selector(actionBtn2) forControlEvents:UIControlEventTouchUpInside];
        [self.btn3 addTarget:self action:@selector(actionBtn3) forControlEvents:UIControlEventTouchUpInside];

        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn1)];
        [label1 addGestureRecognizer:tap1];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn2)];
        [label2 addGestureRecognizer:tap2];
        UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn3)];
        [label3 addGestureRecognizer:tap3];
        [label1 setUserInteractionEnabled:YES];
        [label2 setUserInteractionEnabled:YES];
        [label3 setUserInteractionEnabled:YES];
        
    }else if([self.type isEqualToString:@"4"]){
        UILabel *label1 = [UILabel new];
        UILabel *label2 = [UILabel new];
        label1.text = @"男";
        label2.text = @"女";
        [self addSubview:label1];
        [self addSubview:label2];
        
        [label1 setFrame:CGRectMake(15, 25, self.frame.size.width - 60, 30)];
        [label2 setFrame:CGRectMake(15, 75, self.frame.size.width - 60, 30)];
        [label1 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:127.0/255 blue:179.0/255 alpha:1]];
        [label1 setTextColor:[UIColor whiteColor]];
        [label2 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:127.0/255 blue:179.0/255 alpha:1]];
        [label2 setTextColor:[UIColor whiteColor]];
        label1.textAlignment = NSTextAlignmentCenter;
        label2.textAlignment = NSTextAlignmentCenter;
        
        UILabel *lableBtn1 = [UILabel new];
        UILabel *lableBtn2 = [UILabel new];
        [lableBtn1 setFrame:CGRectMake(15 + label1.frame.size.width, 25, 30, 30)];
        [lableBtn2 setFrame:CGRectMake(15 + label1.frame.size.width, 75, 30, 30)];
        
        self.btn1 = [UIButton new];
        self.btn2 = [UIButton new];
        
        [self.btn1 setFrame:CGRectMake(20 + label1.frame.size.width, 30, 20, 20)];
        [self.btn2 setFrame:CGRectMake(20 + label1.frame.size.width, 80, 20, 20)];
        
        [lableBtn1 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:127.0/255 blue:179.0/255 alpha:1]];
        [lableBtn2 setBackgroundColor:[UIColor colorWithRed:131.0/255 green:127.0/255 blue:179.0/255 alpha:1]];
        [self addSubview:lableBtn1];
        [self addSubview:lableBtn2];
        
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        
        
        [self actionBtn1];
            
       
        
        
        [self.btn1 addTarget:self action:@selector(actionBtn1) forControlEvents:UIControlEventTouchUpInside];
        [self.btn2 addTarget:self action:@selector(actionBtn2) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn1)];
        [label1 addGestureRecognizer:tap1];
        UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn2)];
        [label2 addGestureRecognizer:tap2];
        [label1 setUserInteractionEnabled:YES];
        [label2 setUserInteractionEnabled:YES];
        
    }
}

- (void)actionBtn1{
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    if ([self.type isEqualToString:@"1"]||[self.type isEqualToString:@"3"]) {
        [self.delegate sendState:@"单身"];
    }else if([self.type isEqualToString:@"2"]){
        [self.delegate sendBachelordom:@"是"];
    }else if([self.type isEqualToString:@"4"]){
        [self.delegate sendSex:@"男"];
        
    }

}
- (void)actionBtn2{
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    if ([self.type isEqualToString:@"1"]||[self.type isEqualToString:@"3"]) {
        [self.delegate sendState:@"恋爱"];
    }else if([self.type isEqualToString:@"2"]){
        [self.delegate sendBachelordom:@"否"];
    }else if([self.type isEqualToString:@"4"]){
        [self.delegate sendSex:@"女"];

    }
}
- (void)actionBtn3{
    [_btn1 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
    [self.delegate sendState:@"已婚"];
}



@end

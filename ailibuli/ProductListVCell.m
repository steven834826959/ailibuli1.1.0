//
//  ProductListVCell.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/8.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "ProductListVCell.h"

@implementation ProductListVCell
//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//
//        self.backgroundColor  = [UIColor clearColor];
//        self.userInteractionEnabled =YES;
//        
//        self.label1 = [UILabel new];
//        self.label11 = [UILabel new];
//        self.label111 = [UILabel new];
//        self.label1111 = [UILabel new];
//        self.label11111 = [UILabel new];
//
//        self.label2 = [UILabel new];
//        self.label22 = [UILabel new];
//        self.label3 = [UILabel new];
//        self.label33 = [UILabel new];
//        self.label4 = [UILabel new];
//        self.label44 = [UILabel new];
//
//        self.label1Image = [UIImageView new];
//        self.label2Image = [UIImageView new];
//        self.label3Image = [UIImageView new];
//        self.label4Image = [UIImageView new];
//
//        self.button1 = [UIButton new];
//        self.button2 = [UIButton new];
//        self.button3 = [UIButton new];
//        self.button4 = [UIButton new];
//        [self.button1 addTarget:self action:@selector(actionBtn1) forControlEvents:UIControlEventTouchUpInside];
//        [self.button2 addTarget:self action:@selector(actionBtn2) forControlEvents:UIControlEventTouchUpInside];
//        [self.button3 addTarget:self action:@selector(actionBtn3) forControlEvents:UIControlEventTouchUpInside];
//        [self.button4 addTarget:self action:@selector(actionBtn4) forControlEvents:UIControlEventTouchUpInside];
//
//        self.button5 = [UIButton new];
//        
//        
//        self.label1.textColor = [UIColor whiteColor];
//        self.label11.textColor = [UIColor whiteColor];
//        self.label111.textColor = [UIColor whiteColor];
//        self.label1111.textColor = [UIColor whiteColor];
//        self.label11111.textColor = [UIColor whiteColor];
//        self.label2.textColor = [UIColor whiteColor];
//        self.label22.textColor = [UIColor whiteColor];
//        self.label3.textColor = [UIColor whiteColor];
//        self.label33.textColor = [UIColor whiteColor];
//        self.label4.textColor = [UIColor whiteColor];
//        self.label44.textColor = [UIColor whiteColor];
//
//        [self.label1 setFont:[UIFont systemFontOfSize:13]];
//        [self.label11 setFont:[UIFont systemFontOfSize:12]];
//        [self.label111 setFont:[UIFont systemFontOfSize:12]];
//        [self.label1111 setFont:[UIFont systemFontOfSize:12]];
//        [self.label11111 setFont:[UIFont systemFontOfSize:12]];
//
//        [self.label2 setFont:[UIFont systemFontOfSize:13]];
//        [self.label22 setFont:[UIFont systemFontOfSize:12]];
//        
//        [self.label3 setFont:[UIFont systemFontOfSize:13]];
//        [self.label33 setFont:[UIFont systemFontOfSize:12]];
//        
//        [self.label4 setFont:[UIFont systemFontOfSize:13]];
//        [self.label44 setFont:[UIFont systemFontOfSize:12]];
//        self.label44.numberOfLines = 0;
//        
//        [self addSubview:self.label1Image];
//        [self addSubview:self.label1];
//        [self addSubview:self.label11];
//        [self addSubview:self.label111];
//        [self addSubview:self.label1111];
//        [self addSubview:self.label11111];
//        
//        [self addSubview:self.button1];
//        [self addSubview:self.button2];
//        [self addSubview:self.button3];
//        [self addSubview:self.button4];
//        
//        [self addSubview:self.label2Image];
//        [self addSubview:self.label2];
//        [self addSubview:self.label22];
//        
//        [self addSubview:self.label3Image];
//        [self addSubview:self.label3];
//        [self addSubview:self.label33];
//        
//        [self addSubview:self.label4Image];
//        [self addSubview:self.label4];
//        [self addSubview:self.label44];
//        
//        [self addSubview:self.button5];
//        
//
//       
//
//    }
//    return self;
//    
//}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    
//    [self.label1Image setImage:[UIImage imageNamed:@"确定取消紫色反"]];
//    [self.label1Image setFrame:CGRectMake(10, 0,self.frame.size.width - 20 , 20)];
//    
//    self.label1.text = @"爱的期限";
//    self.label11.text = [NSString stringWithFormat:@"%@(%@天)",[[self.shuju objectAtIndex:0]objectForKey:@"name"],[[self.shuju objectAtIndex:0]objectForKey:@"timeInterval"]];
//    self.label111.text = [NSString stringWithFormat:@"%@(%@天)",[[self.shuju objectAtIndex:1]objectForKey:@"name"],[[self.shuju objectAtIndex:1]objectForKey:@"timeInterval"]];
//    self.label1111.text = [NSString stringWithFormat:@"%@(%@天)",[[self.shuju objectAtIndex:2]objectForKey:@"name"],[[self.shuju objectAtIndex:2]objectForKey:@"timeInterval"]];
//    self.label11111.text = [NSString stringWithFormat:@"%@(%@天)",[[self.shuju objectAtIndex:3]objectForKey:@"name"],[[self.shuju objectAtIndex:3]objectForKey:@"timeInterval"]];
//
//    
//
//    
//    [self.label1 setFrame:CGRectMake(35, 0,self.frame.size.width - 20 , 22.5)];
//    [self.label11 setFrame:CGRectMake(50, 22.5 * 1,self.frame.size.width - 20 , 22.5)];
//    [self.label111 setFrame:CGRectMake(50, 22.5 * 2,self.frame.size.width - 20 , 22.5)];
//    [self.label1111 setFrame:CGRectMake(50, 22.5 * 3,self.frame.size.width - 20 , 22.5)];
//    [self.label11111 setFrame:CGRectMake(50, 22.5 * 4,self.frame.size.width - 20 , 22.5)];
//    [self.button1 setFrame:CGRectMake(35, 22.5 * 1 + 5.25, 12, 12)];
//    [self.button2 setFrame:CGRectMake(35, 22.5 * 2 + 5.25, 12, 12)];
//    [self.button3 setFrame:CGRectMake(35, 22.5 * 3 + 5.25, 12, 12)];
//    [self.button4 setFrame:CGRectMake(35, 22.5 * 4 + 5.25, 12, 12)];
//
//    [self.label2Image setImage:[UIImage imageNamed:@"确定取消紫色反"]];
//    self.label2.text = @"起购金额";
//    
//    [self.label2Image setFrame:CGRectMake(10, 22.5 * 5,self.frame.size.width - 20 , 20)];
//    [self.label2 setFrame:CGRectMake(35, 22.5 * 5,self.frame.size.width - 20 , 20)];
//    [self.label22 setFrame:CGRectMake(35, 22.5 * 6,self.frame.size.width - 20 , 20)];
//    
//    
//    [self.label3Image setImage:[UIImage imageNamed:@"确定取消紫色反"]];
//    self.label3.text = @"预年收益";
//
//   
//    [self.label3Image setFrame:CGRectMake(10, 22.5 * 7,self.frame.size.width - 20 , 20)];
//    [self.label3 setFrame:CGRectMake(35, 22.5 * 7,self.frame.size.width - 20 , 20)];
//    [self.label33 setFrame:CGRectMake(35, 22.5 * 8,self.frame.size.width - 20 , 20)];
//    
//    [self.label4Image setImage:[UIImage imageNamed:@"确定取消紫色反"]];
//    self.label4.text = @"爱情服务";
//
//    [self.label4Image setFrame:CGRectMake(10, 22.5 * 9,self.frame.size.width - 20 , 20)];
//    [self.label4 setFrame:CGRectMake(35, 22.5 * 9,self.frame.size.width - 20 , 20)];
//    [self.label44 setFrame:CGRectMake(35, 22.5 * 10,self.frame.size.width - 20 , 100)];
//    
//    [self actionBtn1];
//    
//    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn1)];
//    [self.label11 addGestureRecognizer:tap1];
//    UITapGestureRecognizer* tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn2)];
//    [self.label111 addGestureRecognizer:tap2];
//    UITapGestureRecognizer* tap3 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn3)];
//    [self.label1111 addGestureRecognizer:tap3];
//    UITapGestureRecognizer* tap4 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBtn4)];
//    [self.label11111 addGestureRecognizer:tap4];
//
//
//    self.label11.userInteractionEnabled = YES;
//    self.label111.userInteractionEnabled = YES;
//    self.label1111.userInteractionEnabled = YES;
//    self.label11111.userInteractionEnabled = YES;
//
//  
//
//}
//
//- (void)actionBtn1{
//    [self.button1 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
//    [self.button2 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button3 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button4 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.delegate WhichProduct:@"1"];
//    self.label22.text = [NSString stringWithFormat:@"%@",[[self.shuju objectAtIndex:0]objectForKey:@"minBuy"]];
//    self.label33.text = [NSString stringWithFormat:@"%@ - %@",[[[self.shuju objectAtIndex:0]objectForKey:@"profitRate"]objectAtIndex:0], [[[self.shuju objectAtIndex:0]objectForKey:@"profitRate"]objectAtIndex:1]];
//
//    [self label44:0];
//
//}
//- (void)actionBtn2{
//    [self.button1 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button2 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
//    [self.button3 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button4 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.delegate WhichProduct:@"2"];
//    self.label22.text = [NSString stringWithFormat:@"%@",[[self.shuju objectAtIndex:1]objectForKey:@"minBuy"]];
//  self.label33.text = [NSString stringWithFormat:@"%@ - %@",[[[self.shuju objectAtIndex:1]objectForKey:@"profitRate"]objectAtIndex:0], [[[self.shuju objectAtIndex:1]objectForKey:@"profitRate"]objectAtIndex:1]];
//    
//    [self label44:1];
//
//
//    
//}
//- (void)actionBtn3{
//    [self.button1 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button2 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button3 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
//    [self.button4 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.delegate WhichProduct:@"3"];
//    self.label22.text = [NSString stringWithFormat:@"%@",[[self.shuju objectAtIndex:2]objectForKey:@"minBuy"]];
//      self.label33.text = [NSString stringWithFormat:@"%@ - %@",[[[self.shuju objectAtIndex:2]objectForKey:@"profitRate"]objectAtIndex:0], [[[self.shuju objectAtIndex:2]objectForKey:@"profitRate"]objectAtIndex:1]];
//    [self label44:2];
//
//}
//
//- (void)actionBtn4{
//    [self.button1 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button2 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button3 setBackgroundImage:[UIImage imageNamed:@"未选择"] forState:UIControlStateNormal];
//    [self.button4 setBackgroundImage:[UIImage imageNamed:@"选择"] forState:UIControlStateNormal];
//    [self.delegate WhichProduct:@"4"];
//    self.label22.text = [NSString stringWithFormat:@"%@",[[self.shuju objectAtIndex:3]objectForKey:@"minBuy"]];
//    self.label33.text = [NSString stringWithFormat:@"%@ - %@",[[[self.shuju objectAtIndex:3]objectForKey:@"profitRate"]objectAtIndex:0], [[[self.shuju objectAtIndex:3]objectForKey:@"profitRate"]objectAtIndex:1]];
//    [self label44:3];
//
//}
//
//
//- (void)label44:(int )i{
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[[self.shuju objectAtIndex:i]objectForKey:@"desc"]];
//    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
//    [paragraphStyle setLineSpacing:6];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [[[self.shuju objectAtIndex:i]objectForKey:@"desc"] length])];
//    self.label44.attributedText = attributedString;
//
//    
//    float h = self.label44.frame.size.height + self.label44.frame.origin.y;
//    
//    NSLog(@"%f",self.label44.frame.size.height);
//    [self.button5 setFrame:CGRectMake(35, h  , 150, 25)];
//    [self.button5 setImage:[UIImage imageNamed:@"查看详情"] forState:UIControlStateNormal];
//
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

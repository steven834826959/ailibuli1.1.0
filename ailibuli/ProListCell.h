//
//  ProListCell.h
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/21.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProListCell : UITableViewCell
@property(nonatomic, strong)UIImageView *chooseImage;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UILabel *rightLabel;
@property(nonatomic, strong)UILabel *centerLabel;
@property(nonatomic, strong)UIButton *addBtn;
@property(nonatomic, strong)UIButton *deleteBtn;
@property(nonatomic, strong)UIButton *buyBtn;
@property(nonatomic, strong)UILabel *buyLabel;

@end

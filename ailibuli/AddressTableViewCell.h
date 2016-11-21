//
//  AddressTableViewCell.h
//  UICollectionViewDemo
//
//  Created by wuyao on 16/8/30.
//  Copyright © 2016年 MonetWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userPhone;
@property (strong, nonatomic) IBOutlet UILabel *ueerAddress;
@end

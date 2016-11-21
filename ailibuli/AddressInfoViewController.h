//
//  AddressInfoViewController.h
//  UICollectionViewDemo
//
//  Created by wuyao on 16/8/30.
//  Copyright © 2016年 MonetWu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressInfoViewController : UIViewController

{
    UIView      *userView;
    UIView      *headerView;
    UITextField     *nameLabel;
    UITextField     *phoneLabel;
    UIView *tapview;
    
}




@property (nonatomic, strong)NSMutableArray *addArr;
@property (nonatomic, assign)BOOL ifdelete;
@property (nonatomic, assign)NSInteger cellNo;

//保存并提交按钮
@property(nonatomic,strong)UIButton *saveBtn;

@property(nonatomic,strong)UILabel *saveLabel;


// 个人中心相关属性
@property (nonatomic ,strong) NSArray *cellTextArray;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableDictionary *dic;


- (void)AddbaocunRequest:(id)json;

@end

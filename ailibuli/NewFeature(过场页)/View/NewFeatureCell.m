//
//  NewFeatureCell.m
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "NewFeatureCell.h"
#import "WQFTabBar.h"


@interface NewFeatureCell()

/** uiimageView*/
@property (nonatomic ,strong) UIImageView *imageView;
/** starBtn*/
@property (nonatomic ,strong) UIButton *starBtn;
@end

@implementation NewFeatureCell


- (UIButton *)starBtn{
    if (_starBtn == nil) {
        _starBtn = [UIButton new];
        _starBtn.frame = CGRectMake(0, 0, 200, 40);
        [_starBtn setTitle:@"立即体验->" forState:0];
        [_starBtn setTitleColor:[UIColor whiteColor] forState:0];
        _starBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        [_starBtn addTarget:self action:@selector(clickStarBtn) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_starBtn];
    }
    return _starBtn;
}


- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return _imageView;
}




- (void)setImage:(UIImage *)image{
    _image = image;
   
    self.imageView.image = image;
    self.starBtn.center = CGPointMake(kScreenW *0.5, kScreenH *0.7);

  
}

- (void)clickStarBtn{
    WQFTabBar *tab = [WQFTabBar new];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

- (void)setStartBtnHidden:(NSIndexPath *)indexPath count:(int)count{
    
    if (indexPath.row == count-1) {
        self.starBtn.hidden = NO;
    }else{
        self.starBtn.hidden = YES;
    }
    
}

@end

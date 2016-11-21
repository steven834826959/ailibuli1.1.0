//
//  NewFeatureCell.h
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFeatureCell : UICollectionViewCell

/** 图片*/
@property (nonatomic ,strong) UIImage *image;

- (void)setStartBtnHidden:(NSIndexPath *)indexPath count:(int)count;

@end

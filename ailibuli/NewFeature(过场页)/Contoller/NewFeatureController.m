//
//  NewFeatureController.m
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "NewFeatureController.h"

#import "NewFeatureCell.h"


#define NFItemCount 3

@interface NewFeatureController ()<UIScrollViewDelegate>

/**
 *  分页控件
 */
@property (weak,nonatomic) UIPageControl * pageControl;

@end

@implementation NewFeatureController

static NSString * const reuseIdentifier = @"NewFeatureCell";

- (instancetype)init {
    //流水布局
    UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc] init];
    //设置每一个格子的大小
    flowL.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //设置最小行间距
    flowL.minimumLineSpacing = 0;
    //设置每个格子之间的间距
    flowL.minimumInteritemSpacing = 0;
    
    //设置滚动的方向
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    
    return [super initWithCollectionViewLayout:flowL];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    
    [self setUpPageControl];
    
}

- (void)setupCollectionView{
    //使用CollectionView时必须得要注册Cell
    [self.collectionView registerClass:[NewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //取消弹簧效果
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;

}


#pragma mark --------------
#pragma mark CollectionView代理
//总共有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return NFItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"NewFeatures_%02ld",indexPath.row+1];
    
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setStartBtnHidden:indexPath count:NFItemCount];
    return cell;
}

/**
 设置指示器控件
 */
- (void) setUpPageControl
{
    //创建一个分页控件
    UIPageControl *control = [[UIPageControl alloc] init];
    
    control.userInteractionEnabled = NO;
    
    control.numberOfPages = 3;
    control.pageIndicatorTintColor = [UIColor colorWithWhite:0.8 alpha:0.5f];
    control.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    //设置center
    control.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height - 40);
    
    _pageControl = control;
    
    [self.view addSubview:control];
}

#pragma mark - UIScrollView代理
// 只要一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前的偏移量，计算当前第几页
    int currentPage =scrollView.contentOffset.x /scrollView.bounds.size.width + 0.5;
    self.pageControl.currentPage = currentPage;
}



@end

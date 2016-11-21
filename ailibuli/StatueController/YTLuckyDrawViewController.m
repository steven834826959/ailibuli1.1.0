//
//  YTLuckyDrawViewController.m
//  ailibuli
//
//  Created by ios on 16/11/15.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "YTLuckyDrawViewController.h"
#import "LoveInterestVc.h"
#import "ActivityRuleViewController.h"
#import "YTKingAddressViewController.h"



@interface YTLuckyDrawViewController ()<CAAnimationDelegate>
@property(nonatomic,assign)float random;
@property(nonatomic,assign)float startValue;
@property(nonatomic,assign)float endValue;
@property(nonatomic,strong)NSDictionary *awards;
@property(nonatomic,strong)NSArray *data;
@property(nonatomic,strong)NSString *result;
@property(nonatomic,assign)int tickets;
@property(nonatomic,assign)int prize;


//视图相关
@property (strong, nonatomic)UIImageView *plateImageView;
@property (strong, nonatomic)UIImageView *rotateStaticImageView;
@property(nonatomic,strong)UIImageView *backView;
@property(nonatomic,strong)UILabel *myTickets;
@property(nonatomic,strong)UIButton *luckeyBtn;


@end

@implementation YTLuckyDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //网络拿到抽奖券数量
    [self getMyTickets];

    //创建背景视图
    self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -1, self.view.frame.size.width, self.view.frame.size.height)];
    self.backView.image = [UIImage imageNamed:@"背景@2x-1"];
    self.backView.userInteractionEnabled = YES;
    [self.view addSubview:self.backView];
    //活动规则
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"活动规则" style:UIBarButtonItemStylePlain target:self action:@selector(ruleClicked)];
    
    self.navigationController.navigationItem.rightBarButtonItem = right;
    
    //创抽奖转盘
    [self setupLuckeyUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //网络拿到抽奖券数量
    [self getMyTickets];

}

#pragma mark - customMethod
- (void)ruleClicked{
    ActivityRuleViewController *rule = [[ActivityRuleViewController alloc]init];
    [self.navigationController pushViewController:rule animated:YES];
}


//创建抽奖视图
- (void)setupLuckeyUI{
    //转盘标题
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenW - 200) * 0.5, 20, 200, 50)];
    titleView.image = [UIImage imageNamed:@"幸运大转盘标题"];
    [self.backView addSubview:titleView];
    

    //我的抽奖券lable
    self.myTickets = [[UILabel alloc]initWithFrame:CGRectMake((kScreenW - 200) * 0.5, CGRectGetMaxY(titleView.frame) + 10, 200, 20)];
    self.myTickets.textAlignment = NSTextAlignmentCenter;
    self.myTickets.text = [NSString stringWithFormat:@"我的抽奖券：%d张",self.tickets];
    self.myTickets.textColor = [UIColor whiteColor];
    [self.backView addSubview:self.myTickets];
    
    //转盘
    self.plateImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenW - 544 * 0.5 * kScreenH / 568.0f) * 0.5, CGRectGetMaxY(self.myTickets.frame) + 10, 544 * 0.5 * kScreenH / 568.0f, 544 * 0.5 * kScreenH / 568.0f)];
    self.plateImageView.image = [UIImage imageNamed:@"幸运大转盘"];
    [self.backView addSubview:self.plateImageView];
    
    //指针
    self.rotateStaticImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 , 292 * 0.5 * kScreenH / 568.0f, 292 * 0.5 * kScreenH / 568.0f)];
    self.rotateStaticImageView.image = [UIImage imageNamed:@"幸运大转盘指针"];

    self.rotateStaticImageView.center = self.plateImageView.center;
    
    [self.backView addSubview:self.rotateStaticImageView];
    
    
    //开始抽奖按钮
    self.luckeyBtn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenW - 200) * 0.5, CGRectGetMaxY(self.plateImageView.frame) + 10, 200, 40)];
    
    [self.luckeyBtn setTitle:@"立即抽奖" forState:UIControlStateNormal];
    [self.luckeyBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
     [_luckeyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [_luckeyBtn addTarget:self action:@selector(luckeyBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    
    [self.backView addSubview:_luckeyBtn];

}

- (void)luckeyBtnClicked{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"secretKey"]){
        [self nologin];
    }else{
        if (self.tickets == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有奖券无法抽奖" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            //扣除奖券
            
            self.tickets = self.tickets - 1;
            self.myTickets.text = [NSString stringWithFormat:@"我的抽奖券：%d张",self.tickets];
            
            //按钮锁定
            self.luckeyBtn.enabled = NO;
            
            //发送网络请求获得得奖情况并发送奖券数量到服务器更新数量
            
            self.prize = 0;
      
            
            
//            [self addMyScoreWithScore:1];
            
            
            //匹配得奖情况并发送网络请求
            self.endValue = [self fetchResult];
            
            //开始动画
            CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
            rotationAnimation.delegate = self;
            rotationAnimation.fromValue = @(_startValue);
            rotationAnimation.toValue = @(_endValue);
            rotationAnimation.duration = 2.0f;
            rotationAnimation.autoreverses = NO;
            rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            rotationAnimation.removedOnCompletion = NO;
            rotationAnimation.fillMode = kCAFillModeBoth;
            [self.plateImageView.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
        
        }
    
    }

}

- (float)fetchResult{
    
    self.result = self.data[self.prize];
    for (NSString *str in [self.awards allKeys]) {
        if ([str isEqualToString:self.result]) {
            NSDictionary *content = self.awards[str][0];
            int min = [content[@"min"] intValue];
            int max = [content[@"max"] intValue];
            srand((unsigned)time(0));
            self.random = rand() % (max - min) + min;
            
        }
    }
    return radians(self.random + 360 * 5);

}

//角度转弧度
double radians(float degrees) {
    
    return degrees * M_PI / 180;
}

#pragma mark ---- 弹出框
-(void)showAlertViewTitle:(NSString *)aTitle infoS:(NSString *)aInfoS//积分
{
    UIAlertController *alertContr = [UIAlertController alertControllerWithTitle:aTitle message:aInfoS preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"领取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //抽到奖励后进行数据计算
        switch (self.prize) {
            case 0:
                [self jumpMyAddressViewController];
                break;
            case 1:
                [self jumpMyAddressViewController];
                break;
            case 2:
                [self jumpMyAddressViewController];
                break;
            case 3:
                [self jumpMyAddressViewController];
                break;
            case 4:
                
                break;
            case 5:
                
                break;
            case 6:
                
                break;
            case 7:
                
                break;
            default:
                break;
        }
 
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertContr addAction:okAction];
    [alertContr addAction:cancel];
    [self presentViewController:alertContr animated:YES completion:nil];
}

/**
未登录账号
*/
- (void)nologin{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未登录账号" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//拿到我的抽奖券
- (void)getMyTickets{

    //发送网络请求获得奖券数量;
    self.tickets = 10;
}

- (void)addMyScoreWithScore:(int)score{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *phoneNum = [defaults objectForKey:@"phone"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    NSDictionary *param = @{@"mobile":phoneNum ? phoneNum : [defaults objectForKey:@"phoneBackup"],@"num": @(score)};

    [manager POST:@"http://mapi.loveyongtong.com/sysuser/accumulationIncreased" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
   
        NSLog(@"--------增加积分返回值%@",dic);
        
        if ([[dic objectForKey:@"code"] intValue] == 200) {
            
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"积分领取成功！，请在管理页面我的产品中查看" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"去使用" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //跳转到兑换页
                LoveInterestVc *sevices = [[LoveInterestVc alloc]init];
                [self.navigationController pushViewController:sevices animated:YES];
                
            }];
            
            [alert addAction:action];
            [alert addAction:action1];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"提示" message:@"无网络连接，请查看网络连接！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }];

}
//跳转到地址界面
- (void)jumpMyAddressViewController{
    YTKingAddressViewController *myAdd = [[YTKingAddressViewController alloc]init];
    [self.navigationController pushViewController:myAdd animated:YES];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.startValue = self.endValue;
    if (self.startValue >= self.endValue) {
        self.startValue = self.startValue - radians( 360 * 10);
    }
    //延迟1.5秒
    [NSThread sleepForTimeInterval:1.5f];
    
    //解除按钮锁定
    self.luckeyBtn.enabled = YES;
    //弹窗提示
    [self showAlertViewTitle:@"恭喜你！" infoS:[NSString stringWithFormat:@"获得了%@!",self.data[self.prize]]];

}

#pragma mark -- lazy
- (NSArray *)data{
    if (_data == nil) {
        _data =  @[@"一等奖",@"二等奖",@"三等奖",@"四等奖",@"五等奖",@"六等奖",@"七等奖",@"八等奖",];
    }
    return _data;
}

- (NSDictionary *)awards{
    if (_awards == nil) {
        _awards = @{
                    @"一等奖": @[
                            @{
                                @"min": @(272 + 180),
                                @"max":@(313 + 180)
                                }
                            ],
                    @"二等奖": @[
                            @{@"min": @2,
                              @"max":@43
                              }
                            ],
                    @"三等奖": @[
                            @{
                                @"min": @(135 + 90),
                                @"max":@(178 + 90)
                                }
                            ],
                    @"四等奖": @[
                            @{@"min": @317,
                              @"max":@358
                              }
                            ],
                    @"五等奖": @[
                            @{@"min": @(227 - 90),
                              @"max":@(268 - 90)
                              }
                            ],
                    @"六等奖": @[
                            @{
                                @"min": @47,
                                @"max":@88
                                }
                            ],
                    @"七等奖": @[
                            @{@"min": @(92 + 180),
                              @"max":@(133 + 180)
                              }
                            ],
                    @"八等奖": @[
                            @{@"min": @182,
                              @"max":@223
                              }
                            ]
                    };
    }
    
    return _awards;
}




@end

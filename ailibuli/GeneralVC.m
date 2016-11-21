//
//  GeneralVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/9/5.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "GeneralVC.h"
#import "GuanyuViewController.h"
@interface GeneralVC ()

@end

@implementation GeneralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通用设置";
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
    
    [self createMainView];
}
- (void)createMainView{
    for (int i = 0 ; i < 2; i++) {
        
        
        UIButton *baseColorBtn = [UIButton new];
        [baseColorBtn setBackgroundColor:[UIColor colorWithRed:133.0 / 255 green:127.0 / 255 blue:186.0 / 255 alpha:1]];
        [self.view addSubview:baseColorBtn];
        baseColorBtn.frame = CGRectMake( 10 , 10 * kScreenH/ 568.0 + 50 * i , self.view.frame.size.width  - 20, 35 * kScreenH /568.0f);
        
        UILabel *label = [UILabel new];
        [self.view addSubview:label];
        [label setFrame:CGRectMake(20 , 10 * kScreenH / 568.0f + 50 * i , self.view.frame.size.width  - 20, 35 * kScreenH / 568.0f)];
        label.textColor = [UIColor whiteColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14* kScreenH /568.0f];
        
        
        switch (i) {
            case 0:
                label.text = @"关于我们";
                break;
            case 1:
                label.text = @"清除缓存";
                break;
                //            case 2:
                //                label.text = @"重置支付密码";
                //                break;
        }
        
        [baseColorBtn setTag:201609050 + i];
        [baseColorBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)btnAction:(UIButton *)btn{
    
    if (btn.tag == 201609050) {
        GuanyuViewController *guanyu = [GuanyuViewController new];
        [self.navigationController pushViewController:guanyu animated:YES];
           }
    if (btn.tag == 201609051) {
        
        //清除缓存操作
        [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
            
            NSString *message = [NSString stringWithFormat:@"您确认清除%.2f M缓存吗？",totalSize/1024.0/1024];
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //清除内存缓存
                [[SDImageCache sharedImageCache] clearMemory];
                //清除磁盘缓存
                [[SDImageCache sharedImageCache] clearDisk];
                //清除系统网络请求时缓存的数据
                [[NSURLCache sharedURLCache]removeAllCachedResponses];
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [ac addAction:action1];
            [ac addAction:action2];
            [self presentViewController:ac animated:YES completion:nil];
            
            
        }];

        
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已清除缓存" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
//        
//        [alertController addAction:cancelAction];
//        
//        [self presentViewController:alertController animated:YES completion:nil];

    } if (btn.tag == 201609052) {
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

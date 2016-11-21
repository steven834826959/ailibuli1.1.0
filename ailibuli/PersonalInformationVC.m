//
//  PersonalInformationVC.m
//  ailibuli
//
//  Created by qiaofeng wu on 16/7/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "PersonalInformationVC.h"
#import "ChooseView.h"
#import "BankNameVC.h"
#import "QiniuSDK.h"
#import "QN_GTM_Base64.h"
#import <CommonCrypto/CommonHMAC.h>
#import "inputVC.h"

//城市选择器相关
#import "HXProvincialCitiesCountiesPickerview.h"
#import "HXAddressManager.h"


@interface PersonalInformationVC ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChooseViewDelegate,BankNameDelegate>
@property (nonatomic, strong)UILabel *nameField;
@property (nonatomic, strong)UILabel *sexField;
@property (nonatomic, strong)UILabel *riqiField;
@property (nonatomic, strong)UILabel *addField;
@property (nonatomic, strong)UILabel *phoneField;
@property (nonatomic, strong)UILabel *emailField;


@property (nonatomic, strong)UIView *controlView;
@property (nonatomic , assign) int expires;
@property (nonatomic, copy)NSString *qiniuToken;


@property (nonatomic, copy)NSString *headURL;
@property (nonatomic, copy)NSString *nickname;
@property (nonatomic, copy)NSString *shengri;
@property (nonatomic, copy)NSString *gender;
@property (nonatomic, copy)NSString *region;
@property (nonatomic, copy)NSString *email;
@property (nonatomic, copy)NSString *Mobile;

@property (nonatomic, strong)UIDatePicker *pick;



@property(nonatomic,strong)NSDate *currentDate;
@property (nonatomic,strong) HXProvincialCitiesCountiesPickerview *regionPickerView;


@property(nonatomic,strong)UIImage *currentImg;

@end

@implementation PersonalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
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
    
    [self createView];
    [self GRXXRequest];
    
}

- (void)createView{
 
    UIImageView *headimage = [UIImageView new];
//[headimage setImage:[UIImage imageNamed:@"确定取消紫色反"]];
    [headimage setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:headimage];
    headimage.userInteractionEnabled = YES;
    [headimage setFrame:CGRectMake(0 , 0, self.view.frame.size.width , 131)];
    
    UIView *lineView = [UIView new];
    [headimage addSubview:lineView];
    [lineView setBackgroundColor:[UIColor whiteColor]];
    lineView.alpha = 0.4;
    [lineView setFrame:CGRectMake(0, 130, self.view.frame.size.width, 1)];
    
    self.headview = [UIImageView new];
    self.headview.layer.masksToBounds = YES;
    self.headview.layer.cornerRadius = 32.5;
    
    UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendActionSheet)];
    [headimage addGestureRecognizer:tap1];

    [headimage addSubview:self.headview];
    [self.headview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(65, 65));
        make.centerX.mas_equalTo(headimage.mas_centerX);
        make.centerY.mas_equalTo(headimage.mas_centerY);

    }];

//    self.nameid  = [UILabel new];
//    self.nameid.textColor = [UIColor whiteColor];
//    self.nameid.text = @"safas";
//    self.nameid.font = [UIFont systemFontOfSize:13];
//    [headimage addSubview:self.nameid];
//    [self.nameid mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(headimage.mas_centerY);
//        make.right.mas_equalTo(self.headview.mas_left).offset(5);
//        make.left.mas_equalTo(7);
//    }];
    
    
    
    UIImageView *jiantou = [UIImageView new];
    [jiantou setImage:[UIImage imageNamed:@"箭头"]];
    [headimage addSubview:jiantou];
    [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headimage.mas_centerY);
        make.right.mas_equalTo(-7);
        make.size.mas_equalTo(CGSizeMake(6 * kScreenW / 320.0f, 10 * kScreenH / 568.0f));
    }];


    
    for (int i = 0 ; i < 6; i++) {
        UIButton *baseColorBtn = [UIButton new];
        [self.view addSubview:baseColorBtn];

        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15 * kScreenH /568.0f];
        [baseColorBtn addSubview:label];
        
        UIImageView *youxiang = [UIImageView new];
        [baseColorBtn addSubview:youxiang];
        

        UIImageView *jiantou = [UIImageView new];
//        jiantou.contentMode = UIViewContentModeCenter;
        
        [baseColorBtn addSubview:jiantou];
        [jiantou setImage:[UIImage imageNamed:@"箭头"]];
        
        UIView *line = [UIView new];
        [baseColorBtn addSubview:line];
    
        
//        if (i < 4) {
            baseColorBtn.frame = CGRectMake( 0, 131 + 40 * i *
                                            kScreenH / 568.0f, self.view.frame.size.width  , 40 * kScreenH / 568.0f);
//            [baseColorBtn setBackgroundColor:[UIColor colorWithRed:81.0 / 255 green:128.0 / 255 blue:120.0 / 255 alpha:1]];
            [label setFrame:CGRectMake(10, 0, 150, baseColorBtn.frame.size.height)];

            [jiantou setFrame:CGRectMake(baseColorBtn.frame.size.width - 10 - 6, baseColorBtn.frame.size.height * 0.5 - 5 * kScreenH / 568.0f, 6 * kScreenW / 320.0f, 10 * kScreenH / 568.0f)];
        
//        jiantou.center = CGPointMake(baseColorBtn.frame.size.width - 10 - 6, baseColorBtn.centerY);

        
        
        
        [line setFrame:CGRectMake(0, baseColorBtn.frame.size.height - 1, baseColorBtn.frame.size.width, 1)];
        //横线的颜色
        [line setBackgroundColor:[UIColor whiteColor]];
        line.alpha = 0.4;
//        [line setBackgroundColor:[UIColor colorWithRed:175.0/255 green:221.0/255 blue:214.0/255 alpha:1]];
//        }
//       if (i < 6 && i > 3)
//        {
//            baseColorBtn.frame = CGRectMake( 40 , 64 + 125 + 20 + 34 + 47 *  i, self.view.frame.size.width  -  80, 35);
//            [baseColorBtn setBackgroundColor:[UIColor colorWithRed:74.0 / 255 green:74.0 / 255 blue:74.0 / 255 alpha:1]];
//            [label setFrame:CGRectMake(10 + 35, 0, 150, 35)];
//
//            [jiantou setFrame:CGRectMake(baseColorBtn.frame.size.width - 10 - 6, 13, 6, 10)];
//            [youxiang setFrame:CGRectMake(0, 0, 35, 35)];
//            
//        }
        
        [baseColorBtn setTag:201671800 + i ];
        
        [baseColorBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            self.nameField = [UILabel new];
            [baseColorBtn addSubview:self.nameField];
            
            [self.nameField setFrame:CGRectMake(baseColorBtn.frame.size.width - 13 - 6 - 100, 0, 95, baseColorBtn.frame.size.height)];
            [self.nameField setTextColor:[UIColor whiteColor]];
            label.text = @"昵称";
            self.nameField.textAlignment = NSTextAlignmentRight;
            [self.nameField setFont:[UIFont systemFontOfSize:15* kScreenH /568.0f]];
            
            
            
        }else if (i == 1){
            self.sexField = [UILabel new];
            [baseColorBtn addSubview:self.sexField];
            label.text = @"性别";
            [self.sexField setFrame:CGRectMake(baseColorBtn.frame.size.width - 13 - 6 - 100, 0, 95, baseColorBtn.frame.size.height)];
            [self.sexField setTextColor:[UIColor whiteColor]];
            [self.sexField setFont:[UIFont systemFontOfSize:15* kScreenH /568.0f]];

            self.sexField.textAlignment = NSTextAlignmentRight;
            
            
            
        }else if (i == 2){
            self.riqiField = [UILabel new];
            [baseColorBtn addSubview:self.riqiField];
            label.text = @"出生日期";
            [self.riqiField setFrame:CGRectMake(baseColorBtn.frame.size.width - 13 - 6 - 100, 0, 95, baseColorBtn.frame.size.height)];
            [self.riqiField setFont:[UIFont systemFontOfSize:15]];

            [self.riqiField setTextColor:[UIColor whiteColor]];

            
            self.riqiField.textAlignment = NSTextAlignmentRight;
            

            
        }else if (i == 3){
            self.addField = [UILabel new];
            [baseColorBtn addSubview:self.addField];
            [self.addField setFrame:CGRectMake(baseColorBtn.frame.size.width - 13 - 6 - 130, 0, 120, baseColorBtn.frame.size.height)];
            [self.addField setTextColor:[UIColor whiteColor]];
            [self.addField setFont:[UIFont systemFontOfSize:15]];
            label.text = @"地区";
            self.addField.text = @"安陆";
            self.addField.textAlignment = NSTextAlignmentRight;
            
            
        }else if (i == 4){
            label.text = @"邮箱";
            [youxiang setImage:[UIImage imageNamed:@"邮箱"]];
            
            self.emailField = [UILabel new];
            [baseColorBtn addSubview:self.emailField];
            [self.emailField setFrame:CGRectMake(baseColorBtn.frame.size.width - jiantou.frame.size.width - 200 - 20 , 0, 200,  baseColorBtn.frame.size.height)];
            [self.emailField setTextColor:[UIColor whiteColor]];
            [self.emailField setFont:[UIFont systemFontOfSize:15]];
            
            self.emailField.textAlignment = NSTextAlignmentRight;
  
        }else if (i == 5){
            label.text = @"手机号";
            [youxiang setImage:[UIImage imageNamed:@"手机1"]];
            self.phoneField = [UILabel new];
            [baseColorBtn addSubview:self.phoneField];
            [self.phoneField setFrame:CGRectMake(baseColorBtn.frame.size.width - 13 - 6 - 100, 0, 95, 41* kScreenH / 568.0f)];
            [self.phoneField setTextColor:[UIColor whiteColor]];
            [self.phoneField setFont:[UIFont systemFontOfSize:15]];
            
            self.phoneField.textAlignment = NSTextAlignmentRight;
        }
 
    }
    
    
    
}


- (void)sendSex:(NSString *)str{
    self.sex = str;
    if ([self.sex isEqualToString:@"男"]) {
        [self uploadInformation:@{@"gender":@"1"}];
        self.sexField.text = @"男";
    }else if([self.sex isEqualToString:@"女"]){
        [self uploadInformation:@{@"gender":@"2"}];
        self.sexField.text = @"女";

    }
    
}
- (void)address{
    /*
    NSString *address = self.addField.text;
    NSArray *array = [address componentsSeparatedByString:@" "];
    
    NSString *province = @"";//省
    NSString *city = @"";//市
    NSString *county = @"";//县
    if (array.count > 2) {
        province = array[0];
        city = array[1];
        county = array[2];
    } else if (array.count > 1) {
        province = array[0];
        city = array[1];
    } else if (array.count > 0) {
        province = array[0];
    }
    
    [self.regionPickerView showPickerWithProvinceName:province cityName:city countyName:county];*/

    
    
    BankNameVC *add = [BankNameVC new];
    add.delegate = self;
    [self.navigationController pushViewController:add animated:YES];
}

- (HXProvincialCitiesCountiesPickerview *)regionPickerView {
    if (!_regionPickerView) {
        _regionPickerView = [[HXProvincialCitiesCountiesPickerview alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        
        __weak typeof(self) wself = self;
        _regionPickerView.completion = ^(NSString *provinceName,NSString *cityName,NSString *countyName) {
            __strong typeof(wself) self = wself;
            
            //修改文本框内的地址
            //            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName]);
            
            wself.addField.text = [NSString stringWithFormat:@"%@ %@ %@",provinceName,cityName,countyName];
            
            [wself uploadInformation:@{@"city":wself.addField.text}];
            
            
        };
        [self.navigationController.view addSubview:_regionPickerView];
    }
    return _regionPickerView;
}






- (void)bankSetName:(NSMutableDictionary *)bankName{
    self.addField.text = [bankName objectForKey:@"name"];
    [self uploadInformation:@{@"city":[bankName objectForKey:@"name"]}];

}

- (void)nameinput{
    inputVC *input = [inputVC new];
    input.i = 1;
    
    input.title = @"昵称";
    
    input.str = self.nameField.text;
    [self.navigationController pushViewController:input animated:YES];
}

- (void)shengriinput{
    inputVC *input = [inputVC new];
    input.i = 2;
    input.title = @"性别";
    input.str = self.riqiField.text;
    [self.navigationController pushViewController:input animated:YES];
}
- (void)youxianginput{
    inputVC *input = [inputVC new];
    input.i = 3;
    input.title = @"邮箱";
    input.str = self.emailField.text;
    [self.navigationController pushViewController:input animated:YES];
}

- (void)btnAction:(UIButton *)btn{
    
    switch (btn.tag) {
        case 201671800:
            NSLog(@"1");
            [self nameinput];
            break;
        case 201671801:
            [self createChooseView:@"4"];
            NSLog(@"2");
            break;
        case 201671802:
            NSLog(@"3");
            
            [self createChooseView:@"3"];

            break;
        case 201671803:
            [self address];
            NSLog(@"4");
            break;
        case 201671804:
             [self youxianginput];
            NSLog(@"5");
            break;
        case 201671805:
           


            NSLog(@"6");
            break;
        
    }
    
}

- (void)createChooseView:(NSString *)str{
    
    self.controlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    [self.controlView setBackgroundColor:[UIColor clearColor]];
    [[[UIApplication sharedApplication].windows firstObject] addSubview:self.controlView];
    
    UIView *aView = [UIView new];
    [aView setFrame:CGRectMake(25 , kScreenH / 3.5, kScreenW - 50 , 165)];
    //设置时间选择器的背景颜色
    [aView setBackgroundColor:[UIColor colorWithRed:192.0 /255 green:175.0 /251 blue:234.0 /255 alpha:1.0]];
    [self.controlView addSubview:aView];
    
    if([str isEqualToString:@"3"]){
        self.pick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 0, kScreenW - 50, 230)];
        [self.pick setDatePickerMode:UIDatePickerModeDate];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        self.pick.locale = locale;
        [aView addSubview:self.pick];
        NSDateFormatter *inputFormatter= [NSDateFormatter new];
        [inputFormatter setLocale:locale];
        [inputFormatter setDateFormat:@"yyyy.MM.dd"];
        NSDate*inputDate = [inputFormatter dateFromString:self.riqiField.text];
        [self.pick setDate:inputDate animated:NO];
        [self.pick addTarget:self action:@selector(dateChanged2) forControlEvents:UIControlEventValueChanged];
    }else{
        ChooseView *choose = [ChooseView new];
        [choose setFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 150)];
        choose.type = str;
        choose.delegate = self;
        [choose createView];
        [aView addSubview:choose];
    }
 

    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, aView.frame.size.height - 25, aView.frame.size.width, 30 * kScreenH / 568.0f)];
    [imageView setBackgroundColor:[UIColor colorWithRed:234 / 255.0 green:134 / 255.0 blue:150 / 255.0 alpha:1]];
    imageView.userInteractionEnabled = YES;
    [aView addSubview:imageView];
    
    UIButton *quxiao = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30 * kScreenH / 568.0f)];
    [imageView addSubview:quxiao];
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao.titleLabel setFont:[UIFont systemFontOfSize:13 * kScreenH / 568.0f]];
    
    UIButton *queding = [[UIButton alloc]initWithFrame:CGRectMake(imageView.frame.size.width - 50, 0, 50, 30 * kScreenH / 568.0f)];
    [imageView addSubview:queding];
    [queding.titleLabel setFont:[UIFont systemFontOfSize:13 * kScreenH / 568.0f]];
    [queding setTitle:@"确定" forState:UIControlStateNormal];
    
    [quxiao addTarget:self action:@selector(quxiaoButton) forControlEvents:UIControlEventTouchUpInside];
    [queding addTarget:self action:@selector(quedingButton) forControlEvents:UIControlEventTouchUpInside];

}

- (void)dateChanged2{
    if ([self.pick date] == nil) {
        
    }else{
        NSDate *pickerDate = [self.pick date];
        NSDateFormatter *pickerFormatter =[NSDateFormatter new];
        [pickerFormatter setDateFormat:@"yyyy.MM.dd"];
        
        self.riqiField.text = [pickerFormatter stringFromDate:pickerDate];
        
        [self uploadInformation:@{@"birthday":self.riqiField.text}];
    }
}
- (void)quxiaoButton{
    [self.controlView removeFromSuperview];

}
- (void)quedingButton{
    
    [self.controlView removeFromSuperview];

}


- (void)sendActionSheet
{
    
    NSLog(@"12312312");
	    UIActionSheet *send = [[UIActionSheet alloc]
                           initWithTitle:nil
                           delegate:self
                           cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                           otherButtonTitles:@"从相册选照片", @"拍照",nil];
    send.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [send showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self photoAction:nil];
    }
    if (buttonIndex == 1){
        [self cameraAction:nil];
    }
}

- (void)photoAction:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        NSLog(@"该设备没有图片库");
    }
}

- (void)cameraAction:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } else {
        NSLog(@"该设备没有相机");
    }
    
}


//当你选取一张图片的时候, 把图片信息返回到当前页面(图片可以是从照片库中选取的, 也可以是拍照完成后选用的)
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //info是一个字典,用于存放选取的图片信息
    self.headview.image = [info valueForKey:UIImagePickerControllerEditedImage];

    
    self.currentImg = [info valueForKey:UIImagePickerControllerEditedImage];
    
    
    [self sendPicture:self.headview.image];
    
    [self uploadImageToQNFilePath:[self getImagePath:[info valueForKey:UIImagePickerControllerEditedImage]]];
    
    
  
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)sendPicture:(UIImage *)image
{
    
    //保存图片
    NSDate *date = [NSDate date];
    
    self.currentDate = date;
    
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),date];
//    NSData *imgData = UIImageJPEGRepresentation(image,0.5);
//    [imgData writeToFile:aPath atomically:YES];
    
    [UIImagePNGRepresentation(image) writeToFile:aPath atomically:YES];
    
    
    
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}




- (void)uploadImageToQNFilePath:(NSString *)filePath {
    self.qiniuToken = [self makeToken:@"Lp9qNdFIRoUaxkpfdgji7d2Or6FbnRRFC-oX_9w8" secretKey:@"ClX_pwKN_nDZANu1lebVgFwlrG5fDvN8IDhsjzfS"];
    NSLog(@"%@",self.qiniuToken);
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
    
    [upManager putFile:filePath key:nil token:self.qiniuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"info ===== %@", info);
        NSLog(@"resp ===== %@", resp);
        NSString *str = [NSString stringWithFormat:@"http://7xvztp.com1.z0.glb.clouddn.com/%@",[resp objectForKey:@"key"]];
        [self uploadInformation:@{@"avatar":str}];

    }
                option:uploadOption];
    
    
    
}


- (void)uploadInformation:(id)json{
    
    
    NSLog(@"%@",json);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求21头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager POST:@"http://mapi.loveyongtong.com/sysuser/updateInfo" parameters:json progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
    
}
- (NSString *)makeToken:(NSString *)accessKey secretKey:(NSString *)secretKey
{
    const char *secretKeyStr = [secretKey UTF8String];
    
    NSString *policy = [self marshal];
    
    NSData *policyData = [policy dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *encodedPolicy = [QN_GTM_Base64 stringByWebSafeEncodingData:policyData padded:TRUE];
    const char *encodedPolicyStr = [encodedPolicy cStringUsingEncoding:NSUTF8StringEncoding];
    
    char digestStr[CC_SHA1_DIGEST_LENGTH];
    bzero(digestStr, 0);
    
    CCHmac(kCCHmacAlgSHA1, secretKeyStr, strlen(secretKeyStr), encodedPolicyStr, strlen(encodedPolicyStr), digestStr);
    
    NSString *encodedDigest = [QN_GTM_Base64 stringByWebSafeEncodingBytes:digestStr length:CC_SHA1_DIGEST_LENGTH padded:TRUE];
    
    NSString *token = [NSString stringWithFormat:@"%@:%@:%@",  accessKey, encodedDigest, encodedPolicy];
    
    NSLog(@"%@",token);
    return token;//得到了token
}
- (NSString *)marshal
{
    time_t deadline;
    time(&deadline);//返回当前系统时间
    //@property (nonatomic , assign) int expires; 怎么定义随你...
    deadline += (self.expires > 0) ? self.expires : 3600; // +3600秒,即默认token保存1小时.
    
    NSNumber *deadlineNumber = [NSNumber numberWithLongLong:deadline];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    //users是我开辟的公共空间名（即bucket），aaa是文件的key，
    //按七牛“上传策略”的描述：    <bucket>:<key>，表示只允许用户上传指定key的文件。在这种格式下文件默认允许“修改”，若已存在同名资源则会被覆盖。如果只希望上传指定key的文件，并且不允许修改，那么可以将下面的 insertOnly 属性值设为 1。
    //所以如果参数只传users的话，下次上传key还是aaa的文件会提示存在同名文件，不能上传。
    //传users:aaa的话，可以覆盖更新，但实测延迟较长，我上传同名新文件上去，下载下来的还是老文件。
    [dic setObject:@"albl-files" forKey:@"scope"];//根据
    
    [dic setObject:deadlineNumber forKey:@"deadline"];
    
    NSString *json = [self dictionaryToJson:dic];
    
    return json;
}

- (void)GRXXRequest{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求格式
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    // 设置返回格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 设置请求头
    [manager.requestSerializer setValue :@"application/json"forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"secretKey"]forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"sessionid"] forHTTPHeaderField:@"sid"];
    [manager.requestSerializer setValue :[defaults objectForKey:@"userId"] forHTTPHeaderField:@"uid"];
    
    [manager GET:@"http://mapi.loveyongtong.com/sysuser/getUserInfo" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        NSLog(@"%@",dic);
        
        self.phoneField.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"mobile"] ? [[dic objectForKey:@"data"] objectForKey:@"mobile"] : @""];
        [self.headview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"avatar"]]]];
        
       self.nameField.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"name"]];
        if ([[[dic objectForKey:@"data"] objectForKey:@"gender"] intValue] == 1) {
            self.sexField.text = @"男";
        }else if ([[[dic objectForKey:@"data"] objectForKey:@"gender"] intValue]== 2) {
            self.sexField.text = @"女";
        }
       self.riqiField.text = [[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"birthday"]]substringToIndex:10] ;
       self.addField.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"city"]];
        self.emailField.text = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"email"]];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        UIAlertController *alert  = [UIAlertController internetErrorAlertShow];
        [self presentViewController:alert animated:YES completion:nil];
    }];
    
}


- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self GRXXRequest];
    
//    //文件读取操作
//    NSString *readPath=[NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),self.currentDate];
//    
//    NSData *headImagData = [NSData dataWithContentsOfFile:readPath];
//    self.headview.image = [UIImage imageWithData:headImagData scale:1];
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

    
    

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

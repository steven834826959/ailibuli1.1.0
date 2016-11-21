//
//  TZTableviewController.m
//  ailibuli
//
//  Created by user on 16/7/18.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import "TZTableviewController.h"
#import "TZGroupItem.h"
#import "TZTableViewCell.h"

@interface TZTableviewController ()

@end

@implementation TZTableviewController

static NSString *ID = @"pdcell";

- (NSMutableArray *)groupArray{
    if (_groupArray == nil) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}

//初始化时为组样式
- (instancetype)init {
    return  [super initWithStyle:UITableViewStylePlain];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.groupArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}



@end

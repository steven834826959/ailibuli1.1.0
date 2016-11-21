//
//  SaveTool.h
//  ailibuli
//
//  Created by user on 16/6/27.
//  Copyright © 2016年 Qiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaveTool : NSObject

+ (void)setObject :(id)object forKey:(NSString *)key;

+ (id)objectForKey :(NSString *)key;


@end

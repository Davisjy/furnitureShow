//
//  Message.h
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *num;

- (instancetype)initMessageWithDictionary:(NSDictionary *)dict;
+ (instancetype)messageWithDictionary:(NSDictionary *)dict;
@end

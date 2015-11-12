//
//  HomeChild.h
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeChild : NSObject

@property (nonatomic, strong) NSString *childName;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)childNameWithDictionary:(NSDictionary *)dict;

@end

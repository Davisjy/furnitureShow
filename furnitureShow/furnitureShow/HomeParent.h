//
//  HomeParent.h
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HomeChild;
@interface HomeParent : NSObject

@property (nonatomic, strong) NSString *parentName;
@property (nonatomic, strong) NSArray *child;
@property (nonatomic) BOOL isOpen;

- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)homeParentWithDictionary:(NSDictionary *)dict;

@end

//
//  HomeParent.m
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HomeParent.h"
#import "HomeChild.h"

@implementation HomeParent

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        _parentName = dict[@"parenName"];
        _child = dict[@"childData"];
        //特殊处理
        NSMutableArray *child = [NSMutableArray array];
        for (NSDictionary *dict in _child) {
            HomeChild *model = [HomeChild childNameWithDictionary:dict];
            [child addObject:model];
        }
        _child = child;
        _isOpen = NO;
    }
    return self;
}

+ (instancetype)homeParentWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

@end

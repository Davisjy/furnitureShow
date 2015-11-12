//
//  HomeHeaderView.h
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeParent;

@interface HomeHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) HomeParent *parent;
@property (nonatomic, strong) void(^headerViewClick)(void);



+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end

//
//  HomeHeaderView.m
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "HomeHeaderView.h"
#import "HomeParent.h"

@interface HomeHeaderView ()
@property (nonatomic, strong) UIButton *bgBtn;
@end

@implementation HomeHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString *headerViewIdentify = @"headerView";
    HomeHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerViewIdentify];
    if (headerView == nil) {
        headerView = [[self alloc] initWithReuseIdentifier:headerViewIdentify];
    }
    return headerView;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        //设置背景为btn
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:bgButton];
        
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置bgBtn中title的内部偏移
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

        // 设置整体内容的内部偏移
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        
        self.bgBtn = bgButton;
        [_bgBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)btnClick:(UIButton *)btn
{
    if (_parent.isOpen) {
        _parent.isOpen = NO;
        //tableView刷新数据之后，动画失效
        //_bgBtn.imageView.transform = CGAffineTransformIdentity;
    } else {
        _parent.isOpen = YES;
        //tableView刷新数据之后，动画失效
        //_bgBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    if (_headerViewClick) {
        _headerViewClick();
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgBtn.frame = self.bounds;
}

- (void)setParent:(HomeParent *)parent
{
    _parent = parent;
    [_bgBtn setTitle:parent.parentName forState:UIControlStateNormal];
}


@end

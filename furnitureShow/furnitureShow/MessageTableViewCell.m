//
//  MessageTableViewCell.m
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "Message.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessage:(Message *)message
{
    _message = message;
    self.title.text = message.title;
    self.text.text = message.content;
    self.time.text = message.time;
}

@end

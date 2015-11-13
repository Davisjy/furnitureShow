//
//  WebViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "WebViewController.h"
#import "Common.h"
#import "AFNetworking.h"

@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadShow];
}


- (void)loadShow
{
    NSString *all = [NSString stringWithFormat:@"id=%@",self.url];
    NSString *urlStr = [KMessageDetail stringByAppendingString:all];
    //NSString *urlStr = @"http://www.baidu.com";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
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

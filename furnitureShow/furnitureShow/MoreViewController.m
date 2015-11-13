//
//  MoreViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "MoreViewController.h"
#import "Common.h"
#import "AFNetworking.h"

@interface MoreViewController ()
@property (nonatomic, strong) NSString *updateUrl;
@property (nonatomic, strong) NSString *versionCode;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)zhaoSh:(UIButton *)sender {
    UIViewController *zsVC = [[UIViewController alloc] init];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imageView.image = [UIImage imageNamed:@"896.jpg"];
    zsVC.title = @"展会招商";
    [zsVC.view addSubview:imageView];
    [self.navigationController pushViewController:zsVC animated:YES];
}
- (IBAction)fuwu:(UIButton *)sender {
    UIViewController *fuwuVC = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [fuwuVC.view addSubview:webView];
    fuwuVC.title = @"展会服务";
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zhanhuifuwu" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.navigationController pushViewController:fuwuVC animated:YES];
}
- (IBAction)update:(UIButton *)sender {
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    double curentVersion = [appVersion doubleValue];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:KUpdateUrl parameters:nil success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        _versionCode = responseObj[@"versionCode"];
        _updateUrl = responseObj[@"downUrl"];
        double newVersion = [_versionCode doubleValue];
        if (curentVersion != newVersion) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"有可用更新" message:@"是否前往更新" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSURL *url = [NSURL URLWithString:_updateUrl];
                [[UIApplication sharedApplication] openURL:url];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertVC addAction:okAction];
            [alertVC addAction:cancelAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}
- (IBAction)support:(UIButton *)sender {
    UIViewController *supportVC = [[UIViewController alloc] init];
    UIWebView *webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [supportVC.view addSubview:webView];
    supportVC.title = @"灵奇软件空间公司";
    NSString *path = @"http://www.you07.com/";
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.navigationController pushViewController:supportVC animated:YES];
    
}
- (IBAction)suggest:(UIButton *)sender {
    UIViewController *suggestVC = [self.storyboard instantiateViewControllerWithIdentifier:@"suggest"];
    [self presentViewController:suggestVC animated:YES completion:nil];
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

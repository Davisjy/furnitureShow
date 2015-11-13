//
//  SuggestViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "SuggestViewController.h"
#import "Common.h"
#import "AFNetworking.h"

@interface SuggestViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation SuggestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)comment:(UIBarButtonItem *)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"content"] = self.textView.text;
    [manager POST:KSuggestUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        NSString *state = responseObj[@"state"];
        if ([state isEqualToString:@"ok"]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提交成功" message:@"谢谢您！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertVC addAction:okAction];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}

@end

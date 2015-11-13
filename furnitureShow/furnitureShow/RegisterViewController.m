//
//  RegisterViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "RegisterViewController.h"
#import "Common.h"
#import "AFNetworking.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;

@property (nonatomic, strong) NSMutableString *str;
@property (nonatomic, strong) NSString *code;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _str = [NSMutableString string];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary ];
    parameters[@"name"] = self.name.text;
    parameters[@"phone"] = self.phoneNum.text;
    parameters[@"mold"] = self.str;
    [manager POST:KRegisUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        if ([responseObj[@"status"] isEqualToString:@"true"]) {
            self.code = responseObj[@"code"];
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController *detailVC = [sb instantiateViewControllerWithIdentifier:@"detail"];
            [detailVC setValue:self.code forKey:@"codeNum"];
            [self.navigationController pushViewController:detailVC animated:YES];
           // NSLog(@"%@",self.code);
        }
    } failure:^ void(AFHTTPRequestOperation * opration, NSError * error) {
        
    }];
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)getCode:(UIButton *)sender {
    [self loadData];
}

- (IBAction)check:(UIButton *)sender {
    sender.selected = !sender.selected;
    switch (sender.tag) {
        case 1:
        {
            if (sender.selected) {
                [self.str appendFormat:@"%@",@(sender.tag-1)];
            }else{
                NSRange range = [self.str rangeOfString:@"0"];
                
                if (range.length != 0) {
                    [self.str deleteCharactersInRange:range];
                }
            }
        }
            break;
        case 2:
        {
            if (sender.selected) {
                [self.str appendFormat:@"%@",@(sender.tag-1)];
            }else{
                NSRange range = [self.str rangeOfString:@"1"];
                
                if (range.length != 0) {
                    [self.str deleteCharactersInRange:range];
                }
            }
        }
            break;
        case 3:
        {
            if (sender.selected) {
                [self.str appendFormat:@"%@",@(sender.tag-1)];
            }else{
                NSRange range = [self.str rangeOfString:@"2"];
                
                if (range.length != 0) {
                    [self.str deleteCharactersInRange:range];
                }
            }
        }
            break;
        case 4:
        {
            if (sender.selected) {
                [self.str appendFormat:@"%@",@(sender.tag-1)];
            }else{
                NSRange range = [self.str rangeOfString:@"3"];
                
                if (range.length != 0) {
                    [self.str deleteCharactersInRange:range];
                }
            }
        }
            break;
        case 5:
        {
            if (sender.selected) {
                [self.str appendFormat:@"%@",@(sender.tag-1)];
            }else{
                NSRange range = [self.str rangeOfString:@"4"];
                
                if (range.length != 0) {
                    [self.str deleteCharactersInRange:range];
                }
            }
        }
            break;
        default:
            break;
    }
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

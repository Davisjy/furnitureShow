//
//  DetailViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/13.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *code;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.code.text = self.codeNum;
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

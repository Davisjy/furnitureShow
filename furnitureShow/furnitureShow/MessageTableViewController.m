//
//  MessageTableViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "MessageTableViewController.h"
#import "Common.h"
#import "AFNetworking.h"
#import "Message.h"
#import "MessageTableViewCell.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"

@interface MessageTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic) int page;
@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = [NSMutableArray array];
    self.page = 1;
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
}

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(self.page);
    parameters[@"pageSize"] = @10;
    
    [manager GET:KMessageUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        NSArray *data = responseObj[@"data"];
        for (NSDictionary *dict in data) {
            Message *message = [Message messageWithDictionary:dict];
            [self.datas addObject:message];
        }
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadMore
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(self.page);
    parameters[@"pageSize"] = @(10);
    
    
    [manager GET:KMessageUrl parameters:parameters success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        NSLog(@"%@",responseObj);
        NSArray *data = responseObj[@"data"];
        for (NSDictionary *dict in data) {
            Message *message = [Message messageWithDictionary:dict];
            [self.datas addObject:message];
        }
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        [self.tableView reloadData];
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.datas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"message" forIndexPath:indexPath];
    
    if (self.datas.count == indexPath.row + 1) {
        self.page ++;
        self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            //上拉刷新
            [self loadMore];
            
            [self.tableView.footer endRefreshing];
        }];
    }
    
    cell.message = self.datas[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *webVC = [sb instantiateViewControllerWithIdentifier:@"web"];
    Message *message = self.datas[indexPath.row];
    [webVC setValue:message.num forKey:@"url"];
    [self.navigationController pushViewController:webVC animated:YES];
}


@end

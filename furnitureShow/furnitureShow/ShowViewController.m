//
//  ShowViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "ShowViewController.h"
#import "AFNetworking.h"
#import "Common.h"
#import "HomeParent.h"
#import "HomeChild.h"
#import "HomeHeaderView.h"

@interface ShowViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchResultsUpdating>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, strong) NSArray *resultArr;
@property (nonatomic) BOOL isSearching;
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _datas = [NSMutableArray array];
    
    [self loadData];
    [self configSearchController];
}

- (void)configSearchController
{
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
}

- (void)loadData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:KHomeUrl parameters:nil success:^ void(AFHTTPRequestOperation * operation, id responseObj) {
        
        NSArray *arr = responseObj[@"parentData"];
        for (NSDictionary *dict in arr) {
            HomeParent *parent = [HomeParent homeParentWithDictionary:dict];
            [self.datas addObject:parent];
        }
        self.resultArr = self.datas;
        [self.tableView reloadData];
        
    } failure:^ void(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@",error);
    }];
}
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - table view dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isSearching) {
        return 1;
    }else{
        return self.datas.count;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isSearching) {
        return self.resultArr.count;
    }
    
    HomeParent *parent = _datas[section];
    if ([parent isOpen]) {
        return parent.child.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    HomeChild *child = nil;
    if (_isSearching) {
        child = self.resultArr[indexPath.row];
    }else{
        HomeParent *parent = self.datas[indexPath.row];
        child = parent.child[indexPath.row];
    }
    
    cell.textLabel.text = child.childName;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isSearching) {
        return 0;
    }
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (_isSearching) {
        return nil;
    }
    HomeHeaderView *headerView = [HomeHeaderView headerViewWithTableView:tableView];
    headerView.parent = _datas[section];
    
    headerView.headerViewClick = ^(){
        [self.tableView reloadData];
    };
    return headerView;
}

#pragma mark - searchVC delegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *filter = self.searchController.searchBar.text;
    if (!filter || filter.length == 0) {
        _isSearching = NO;
        _resultArr = _datas;
    } else {
        _isSearching = YES;
        
        //拿单元格中name跟搜索框中text进行比较
        //单元格里面的数据对应的是QYFriend ，然后拿friend.name跟text相对比
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", filter];
        
        NSArray *resultName = [NSArray array];
        NSMutableArray *titleArr = [NSMutableArray array];
        for (int i = 0; i < self.datas.count ; i ++) {
            HomeParent *parent = self.datas[i];
            for (int k = 0; k < parent.child.count; k ++ ) {
                HomeChild *child = parent.child[k];
                [titleArr addObject:child.childName];
            }
            
        }
        resultName = [titleArr filteredArrayUsingPredicate:predicate];
        
        NSMutableArray *resutlt = [NSMutableArray array];
        for (HomeParent *parent in self.datas) {
            for ( int i = 0; i < parent.child.count; i ++) {
                HomeChild *child = parent.child[i];
                if ([child.childName containsString:searchController.searchBar.text]) {
                    [resutlt addObject:parent.child[i]];
                }
            }
        }
        
        
        _resultArr = resutlt;
    }
    
    [self.tableView reloadData];
}

@end

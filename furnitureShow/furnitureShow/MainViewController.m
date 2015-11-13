//
//  HomeViewController.m
//  furnitureShow
//
//  Created by qingyun on 15/11/12.
//  Copyright (c) 2015年 河南青云信息技术有限公司 &蒋洋. All rights reserved.
//

#import "MainViewController.h"
#import "Common.h"

@interface MainViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //配置基本情况
    [self baseConfig];
}

- (void)baseConfig
{
    self.scrollView.minimumZoomScale = 0.5f;
    self.scrollView.maximumZoomScale = 2.f;
    self.scrollView.delegate = self;
    
    //添加手势
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeLarge:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
}

- (void)changeLarge:(UIGestureRecognizer *)gesture
{
    if (self.scrollView.zoomScale != 1) {
        [self.scrollView setZoomScale:1 animated:YES];
    }else{
        CGPoint location = [gesture locationInView:self.scrollView];
        CGRect rect = CGRectMake(location.x - 100,  location.y - 150, 200, 300);
        [self.scrollView zoomToRect:rect animated:YES];
    }
}

- (IBAction)searchGo:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *resultVC = [sb instantiateViewControllerWithIdentifier:@"firstVC"];
    [self presentViewController:resultVC animated:YES completion:nil];
    
}

- (IBAction)message:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *resultVC = [sb instantiateViewControllerWithIdentifier:@"message"];
    [self presentViewController:resultVC animated:YES completion:nil];
    
}
- (IBAction)regis:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerVC = [sb instantiateViewControllerWithIdentifier:@"register"];
    [self presentViewController:registerVC animated:YES completion:nil];
}
- (IBAction)more:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerVC = [sb instantiateViewControllerWithIdentifier:@"more"];
    [self presentViewController:registerVC animated:YES completion:nil];
}

#pragma mark - scroll view delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end

//
//  ViewController.m
//  Demo
//
//  Created by zhangshaoyu on 17/5/22.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "ViewController.h"
#import "SYNoticeBrowseLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"跑马灯";
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
}

- (void)setUI
{
    // 背景视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, (self.view.frame.size.width - 10.0 * 2), 40.0)];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor yellowColor];
    view.clipsToBounds = YES;
    // 手势响应
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    view.userInteractionEnabled = YES;
    [view addGestureRecognizer:tapRecognizer];
    // 标签视图1
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, view.frame.size.width, view.frame.size.height)];
    [view addSubview:label];
    label.textColor = [UIColor redColor];
    //    label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    label.text = @"iOS devZhang,who from VSTECS";
    // 标签视图2
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width, 0.0, view.frame.size.width, view.frame.size.height)];
    [view addSubview:label2];
    label2.textColor = [UIColor redColor];
    //    label2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    label2.text = @"iOS devZhang,who from VSTECS";
    // 动画
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:8.8f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationRepeatCount:999999];
    
    CGRect frame = label.frame;
    frame.origin.x = -frame.size.width;
    label.frame = frame;
    
    CGRect frame2 = label2.frame;
    frame2.origin.x = 0.0;
    label2.frame = frame2;
    
    [UIView commitAnimations];
}


- (void)tapClick
{
    NSLog(@"click text");
}


@end

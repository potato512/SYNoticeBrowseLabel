//
//  BaseViewController.m
//  Demo
//
//  Created by zhangshaoyu on 2017/8/18.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"跑马灯";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"click" style:UIBarButtonItemStyleDone target:self action:@selector(buttonClick)];
    
    
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

- (void)buttonClick
{
    ViewController *nextVC = [[ViewController alloc] init];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end

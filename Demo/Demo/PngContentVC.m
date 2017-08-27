//
//  PngContentVC.m
//  Demo
//
//  Created by herman on 2017/8/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "PngContentVC.h"
#import "SYNoticeBrowseLabel.h"

@interface PngContentVC ()

@end

@implementation PngContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
    SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 10.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel];
    noticeLabel.tag = 1000;
    noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    noticeLabel.textColor = [UIColor purpleColor];
    noticeLabel.textFont = [UIFont systemFontOfSize:15.0];
    noticeLabel.texts = @[@"自定义跑马灯功能类标签。"];
    noticeLabel.images = @[[UIImage imageNamed:@"face01"], [UIImage imageNamed:@"face02"], [UIImage imageNamed:@"face03"], [UIImage imageNamed:@"face04"], [UIImage imageNamed:@"face05"], [UIImage imageNamed:@"face06"]];
    noticeLabel.textAnimationPauseWhileClick = NO;
    noticeLabel.textClick = ^(){
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击时，动画不受影响。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    };
    [noticeLabel reloadData];
}

@end

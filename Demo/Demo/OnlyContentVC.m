//
//  OnlyContentVC.m
//  Demo
//
//  Created by herman on 2017/8/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "OnlyContentVC.h"
#import "SYNoticeBrowseLabel.h"

@interface OnlyContentVC ()

@end

@implementation OnlyContentVC

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    SYNoticeBrowseLabel *noticeLabel = (SYNoticeBrowseLabel *)[self.view viewWithTag:1000];
    [noticeLabel releaseNotice];
}

- (void)setUI
{
    SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 10.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel];
    noticeLabel.tag = 1000;
    noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    noticeLabel.textColor = [UIColor blackColor];
    noticeLabel.textFont = [UIFont systemFontOfSize:12.0];
    noticeLabel.texts = @[@"自定义跑马灯功能类标签（仅内容）。"];
    noticeLabel.textClick = ^(NSInteger index){
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击时，暂停动画；点击释放时，恢复动画。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    };
    noticeLabel.durationTime = 3.0;
    noticeLabel.delayTime = 3.0;
    [noticeLabel reloadData];
}

@end

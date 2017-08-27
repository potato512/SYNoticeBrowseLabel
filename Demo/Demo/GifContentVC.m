//
//  GifContentVC.m
//  Demo
//
//  Created by herman on 2017/8/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "GifContentVC.h"
#import "SYNoticeBrowseLabel.h"

@interface GifContentVC ()

@end

@implementation GifContentVC

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
    noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    noticeLabel.texts = @[@"106岁老人一年喝200斤包谷酒，唱山歌15分钟停不下来。"];
    noticeLabel.images = @[[UIImage imageNamed:@"face01"]];
    noticeLabel.delayTime = 3.0;
    [noticeLabel reloadData];
}

@end

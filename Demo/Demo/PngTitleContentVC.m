//
//  PngTitleContentVC.m
//  Demo
//
//  Created by herman on 2017/8/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "PngTitleContentVC.h"
#import "SYNoticeBrowseLabel.h"

@interface PngTitleContentVC ()

@end

@implementation PngTitleContentVC

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
    noticeLabel.title = @"直播海南";
    noticeLabel.titleColor = [UIColor brownColor];
    noticeLabel.lineColor = [UIColor redColor];
    noticeLabel.texts = @[@"男子买到过期食品获索赔，刚出超市便遭围殴！店长：我不是第一次看见他了..." ];
    noticeLabel.images = @[[UIImage imageNamed:@"face01"]];
    noticeLabel.delayTime = 3.0;
    [noticeLabel reloadData];
}

@end

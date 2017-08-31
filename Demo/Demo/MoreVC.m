//
//  MoreVC.m
//  Demo
//
//  Created by herman on 2017/8/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "MoreVC.h"
#import "SYNoticeBrowseLabel.h"

@interface MoreVC ()

@end

@implementation MoreVC

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
    NSArray *array = @[@"汽车库存成灾！汽车下乡或将重启，优惠是真的很大，你买账吗？", @"纯粹的车评人", @"男子买到过期食品获索赔，刚出超市便遭围殴！店长：我不是第一次看见他了...", @"自定义跑马灯功能类标签。"];
    
    SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 10.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel];
    noticeLabel.tag = 1000;
    noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    noticeLabel.title = @"纯粹的车评人";
    noticeLabel.texts = array;
    noticeLabel.delayTime = 3.0;
    noticeLabel.durationTime = 3.0;
    noticeLabel.textClick = ^(NSInteger index){
        NSString *text = array[index];
        NSLog(@"text = %@", text);
    };
    noticeLabel.showMoreButton = YES;
    noticeLabel.button.backgroundColor = [UIColor orangeColor];
    noticeLabel.moreClick = ^(UIButton *button){
        [[[UIAlertView alloc] initWithTitle:nil message:@"more button click" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    };
    noticeLabel.browseMode = SYNoticeBrowseVerticalScrollWhileMore;
    [noticeLabel reloadData];
    
    UIView *currentView = noticeLabel;
    
    SYNoticeBrowseLabel *noticeLabel2 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, (currentView.frame.origin.y + currentView.frame.size.height + 10.0), currentView.frame.size.width, currentView.frame.size.height)];
    [self.view addSubview:noticeLabel2];
    noticeLabel2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
    noticeLabel2.texts = array;
    noticeLabel2.delayTime = 3.0;
    noticeLabel2.durationTime = 3.0;
    noticeLabel2.textClick = ^(NSInteger index){
        NSString *text = array[index];
        NSLog(@"text = %@", text);
    };
    noticeLabel2.showMoreButton = YES;
    noticeLabel2.button.backgroundColor = [UIColor orangeColor];
    noticeLabel2.moreClick = ^(UIButton *button){
        [[[UIAlertView alloc] initWithTitle:nil message:@"more button click" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    };
    noticeLabel2.browseMode = SYNoticeBrowseVerticalScrollWhileMore;
    [noticeLabel2 reloadData];
    
    currentView = noticeLabel2;
    
    SYNoticeBrowseLabel *noticeLabel3 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, (currentView.frame.origin.y + currentView.frame.size.height + 10.0), currentView.frame.size.width, currentView.frame.size.height)];
    [self.view addSubview:noticeLabel3];
    noticeLabel3.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    noticeLabel3.texts = array;
    noticeLabel3.images = @[[UIImage imageNamed:@"face01"]];
    noticeLabel3.delayTime = 3.0;
    noticeLabel3.durationTime = 3.0;
    noticeLabel3.textClick = ^(NSInteger index){
        NSString *text = array[index];
        NSLog(@"text = %@", text);
    };
    noticeLabel3.showMoreButton = YES;
    noticeLabel3.button.backgroundColor = [UIColor orangeColor];
    noticeLabel3.moreClick = ^(UIButton *button){
        [[[UIAlertView alloc] initWithTitle:nil message:@"more button click" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    };
    noticeLabel3.browseMode = SYNoticeBrowseVerticalScrollWhileMore;
    [noticeLabel3 reloadData];
    
    currentView = noticeLabel3;
    
    SYNoticeBrowseLabel *noticeLabel4 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, (currentView.frame.origin.y + currentView.frame.size.height + 10.0), currentView.frame.size.width, currentView.frame.size.height)];
    [self.view addSubview:noticeLabel4];
    noticeLabel4.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    noticeLabel4.texts = array;
    noticeLabel4.title = @"车评人";
    noticeLabel4.images = @[[UIImage imageNamed:@"face01"]];
    noticeLabel4.delayTime = 3.0;
    noticeLabel4.durationTime = 3.0;
    noticeLabel4.textClick = ^(NSInteger index){
        NSString *text = array[index];
        NSLog(@"text = %@", text);
    };
    noticeLabel4.showMoreButton = YES;
    noticeLabel4.button.backgroundColor = [UIColor orangeColor];
    noticeLabel4.moreClick = ^(UIButton *button){
        [[[UIAlertView alloc] initWithTitle:nil message:@"more button click" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
    };
    noticeLabel4.browseMode = SYNoticeBrowseVerticalScrollWhileMore;
    [noticeLabel4 reloadData];
}

@end

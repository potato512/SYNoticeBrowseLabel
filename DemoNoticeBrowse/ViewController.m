//
//  ViewController.m
//  DemoNoticeBrowse
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
    
    self.title = @"公告栏";
    
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

    
    
    /****************************/
    
    
    SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 80.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel];
    noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    
    noticeLabel.textColor = [UIColor orangeColor];
    noticeLabel.textFont = [UIFont systemFontOfSize:20.0];
    noticeLabel.text = @"自定义跑马灯功能类标签。";
    noticeLabel.images = @[[UIImage imageNamed:@"header"]];
    noticeLabel.textClick = ^(){
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击时，暂停动画；点击释放时，恢复动画。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    };
    [noticeLabel textAnimation:8.0];
    
    
    SYNoticeBrowseLabel *noticeLabel2 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 140.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel2];
    noticeLabel2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    // 文本颜色
    noticeLabel2.textColor = [UIColor purpleColor];
    // 文本字体
    noticeLabel2.textFont = [UIFont systemFontOfSize:15.0];
    // 文本
    noticeLabel2.text = @"自定义跑马灯功能类标签。";
    // 图标
    noticeLabel2.images = @[[UIImage imageNamed:@"face01"], [UIImage imageNamed:@"face02"], [UIImage imageNamed:@"face03"], [UIImage imageNamed:@"face04"], [UIImage imageNamed:@"face05"], [UIImage imageNamed:@"face06"]];
    // 点击时是否暂停动画（默认不停NO）
    noticeLabel2.textAnimationPauseWhileClick = NO;
    // 文件点击回调
    noticeLabel2.textClick = ^(){
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击时，动画不受影响。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    };
    // 动画
    [noticeLabel2 textAnimation:6.0];
}


- (void)tapClick
{
    NSLog(@"click text");
}

@end

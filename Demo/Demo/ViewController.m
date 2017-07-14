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
    
    
    
    /****************************/
    
    
    SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 80.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel];
    noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    noticeLabel.textColor = [UIColor orangeColor];
    noticeLabel.textFont = [UIFont boldSystemFontOfSize:15.0];
    noticeLabel.text = @"自定义跑马灯功能类标签。";
    noticeLabel.images = @[[UIImage imageNamed:@"header"]];
    noticeLabel.textClick = ^(){
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击时，暂停动画；点击释放时，恢复动画。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    };
    [noticeLabel textAnimation:10.0];
    
    
    SYNoticeBrowseLabel *noticeLabel2 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 140.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel2];
    noticeLabel2.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
    
    noticeLabel2.textColor = [UIColor purpleColor];
    noticeLabel2.textFont = [UIFont systemFontOfSize:15.0];
    noticeLabel2.text = @"自定义跑马灯功能类标签。";
    noticeLabel2.images = @[[UIImage imageNamed:@"face01"], [UIImage imageNamed:@"face02"], [UIImage imageNamed:@"face03"], [UIImage imageNamed:@"face04"], [UIImage imageNamed:@"face05"], [UIImage imageNamed:@"face06"]];
    noticeLabel2.textAnimationPauseWhileClick = NO;
    noticeLabel2.textClick = ^(){
        [[[UIAlertView alloc] initWithTitle:nil message:@"点击时，动画不受影响。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
    };
    [noticeLabel2 textAnimation:2.0];
    
    
    SYNoticeBrowseLabel *noticeLabel3 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 200.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel3];
    noticeLabel3.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    noticeLabel3.text = @"106岁老人一年喝200斤包谷酒，唱山歌15分钟停不下来。";
    noticeLabel3.images = @[[UIImage imageNamed:@"face01"]];
    noticeLabel3.delayTime = 3.0;
    [noticeLabel3 textAnimation:5.0];
    
    
    
    SYNoticeBrowseLabel *noticeLabel4 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 250.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel4];
    noticeLabel4.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    noticeLabel4.title = @"直播海南";
    noticeLabel4.titleColor = [UIColor brownColor];
    noticeLabel4.text = @"男子买到过期食品获索赔，刚出超市便遭围殴！店长：我不是第一次看见他了...";
    noticeLabel4.images = @[[UIImage imageNamed:@"face01"]];
    noticeLabel4.delayTime = 3.0;
    [noticeLabel4 textAnimation:5.0];
    
    
    SYNoticeBrowseLabel *noticeLabel5 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 300.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel5];
    noticeLabel5.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    noticeLabel5.text = @"6月份卖得最烂的SUV都在这里了";
    noticeLabel5.delayTime = 3.0;
    [noticeLabel5 textAnimation:2.0];
    
    
    SYNoticeBrowseLabel *noticeLabel6 = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 350.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
    [self.view addSubview:noticeLabel6];
    noticeLabel6.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.6];
    noticeLabel6.title = @"纯粹的车评人";
    noticeLabel6.text = @"汽车库存成灾！汽车下乡或将重启，优惠是真的很大，你买账吗？";
    noticeLabel6.delayTime = 3.0;
    [noticeLabel6 textAnimation:3.0];
}


- (void)tapClick
{
    NSLog(@"click text");
}


@end

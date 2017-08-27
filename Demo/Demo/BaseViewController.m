//
//  BaseViewController.m
//  Demo
//
//  Created by herman on 2017/8/27.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewController.h"
#import "OnlyContentVC.h"
#import "PngContentVC.h"
#import "GifContentVC.h"
#import "PngTitleContentVC.h"
#import "TitleContentVC.h"
#import "ContentButtonVC.h"
#import "TitleContentButtonVC.h"
#import "PngContentButtonVC.h"
#import "PngTitleContentButtonVC.h"
#import "MoreVC.h"

@interface BaseViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"跑马灯公告栏";
    
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
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.tableFooterView = [UIView new];
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (NSArray *)array
{
    return @[[ViewController class], [OnlyContentVC class], [PngContentVC class], [GifContentVC class], [PngTitleContentVC class], [TitleContentVC class], [ContentButtonVC class], [TitleContentButtonVC class], [PngContentButtonVC class], [PngTitleContentButtonVC class], [MoreVC class]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    Class class = self.array[indexPath.row];
    cell.textLabel.text = NSStringFromClass(class);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Class class = self.array[indexPath.row];
    UIViewController *nextVC = [class new];
    nextVC.title = NSStringFromClass(class);
    [self.navigationController pushViewController:nextVC animated:YES];
}


@end

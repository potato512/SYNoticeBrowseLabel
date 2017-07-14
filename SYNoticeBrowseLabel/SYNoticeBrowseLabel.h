//
//  SYNoticeBrowseLabel.h
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/5/22.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYNoticeBrowseLabel : UIView

/// 禁止使用
- (instancetype)init __attribute__((unavailable("init 方法不可用，请用 initWithName:")));

/// 图标系统
@property (nonatomic, strong) NSArray <UIImage *> *images;

/// 公告标题（默认无）
@property (nonatomic, strong) NSString *title;
/// 公告标题字体大小（默认12.0）
@property (nonatomic, strong) UIFont *titleFont;
/// 公告标题字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *titleColor;

/// 字符
@property (nonatomic, strong) NSString *text;
/// 字体大小（默认13.0）
@property (nonatomic, strong) UIFont *textFont;
/// 字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *textColor;

/// 点击文本响应回调
@property (nonatomic, copy) void (^textClick)(void);

/// 点击文本时是否暂停动画（默认不停NO）
@property (nonatomic, assign) BOOL textAnimationPauseWhileClick;
/// 开始动画（默认8.0）
- (void)textAnimation:(NSTimeInterval)duration;
/// 延迟动画时间（默认0.0）
@property (nonatomic, assign) NSTimeInterval delayTime;

@end

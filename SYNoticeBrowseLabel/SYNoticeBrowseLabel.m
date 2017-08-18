//
//  SYNoticeBrowseLabel.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/5/22.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "SYNoticeBrowseLabel.h"

static CGFloat const originXY = 10.0;

@interface SYNoticeBrowseLabel ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat originLabel;

// 单标题
@property (nonatomic, strong) UILabel *label01;
@property (nonatomic, strong) UILabel *label02;
@property (nonatomic, strong) NSString *text;
// 多标题
@property (nonatomic, strong) UIScrollView *scrollView;


/// 动画时间（默认8.0）
@property (nonatomic, assign) NSTimeInterval textDuration;
/// 动画时间真实计算结果（随字符长度变化）
@property (nonatomic, assign) BOOL isRealDuration;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SYNoticeBrowseLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        
        _titleFont = [UIFont systemFontOfSize:12.0];
        _titleColor = [UIColor blackColor];
        
        _lineColor = [UIColor lightGrayColor];
        
        _textFont = [UIFont systemFontOfSize:12.0];
        _textColor = [UIColor blackColor];
        
        _textAnimationPauseWhileClick = YES;
        
        _textDuration = 8.0;
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"%@--%s", [self class], __func__);
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self textAnimationStop];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self textAnimationStart];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self textAnimationStart];
    
    if (self.textClick)
    {
        self.textClick();
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - methord

- (CGFloat)widthTitle
{
    CGFloat width = self.bgView.frame.size.width;
    CGSize size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    width = (size.width + originXY);
    return width;
}

- (CGFloat)widthText
{
    CGFloat width = self.bgView.frame.size.width;
    CGSize size = [self.label01.text sizeWithAttributes:@{NSFontAttributeName: self.label01.font}];
    width = (width > size.width ? width : (size.width + originXY));
    return width;
}

- (void)reloadData
{
    self.originLabel = 0.0;
    
    // 公告图标
    [self resetUIImage];
    
    // 公告标题
    [self resetUITitle];
    
    self.bgView.frame = CGRectMake(self.originLabel, 0.0, (self.frame.size.width - self.originLabel - (self.images || self.title ? originXY : 0.0)), self.frame.size.height);
    
    // 公告内容
    if (self.texts.count > 1)
    {
        // 多公告内容
        [self resetUIContentMore];
    }
    else if (self.texts.count <= 1)
    {
        // 单公告内容
        [self resetUIContentSingle];
    }
}

#pragma mark - 公共视图

#pragma mark 图标

- (void)resetUIImage
{
    if (self.images && 0 < self.images.count)
    {
        // 位置大小
        self.imageView.frame = CGRectMake(originXY, originXY, (self.frame.size.height - originXY * 2), (self.frame.size.height - originXY * 2));
        [self addSubview:self.imageView];
        
        self.originLabel = self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY;
        
        // 图标
        if (1 >= self.images.count)
        {
            self.imageView.image = self.images.firstObject;
        }
        else
        {
            self.imageView.animationImages = self.images;
            self.imageView.animationDuration = _textDuration * 0.3;
            [self.imageView startAnimating];
        }
    }
}

#pragma mark 标题

- (void)resetUITitle
{
    if (self.title && 0 < self.title.length)
    {
        // 字体大小
        if (_titleFont)
        {
            self.titleLabel.font = _titleFont;
        }
        
        // 字体颜色
        if (_titleColor)
        {
            self.titleLabel.textColor = _titleColor;
        }
        
        // 分割线
        if (_lineColor)
        {
            self.lineView.backgroundColor = _lineColor;
        }
        
        // 位置大小
        // 标题
        self.titleLabel.frame = CGRectMake(self.originLabel, 0.0, self.widthTitle, self.frame.size.height);
        // 分割线
        self.lineView.frame = CGRectMake((self.titleLabel.frame.size.width - 0.5), 10.0, 0.5, (self.titleLabel.frame.size.height - 10.0 * 2));
        
        self.titleLabel.textAlignment = (self.images ? NSTextAlignmentLeft : NSTextAlignmentCenter);
        
        self.originLabel = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + originXY;
        
        // 标题
        self.titleLabel.text = self.title;
    }
}

#pragma mark - 单内容

- (void)resetUIContentSingle
{
    self.text = self.texts.firstObject;
    if (self.text && 0 < self.text.length)
    {
        // 字体大小
        if (_textFont)
        {
            self.label01.font = _textFont;
            self.label02.font = _textFont;
        }
        
        // 字体颜色
        if (_textColor)
        {
            self.label01.textColor = _textColor;
            self.label02.textColor = _textColor;
        }
        
        // 位置大小
        self.label01.frame = CGRectMake(0.0, 0.0, self.widthText, self.bgView.frame.size.height);
        self.label02.frame = CGRectMake(self.widthText, 0.0, self.widthText, self.bgView.frame.size.height);
        
        // 内容
        self.label01.text = self.text;
        self.label02.text = self.text;
    }
}

- (void)textAnimation:(NSTimeInterval)duration
{
    if (!self.isRealDuration)
    {
        _textDuration = (0.0 >= duration ? 8.0 : duration);
        _textDuration = (self.widthText <= self.bgView.frame.size.width ? _textDuration : (_textDuration * (self.widthText / self.bgView.frame.size.width)));
        
        self.isRealDuration = YES;
    }
}

- (void)viewAnimationMove
{
    [UIView animateWithDuration:_textDuration delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        // 位移
        CGRect frame01 = self.label01.frame;
        frame01.origin.x = -frame01.size.width;
        self.label01.frame = frame01;
        
        CGRect frame02 = self.label02.frame;
        frame02.origin.x = 0.0;
        self.label02.frame = frame02;
    } completion:^(BOOL finished) {
        // 恢复原样
        CGRect frame01 = self.label01.frame;
        frame01.origin.x = 0.0;
        self.label01.frame = frame01;
        
        CGRect frame02 = self.label02.frame;
        frame02.origin.x = self.widthText;
        self.label02.frame = frame02;
    }];
}

- (void)textAnimationStart
{
    if (_textAnimationPauseWhileClick)
    {
        [self playlayer:self.label01.layer];
        [self playlayer:self.label02.layer];
    }
}

- (void)textAnimationStop
{
    if (_textAnimationPauseWhileClick)
    {
        [self pauselayer:self.label01.layer];
        [self pauselayer:self.label02.layer];
    }
}

#pragma mark getter

- (UIImageView *)imageView
{
    if (_imageView == nil)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = _titleColor;
        _titleLabel.font = _titleFont;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_titleLabel];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = _lineColor;
        [self.titleLabel addSubview:self.lineView];
    }
    return _titleLabel;
}

- (UILabel *)label01
{
    if (_label01 == nil)
    {
        _label01 = [[UILabel alloc] init];
        _label01.textColor = _textColor;
        _label01.font = _textFont;
        _label01.backgroundColor = [UIColor purpleColor];
        
        [self.bgView addSubview:_label01];
    }
    return _label01;
}

- (UILabel *)label02
{
    if (_label02 == nil)
    {
        _label02 = [[UILabel alloc] init];
        _label02.textColor = _textColor;
        _label02.font = _textFont;
        _label02.backgroundColor = [UIColor brownColor];
        
        [self.bgView addSubview:_label02];
    }
    return _label02;
}

- (UIView *)bgView
{
    if (_bgView == nil)
    {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor greenColor];
        _bgView.clipsToBounds = YES;
        _bgView.layer.masksToBounds = YES;
        
        [self addSubview:_bgView];
    }
    return _bgView;
}

#pragma mark - 多内容

- (void)resetUIContentMore
{
    
}

#pragma mark getter

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

#pragma mark UIScrollViewDelegate



#pragma mark - 定时器

- (void)playAnimation
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_textDuration target:self selector:@selector(viewAnimationMove) userInfo:nil repeats:YES];
}

- (void)releaseNoticeBrowseLabel
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - 动画暂停与继续

- (void)pauselayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

- (void)playlayer:(CALayer *)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}

@end

//
//  SYNoticeBrowseLabel.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 17/5/22.
//  Copyright © 2017年 zhangshaoyu. All rights reserved.
//

#import "SYNoticeBrowseLabel.h"

static CGFloat const originXY = 10.0;

@interface SYNoticeBrowseLabel () <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
// 单条内容
@property (nonatomic, strong) UILabel *label01;
@property (nonatomic, strong) UILabel *label02;
// 多条内容
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, assign) NSInteger textIndex;
//
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat originLabel;

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
    NSLog(@"%@ 被释放了...", [self class]);
}

#pragma mark - 视图

- (void)setUI
{
    if (self.isSingleRow)
    {
        [self resetUISingle];
    }
    else
    {
        [self resetUIMore];
    }
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isSingleRow)
    {
        [self textAnimationStop];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isSingleRow)
    {
        [self textAnimationStart];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isSingleRow)
    {
        [self textAnimationStart];
        
        if (self.textClick)
        {
            self.textClick();
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - getter

- (BOOL)isSingleRow
{
    if (self.texts.count > 1)
    {
        return NO;
    }
    else if (self.texts.count == 1)
    {
        return YES;
    }
    
    return NO;
}

- (CGFloat)widthTitle
{
    CGFloat width = self.bgView.frame.size.width;
    CGSize size = [self.title sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
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

#pragma mark 公共视图

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

- (UIView *)bgView
{
    if (_bgView == nil)
    {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.clipsToBounds = YES;
        _bgView.layer.masksToBounds = YES;
        
        [self addSubview:_bgView];
    }
    return _bgView;
}

#pragma mark 单内容视图

- (UILabel *)label01
{
    if (_label01 == nil)
    {
        _label01 = [[UILabel alloc] init];
        _label01.textColor = _textColor;
        _label01.font = _textFont;
        _label01.backgroundColor = [UIColor clearColor];
        
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
        _label02.backgroundColor = [UIColor clearColor];
        
        [self.bgView addSubview:_label02];
    }
    return _label02;
}

#pragma mark 多内容视图

- (UIScrollView *)scrollView
{
    if (_scrollView == nil)
    {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollEnabled = NO;
        _scrollView.delegate = self;
        
        [self.bgView addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)labelArray
{
    if (_labelArray == nil)
    {
        _labelArray = [[NSMutableArray alloc] init];
    }
    return _labelArray;
}

#pragma mark - setter

- (void)setImages:(NSArray<UIImage *> *)images
{
    _images = images;
    if (_images && 0 < _images.count)
    {
        if (1 >= _images.count)
        {
            self.imageView.image = _images.firstObject;
        }
        else
        {
            self.imageView.animationImages = _images;
            self.imageView.animationDuration = _textDuration * 0.3;
            [self.imageView startAnimating];
        }
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (_title && 0 < _title.length)
    {
        self.titleLabel.text = _title;
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    if (_titleFont)
    {
        self.titleLabel.font = _titleFont;
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    if (_titleColor)
    {
        self.titleLabel.textColor = _titleColor;
    }
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    if (_lineColor)
    {
        self.lineView.backgroundColor = _lineColor;
    }
}

#pragma mark - 多条上滚动

#pragma mark 视图

- (void)resetUIMore
{
    // 清除子视图
    for (UILabel *label in self.labelArray)
    {
        [label removeFromSuperview];
    }
    [self.labelArray removeAllObjects];
    // 添加子视图
    self.textArray = [NSMutableArray arrayWithArray:self.texts];
    [self.textArray addObject:self.texts.firstObject];
    for (NSString *content in self.textArray)
    {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor clearColor];
        // 内容、字体大小、字体颜色
        label.text = content;
        label.font = _textFont;
        label.textColor = _textColor;
        
        [self.scrollView addSubview:label];
        [self.labelArray addObject:label];
    }
    
    
    // 视图
    self.originLabel = 0.0;
    if (self.images)
    {
        self.imageView.frame = CGRectMake(originXY, originXY, (self.frame.size.height - originXY * 2), (self.frame.size.height - originXY * 2));
        [self addSubview:self.imageView];
        
        self.originLabel = self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY;
    }
    
    if (self.title)
    {
        self.titleLabel.frame = CGRectMake(self.originLabel, 0.0, self.widthTitle, self.frame.size.height);
        self.lineView.frame = CGRectMake((self.titleLabel.frame.size.width - 0.5), 10.0, 0.5, (self.titleLabel.frame.size.height - 10.0 * 2));
        
        self.titleLabel.textAlignment = (self.images ? NSTextAlignmentLeft : NSTextAlignmentCenter);
        
        self.originLabel = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + originXY;
    }
    
    self.bgView.frame = CGRectMake(self.originLabel, 0.0, (self.frame.size.width - self.originLabel - (self.images || self.title ? originXY : 0.0)), self.frame.size.height);
    self.scrollView.frame = self.bgView.bounds;
    int index = 0;
    for (UILabel *label in self.labelArray)
    {
        label.frame = CGRectMake(0.0, (index * self.scrollView.frame.size.height), self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        index++;
    }
}

#pragma mark 动画

- (void)viewAnimationMoveMoreRow
{
    [self.scrollView setContentOffset:CGPointMake(0.0, (self.textIndex * self.scrollView.frame.size.height)) animated:YES];
    self.textIndex++;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (self.textIndex >= self.textArray.count - 1)
    {
        self.textIndex = 1;
        [self.scrollView setContentOffset:CGPointZero animated:NO];
    }
}

#pragma mark - 单条左滚动

#pragma mark 视图

- (void)resetUISingle
{
    // 内容
    self.label01.text = _texts.firstObject;
    self.label02.text = _texts.firstObject;
    // 内容字体大小
    self.label01.font = _textFont;
    self.label02.font = _textFont;
    // 内容字体颜色
    self.label01.textColor = _textColor;
    self.label02.textColor = _textColor;
    
    
    // 视图
    self.originLabel = 0.0;
    if (self.images)
    {
        self.imageView.frame = CGRectMake(originXY, originXY, (self.frame.size.height - originXY * 2), (self.frame.size.height - originXY * 2));
        [self addSubview:self.imageView];
        
        self.originLabel = self.imageView.frame.origin.x + self.imageView.frame.size.width + originXY;
    }
    
    if (self.title)
    {
        self.titleLabel.frame = CGRectMake(self.originLabel, 0.0, self.widthTitle, self.frame.size.height);
        self.lineView.frame = CGRectMake((self.titleLabel.frame.size.width - 0.5), 10.0, 0.5, (self.titleLabel.frame.size.height - 10.0 * 2));
        
        self.titleLabel.textAlignment = (self.images ? NSTextAlignmentLeft : NSTextAlignmentCenter);
        
        self.originLabel = self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width + originXY;
    }
    
    self.bgView.frame = CGRectMake(self.originLabel, 0.0, (self.frame.size.width - self.originLabel - (self.images || self.title ? originXY : 0.0)), self.frame.size.height);
    self.label01.frame = CGRectMake(0.0, 0.0, self.widthText, self.bgView.frame.size.height);
    self.label02.frame = CGRectMake(self.widthText, 0.0, self.widthText, self.bgView.frame.size.height);
}

#pragma mark 动画

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

- (void)viewAnimationMoveSingleRow
{
    NSLog(@"timer run...");
    
    [UIView animateWithDuration:_textDuration delay:_delayTime options:UIViewAnimationOptionCurveLinear animations:^{
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
    
    /*
     [UIView beginAnimations:@"testAnimation" context:NULL];
     [UIView setAnimationDuration:_textDuration];
     [UIView setAnimationDelay:_delayTime];
     [UIView setAnimationCurve:UIViewAnimationCurveLinear];
     [UIView setAnimationRepeatCount:999999];
     //
     CGRect frame = _label01.frame;
     frame.origin.x = -frame.size.width;
     _label01.frame = frame;
     //
     CGRect frame2 = _label02.frame;
     frame2.origin.x = 0.0;
     _label02.frame = frame2;
     //
     [UIView commitAnimations];
     */
}

#pragma mark - 定时器

- (void)startTimer
{
    SEL selector = (self.isSingleRow ? @selector(viewAnimationMoveSingleRow) : @selector(viewAnimationMoveMoreRow));
    NSTimeInterval time = (self.isSingleRow ? (_textDuration + _delayTime) : _textDuration);
    
    self.timer = [NSTimer timerWithTimeInterval:time target:self selector:selector userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [self.timer fire]; // 启动
    
    NSLog(@"timer start...");
}

- (void)stopTimer
{
    if (self.timer)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    NSLog(@"timer end...");
}

- (void)releaseNotice
{
    [self stopTimer];
}

#pragma mark - 刷新

- (void)textAnimation:(NSTimeInterval)duration
{
    if (!self.isRealDuration)
    {
        _textDuration = (0.0 >= duration ? 8.0 : duration);
        if (self.widthText <= self.bgView.frame.size.width)
        {
            
        }
        else
        {
            CGFloat scale = (self.widthText / self.bgView.frame.size.width);
            _textDuration = (_textDuration * scale);
        }
        
        self.isRealDuration = YES;
    }
}

- (void)reloadData
{
    [self setUI];
    
    [self textAnimation:_durationTime];
    
    [self startTimer];
}

@end

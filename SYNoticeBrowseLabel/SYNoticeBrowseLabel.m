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
@property (nonatomic, strong) UILabel *label01;
@property (nonatomic, strong) UILabel *label02;

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat originLabel;

/// 动画时间（默认8.0）
@property (nonatomic, assign) NSTimeInterval textDuration;
/// 动画时间真实计算结果（随字符长度变化）
@property (nonatomic, assign) BOOL isRealDuration;

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

#pragma mark - 视图

- (void)resetUI
{
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

#pragma mark - getter

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
        
        [self resetUI];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (_title && 0 < _title.length)
    {
        self.titleLabel.text = _title;
        
        [self resetUI];
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

- (void)setText:(NSString *)text
{
    _text = text;
    if (_text && 0 < _text.length)
    {
        self.label01.text = _text;
        self.label02.text = _text;
        
        [self resetUI];
    }
}

- (void)setTextFont:(UIFont *)textFont
{
    _textFont = textFont;
    if (_textFont)
    {
        self.label01.font = _textFont;
        self.label02.font = _textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    if (_textColor)
    {
        self.label01.textColor = _textColor;
        self.label02.textColor = _textColor;
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

- (void)textAnimation:(NSTimeInterval)duration
{
    if (!self.isRealDuration)
    {
        _textDuration = (0.0 >= duration ? 8.0 : duration);
        _textDuration = (self.widthText <= self.bgView.frame.size.width ? _textDuration : (_textDuration * (self.widthText / self.bgView.frame.size.width)));
        
        self.isRealDuration = YES;
    }
    
    // 动画执行
    [self performSelector:@selector(viewAnimationMove)];
}

- (void)viewAnimationMove
{
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
        
        // 重复执行
        [self performSelector:@selector(viewAnimationMove)];
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

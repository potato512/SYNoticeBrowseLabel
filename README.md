# SYNoticeBrowseLabel
跑马灯功能类标签。

![SYNoticeBrowseLabel.gif](./SYNoticeBrowseLabel.gif)

#### 使用示例

~~~ javascript
// 导入头文件
#import "SYNoticeBrowseLabel.h"
~~~ 

~~~ javascript
// 实例化
SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 10.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
[self.view addSubview:noticeLabel2];
noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
~~~ 

~~~ javascript
// 文本颜色
noticeLabel.textColor = [UIColor purpleColor];

// 文本字体
noticeLabel.textFont = [UIFont systemFontOfSize:15.0];

// 文本
noticeLabel.text = @"自定义跑马灯功能类标签。";
~~~ 

~~~ javascript
// 图标
noticeLabel.images = @[[UIImage imageNamed:@"face01"], [UIImage imageNamed:@"face02"], [UIImage imageNamed:@"face03"], [UIImage imageNamed:@"face04"], [UIImage imageNamed:@"face05"], [UIImage imageNamed:@"face06"]];
~~~ 

~~~ javascript
// 标题
noticeLabel.title = @"公告";

// 标题字体颜色
noticeLabel.titleColor = [UIColor brownColor];

// 标题字体大小
noticeLabel.titleFont = [UIFont systemFontOfSize:12.0];
~~~ 

~~~ javascript
// 标题与内容分割线颜色
noticeLabel.lineColor = [UIColor purpleColor];
~~~ 

~~~ javascript
// 点击时是否暂停动画（默认不停NO）
noticeLabel.textAnimationPauseWhileClick = NO;

// 文件点击回调
noticeLabel.textClick = ^(){
[[[UIAlertView alloc] initWithTitle:nil message:@"点击时，动画不受影响。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
};
~~~ 

~~~ javascript
// 延迟时间
noticeLabel.delayTime = 2.0;

// 动画
[noticeLabel textAnimation:6.0];
~~~ 

~~~ javascript

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (SYNoticeBrowseLabel *label in self.array)
    {
        [label releaseNoticeBrowseLabel];
    }
}

~~~ 



#### 变更记录
* 20170818——待完成
  * 版本号：2.0.0
  * 优化方法：循环播放的实现由递归修改成定时器触发
    * 注意：内存释放，避免定时器造成内存泄露。
  * 添加按钮属性：类似于更多
    * 自定义标题
    * 自定义图标
    * 自定义样式
    * 自定义交互响应
  
* 20170726 
  * 版本号：1.1.1
  * 修改动画调用方法

* 20170714 
  * 版本号：1.1.0
  * 优化图标显示
  * 添加公告标题设置属性

~~~ javascript
/// 公告标题（默认无）
@property (nonatomic, strong) NSString *title;
/// 公告标题字体大小（默认12.0）
@property (nonatomic, strong) UIFont *titleFont;
/// 公告标题字体颜色（默认黑色）
@property (nonatomic, strong) UIColor *titleColor;

/// 公告标题与内容分割线颜色（默认灰色，当且公当公告标题存在时才有效）
@property (nonatomic, strong) UIColor *lineColor;
~~~


* 20170605 
  * 动画时间随字符设置长度自适应，避免相同的动画时间，字符长度越长时，动画越快。

* 20170524 
  * 版本号：0.0.2
  * 添加延迟动画属性
  * 修改适配任意长度的文本显示

~~~ javascript
/// 延迟动画时间（默认0.0）
@property (nonatomic, assign) NSTimeInterval delayTime;
~~~


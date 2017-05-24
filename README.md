# SYNoticeBrowseLabel
跑马灯功能类标签。

![SYNoticeBrowseLabel.gif](./SYNoticeBrowseLabel.gif)

#### 使用示例
~~~ javascript
// 导入头文件
#import "SYNoticeBrowseLabel.h"

// 实例化
SYNoticeBrowseLabel *noticeLabel = [[SYNoticeBrowseLabel alloc] initWithFrame:CGRectMake(10.0, 10.0, (self.view.frame.size.width - 10.0 * 2), 30.0)];
[self.view addSubview:noticeLabel2];
noticeLabel.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.3];
// 文本颜色
noticeLabel.textColor = [UIColor purpleColor];
// 文本字体
noticeLabel.textFont = [UIFont systemFontOfSize:15.0];
// 文本
noticeLabel.text = @"自定义跑马灯功能类标签。";
// 图标
noticeLabel.images = @[[UIImage imageNamed:@"face01"], [UIImage imageNamed:@"face02"], [UIImage imageNamed:@"face03"], [UIImage imageNamed:@"face04"], [UIImage imageNamed:@"face05"], [UIImage imageNamed:@"face06"]];
// 点击时是否暂停动画（默认不停NO）
noticeLabel.textAnimationPauseWhileClick = NO;
// 文件点击回调
noticeLabel.textClick = ^(){
[[[UIAlertView alloc] initWithTitle:nil message:@"点击时，动画不受影响。" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
};
// 延迟时间
noticeLabel.delayTime = 2.0;
// 动画
[noticeLabel textAnimation:6.0];
~~~


#### 变更记录
* 20170524
  * 添加延迟动画属性
~~~ javascript
/// 延迟动画时间（默认0.0）
@property (nonatomic, assign) NSTimeInterval delayTime;
~~~
  * 修改适配任意长度的文本显示


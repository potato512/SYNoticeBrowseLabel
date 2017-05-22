# SYNoticeBrowseLabel
跑车灯功能类标签。

![SYNoticeBrowseLabel.gif](./SYNoticeBrowseLabel.gif)

#### 使用示例
~~~ javascript
// 导入头文件
#import "SYNoticeBrowseLabel.h"

// 实例化
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
~~~


# ZoePresentVCAnimation
![](https://img.shields.io/badge/Title-ZoePresentVCAnimation-7f62b4.svg)
![](https://img.shields.io/badge/Author-Zoe-ff62b4.svg)

##关键词
**跳转**、**图片变大**、**弹出**、**presentViewController**
##怎么用
引入`ZoeTransition`并在需要此动画的ViewController里添加`<UIViewControllerTransitioningDelegate>`，协议的实现如下：
```
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    self.transition.originFrame = [self.selectedImage.superview convertRect:self.selectedImage.frame toView:nil];//求出位置大小
    self.transition.presenting = YES; //present YES   dismiss NO
    self.selectedImage.hidden = YES;
    self.transition.duration = @0.5;
    return self.transition;
    
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    self.transition.presenting = NO;
    return self.transition;
}
```

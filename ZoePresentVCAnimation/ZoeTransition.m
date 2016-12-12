//
//  ZoeTransition.m
//  ZoePresentVCAnimation
//
//  Created by mac on 2016/12/6.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ZoeTransition.h"

@implementation ZoeTransition


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return _duration.doubleValue;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView * containerView = transitionContext.containerView; //获得容器
    UIView * toView = [transitionContext viewForKey:UITransitionContextToViewKey]; //获得将要到达VC的view
    UIView * fromView = [transitionContext viewForKey:UITransitionContextFromViewKey]; //即将消失的VC的View
    UIView * mainView = _presenting ? toView : fromView; //始终要拿到ImageViewController的view
    CGRect initialRect = _presenting ? _originFrame: mainView.frame;
    CGRect finalRect = (!_presenting) ? _originFrame: mainView.frame;
    CGFloat xScaleFactor = _presenting ? initialRect.size.width / finalRect.size.width : finalRect.size.width / initialRect.size.width;
    CGFloat yScaleFactor = _presenting ? initialRect.size.height / finalRect.size.height : finalRect.size.height / initialRect.size.height;
    //缩放比例
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);

    if (_presenting) {
        mainView.transform = scaleTransform;
        mainView.center = CGPointMake( CGRectGetMidX(initialRect),  CGRectGetMidY(initialRect));
        mainView.clipsToBounds = true;
        //从拿到的view中心进行缩放
    }
    
    [containerView addSubview:toView];
    [containerView bringSubviewToFront:mainView];
    [UIView animateWithDuration:_duration.floatValue delay:0.0f usingSpringWithDamping:1 initialSpringVelocity:0.0f options:UIViewAnimationOptionLayoutSubviews animations:^{
    mainView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform;
    mainView.center = CGPointMake(CGRectGetMidX(finalRect), CGRectGetMidY(finalRect));
    //动画进行缩放
    } completion:^(BOOL finished) {
    if (!self.presenting) {
        self.dissmissBlock();
                }
    [transitionContext completeTransition:YES];
    }];    

}
@end

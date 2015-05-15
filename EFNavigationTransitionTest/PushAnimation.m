//
//  PushAnimation.m
//  EFNavigationTransitionTest
//
//  Created by JingXu on 15/5/8.
//  Copyright (c) 2015年 JingXu. All rights reserved.
//

#import "PushAnimation.h"

@implementation PushAnimation
//返回动画持续时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //获取起点controller
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //获取终点controller
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取转场容器视图
    UIView *containerView = [transitionContext containerView];
    
    
    
    /**
     *   app ping 的动画效果
     */
    self.transitionContext = transitionContext;
    [containerView addSubview:fromVC.view];
    [containerView addSubview:toVC.view];
    
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 100, 100, 60)];
    
    CGPoint finalPoint = CGPointMake(100 - 0, 130 - CGRectGetMaxY(toVC.view.bounds));
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(50, 100, 100, 60), -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskFinalBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    toVC.view.layer.mask = maskLayer;
    
    //创建一个关于 path 的 CABasicAnimation 动画来从 circleMaskPathInitial.CGPath 到 circleMaskPathFinal.CGPath 。同时指定它的 delegate 来在完成动画时做一些清除工作
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskStartBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskFinalBP.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];

    /*
    //设置终点视图的frame
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    CGRect offScreenFrame = frame;
    //先将其设置到屏幕外边，通过动画进入
    offScreenFrame.origin.x = offScreenFrame.size.width;
    toVC.view.frame = offScreenFrame;
    
    //添加视图
    [containerView addSubview:toVC.view];
    
    //执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //设置缩放和透明度CGAffineTransformMakeScale(0.8, 0.8)
        fromVC.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        fromVC.view.alpha = 0.5;
        //设置位置
        toVC.view.frame = frame;
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
//        fromVC.view.frame = [UIScreen mainScreen].bounds;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
     */
    
}

#pragma mark - CABasicAnimation的Delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    //告诉 iOS 这个 transition 完成
    [self.transitionContext completeTransition:![self. transitionContext transitionWasCancelled]];
    //清除 fromVC 的 mask
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}
@end

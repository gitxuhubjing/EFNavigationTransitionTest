//
//  PopAnimation.m
//  EFNavigationTransitionTest
//
//  Created by JingXu on 15/5/8.
//  Copyright (c) 2015年 JingXu. All rights reserved.
//

#import "PopAnimation.h"

@implementation PopAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
    /**
     *   app ping 的动画效果
     */
    self.transitionContext = transitionContext;
    [containerView addSubview:toVC.view];
    [containerView addSubview:fromVC.view];
    UIBezierPath *maskStartBP = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 130, 1, 1)];
    
    CGPoint finalPoint = CGPointMake(100 - 0, 130 - CGRectGetMaxY(toVC.view.bounds));
    CGFloat radius = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y * finalPoint.y));
    UIBezierPath *maskFinalBP = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(CGRectMake(50, 100, 100, 60), -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = maskStartBP.CGPath; //将它的 path 指定为最终的 path 来避免在动画完成后会回弹
    fromVC.view.layer.mask = maskLayer;
    
    //创建一个关于 path 的 CABasicAnimation 动画来从 circleMaskPathInitial.CGPath 到 circleMaskPathFinal.CGPath 。同时指定它的 delegate 来在完成动画时做一些清除工作
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(maskFinalBP.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((maskStartBP.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
//    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
    
    
    
    
    /**

//    CGAffineTransformMakeScale(0.8, 0.8)
    toVC.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
    toVC.view.alpha = 0.5;
    CGRect frame = [transitionContext initialFrameForViewController:fromVC];
    CGRect offScreenFrame = frame;
    offScreenFrame.origin.x = offScreenFrame.size.width;
    
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
        toVC.view.alpha = 1.0f;
        fromVC.view.frame = offScreenFrame;
    } completion:^(BOOL finished) {
        fromVC.view.transform = CGAffineTransformIdentity;
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

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
    return 0.3f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = [transitionContext containerView];
    
//    CGAffineTransformMakeScale(0.8, 0.8)
    toVC.view.transform = CGAffineTransformIdentity;
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
}

@end

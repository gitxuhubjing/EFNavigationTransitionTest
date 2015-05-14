//
//  NavigationControllerDelegate.m
//  NavigationTransitionController
//
//  Created by Chris Eidhof on 09.10.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import "SubNavigationController.h"
#import "PushAnimation.h"
#import "PopAnimation.h"

@interface SubNavigationController ()

@property (strong, nonatomic) PushAnimation* pushanimator;
@property (strong, nonatomic) PopAnimation *popanimator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;
@property (strong, nonatomic) UIPanGestureRecognizer* panRecognizer;

@end

@implementation SubNavigationController

//- (void)awakeFromNib
//{
//    UIPanGestureRecognizer* panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//    [self.navigationController.view addGestureRecognizer:panRecognizer];
//    
//    self.animator = [Animator new];
//}
-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self.view addGestureRecognizer:_panRecognizer];
        self.pushanimator = [PushAnimation new];
        self.popanimator = [PopAnimation new];
        self.delegate = self;//**设置UINavigation的代理
    }
    return self;
}

- (void)pan:(UIPanGestureRecognizer*)recognizer
{
    UIView* view = self.view;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:view];
        if (location.x <  CGRectGetMidX(view.bounds) && self.viewControllers.count > 1) { // left half
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
            [self popViewControllerAnimated:YES];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [recognizer translationInView:view];
        CGFloat d = fabs(translation.x / CGRectGetWidth(view.bounds));
        [self.interactionController updateInteractiveTransition:d];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        if ([recognizer velocityInView:view].x > 0) {
            [self.interactionController finishInteractiveTransition];
        } else {
            [self.interactionController cancelInteractiveTransition];
        }
        self.interactionController = nil;
    }
}
/**
 *  这是UINavigationController 的代理实现，在这里调用我们自定义的动画转场过程
 *
 */

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop) {
        return self.popanimator;
    }
    if (operation == UINavigationControllerOperationPush) {
        return self.pushanimator;
    }
    return nil;
}


- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}


/**
 *  下面两个方法与转场无关，只是在转场动画正在进行的时候滑动手势容易导致程序crash,在动画进行的过程中禁用滑动手势
 *  thank sam from stackoverflow 
 *  http://stackoverflow.com/questions/22045098/didshowviewcontroller-not-being-called-after-viewdidappear
 *
 */

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // fix 'nested pop animation can result in corrupted navigation bar'
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
        [self.view removeGestureRecognizer:_panRecognizer];
    }
    
    [super pushViewController:viewController animated:animated];
}


- (void)navigationController:(UINavigationController *)navigationController
       didShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.view addGestureRecognizer:_panRecognizer];
    }
}



@end

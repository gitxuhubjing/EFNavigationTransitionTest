//
//  PushAnimation.h
//  EFNavigationTransitionTest
//
//  Created by JingXu on 15/5/8.
//  Copyright (c) 2015年 JingXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  继承的是UIViewControllerAnimatedTransitioning，负责切换的具体内容，就是切换中应该发生什么，自定义效果就写在了这个接口里
 */
@interface PushAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property(nonatomic,strong)id<UIViewControllerContextTransitioning>transitionContext;

@end

//
//  NavigationControllerDelegate.h
//  NavigationTransitionController
//
//  Created by Chris Eidhof on 09.10.13.
//  Copyright (c) 2013 Chris Eidhof. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SubNavigationController : UINavigationController <UINavigationControllerDelegate>
-(id)initWithRootViewController:(UIViewController *)rootViewController;
@end

//
//  ViewController.m
//  EFNavigationTransitionTest
//
//  Created by JingXu on 15/5/8.
//  Copyright (c) 2015年 JingXu. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1];
    UIButton *pushbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    pushbutton.frame = CGRectMake(50, 100, 100, 60);
    [pushbutton setTitle:@"push" forState:UIControlStateNormal];
    [pushbutton addTarget:self action:@selector(pushbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushbutton];
}

-(void)pushbuttonClick{
    ViewController1 *viewcontroller1 = [[ViewController1 alloc] init];
    [self.navigationController pushViewController:viewcontroller1 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

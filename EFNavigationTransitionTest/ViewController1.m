//
//  ViewController1.m
//  EFNavigationTransitionTest
//
//  Created by JingXu on 15/5/8.
//  Copyright (c) 2015年 JingXu. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1];
    UIButton *popbutton = [UIButton buttonWithType:UIButtonTypeSystem];
    popbutton.frame = CGRectMake(50, 100, 100, 60);
    [popbutton setTitle:@"pop" forState:UIControlStateNormal];
    [popbutton addTarget:self action:@selector(popbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:popbutton];
}

-(void)popbuttonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

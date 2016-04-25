//
//  CenterViewController.m
//  twlSlide
//
//  Created by 孙云 on 16/4/25.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "CenterViewController.h"
#import "TestVC.h"
@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)changeVC{

    TestVC *test = [[TestVC alloc]init];
    [self.navigationController pushViewController:test animated:YES];
    NSLog(@"111");
}

@end

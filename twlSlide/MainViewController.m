//
//  ViewController.m
//  twlSlide
//
//  Created by 孙云 on 16/4/25.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "MainViewController.h"
#import "CenterViewController.h"
#import "SecVC.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{

    CenterViewController *centerVC;
    UIView *topView;
    SecVC *secVC;
    UINavigationController *nav1;
    UINavigationController *nav2;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景图
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgImage.jpg"]];
    _array = @[@"我是张三",@"我是李四"];
    [self setTableView];
    //设置上蹭视图
    centerVC  = [[CenterViewController alloc]init];
    nav1 = [[UINavigationController alloc]initWithRootViewController:centerVC];
    secVC = [[SecVC alloc]init];
    nav2 = [[UINavigationController alloc]initWithRootViewController:secVC];
    [self setTopView:nav1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  设置上蹭视图
 */
- (void)setTopView:(UINavigationController *)VC{

    //把之前偏移的位置跳回原处
        topView.transform = CGAffineTransformIdentity;
        topView.frame = self.view.bounds;
    //先去除topview
    if (topView) {
        [topView removeFromSuperview];
    }
    
    topView = VC.view;
    [self.view addSubview:topView];
    
    //加载一个手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panPoint:)];
    UIView *panView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, 20, self.view.frame.size.height)];
    [VC.view addSubview:panView];
    [VC.view bringSubviewToFront:panView];
    [panView addGestureRecognizer:pan];
    
}
/**
 *  拖拽手势
 *
 *  @param sender <#sender description#>
 */
- (void)panPoint:(UIPanGestureRecognizer *)sender{

    CGPoint point = [sender locationInView:self.view];
    if (point.x <= self.view.frame.size.width * 2 / 3) {
        [UIView animateWithDuration:0.1 animations:^{
            
            CGFloat scale = 1 -point.x / self.view.frame.size.width;
            if (scale <= 0.5) {
                scale = 0.5;
            }
            topView.transform = CGAffineTransformMakeScale(scale,scale);
            
            CGRect rect = topView.frame;
            rect.origin.x = point.x;
            topView.frame = rect;
            
        }];
    }

    //判断在手势结束的时候的状态
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.2 animations:^{
           
            if (point.x >= self.view.frame.size.width / 3) {
                
                CGRect rect = topView.frame;
                rect.origin.x = self.view.frame.size.width * 1/ 2;
                topView.frame = rect;
                CGFloat scale = 0.5;
                if (scale <= 0.5) {
                    scale = 0.5;
                }
                topView.transform = CGAffineTransformMakeScale(scale,scale);
            }else{
                
                topView.transform = CGAffineTransformIdentity;
                CGRect rect = topView.frame;
                rect.origin.x = 0;
                topView.frame = rect;
                
                
            }
        }];
        
    }
}
#pragma mark--------表
/**
 *  创建表
 */
- (void)setTableView{

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, 100, 199)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:nil];
    cell.textLabel.text = _array[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:

                [self setTopView:nav1];

            
            break;
        case 1:
            

                [self setTopView:nav2];

            
        default:
            break;
    }
}
@end

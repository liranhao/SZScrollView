//
//  ViewController.m
//  SZScrollView
//
//  Created by 李然豪 on 17/3/2.
//  Copyright © 2017年 liranhao. All rights reserved.
//

#import "ViewController.h"
#import "SZScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SZScrollView *scrollView = [[SZScrollView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    NSArray *arr = [NSArray arrayWithObjects:@"banner1",@"banner2",@"banner1", nil];
    
    [scrollView createHeadView:arr];
    [self.view addSubview:scrollView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  RemindViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RemindViewController.h"

@interface RemindViewController ()

@end

@implementation RemindViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提醒";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end

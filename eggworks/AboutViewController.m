//
//  AboutViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/7.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于盘算";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    UILabel * company =  [[[UILabel alloc] initWithFrame:CGRectMake(0, kScreenHeight - 60, kScreenWidth, 30)] autorelease];
    company.text = @"版权所有 上海采旦金融信息服务有限公司";
    company.textAlignment = NSTextAlignmentCenter;
    company.font = [UIFont systemFontOfSize:14];
    company.textColor = title_text_color;
    [self.view addSubview:company];
    
    
    UIImageView * icon = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"114"]] autorelease];
    icon.frame = CGRectMake((kScreenWidth-72)/2, ios7_d_height + 60, 72, 72);
    [self.view addSubview:icon];
    
    
    //介绍
    UILabel * introduction =  [[[UILabel alloc] initWithFrame:CGRectMake(0, ios7_d_height+147, kScreenWidth, 30)] autorelease];
    introduction.text = @"您的随身财富助手";
    introduction.textAlignment = NSTextAlignmentCenter;
    introduction.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    introduction.textColor = [UIColor colorWithRed:.84 green:.15 blue:.18 alpha:1];
    [self.view addSubview:introduction];
    
    //版本
    UILabel * version =  [[[UILabel alloc] initWithFrame:CGRectMake(0, ios7_d_height+185, kScreenWidth, 30)] autorelease];
    version.text = @"IOS版 1.0.0";
    version.textAlignment = NSTextAlignmentCenter;
    version.font = [UIFont systemFontOfSize:14];
    version.textColor = title_text_color;
    [self.view addSubview:version];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}


@end

//
//  firstViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "firstViewController.h"
#import "IndexPageViewController.h"
#import "AppDelegate.h"
#import "ActivateChannelViewController.h"
#import "SelfHelpBuyViewController.h"
#import "CountdownButton.h"

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton * cancelBtn = [[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 20, 40, 40)] autorelease];
    [cancelBtn setImage:[UIImage imageNamed:@"cancel_btn_bg"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)cancelBtnClick:(id)sender
{
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    IndexPageViewController * indexPageViewController = [[[IndexPageViewController alloc] init] autorelease];
    UINavigationController * rootView = [[[UINavigationController alloc] initWithRootViewController:indexPageViewController] autorelease];
    delegate.window.rootViewController = rootView;
}

//无忧卡激活通道 按钮点击
-(void)easyCardActivationBtnClick:(id)sender
{
    NSLog(@"无忧卡激活通道");
    ActivateChannelViewController * activateChannelVC = [[[ActivateChannelViewController alloc] init] autorelease];
    [self.navigationController pushViewController:activateChannelVC animated:YES];
}



//自助购买通道 按钮点击
-(void)selfHelpBuyBtnClick:(id)sender
{
    NSLog(@"自助购买通道");
    SelfHelpBuyViewController * selfHelpBuyVC = [[[SelfHelpBuyViewController alloc] init] autorelease];
    [self.navigationController pushViewController:selfHelpBuyVC animated:YES];
}
@end

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
#import "LoginViewController.h"

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    if (IPhone5) {
        self.indexImg.frame = CGRectMake(0, 65, 320, 385);
        self.indexImg.image = [UIImage imageNamed:@"first_ip5"];
        
        UIView * temp = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 50)] autorelease];
        temp.backgroundColor = [UIColor colorWithRed:.23 green:.69 blue:.87 alpha:1];
        [self.view addSubview:temp];
    } else {
        UIView * temp = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 40)] autorelease];
        temp.backgroundColor = [UIColor colorWithRed:.23 green:.69 blue:.87 alpha:1];
        [self.view addSubview:temp];
        
        self.indexImg.frame = CGRectMake(0, 50, 320, 310);
        self.indexImg.image = [UIImage imageNamed:@"mobile_phone_index_has_nav_iphone4"];
    }
    
    
    
    
    UIButton * cancelBtn = [[[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 30, 40, 40)] autorelease];
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

-(void)loginBtnClick:(id)sender
{
    NSLog(@"登录");
    LoginViewController * loginVC = [[[LoginViewController alloc] init] autorelease];
    [self.navigationController pushViewController:loginVC animated:YES];
}
@end

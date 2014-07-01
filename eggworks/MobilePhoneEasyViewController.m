//
//  MobilePhoneEasyViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MobilePhoneEasyViewController.h"
#import "ActivateChannelViewController.h"
#import "SelfHelpBuyViewController.h"
#import "LoginViewController.h"

@interface MobilePhoneEasyViewController ()

@end

@implementation MobilePhoneEasyViewController

@synthesize indexImg = _indexImg;

- (void)dealloc
{
    [_indexImg release]; _indexImg = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"手机无忧";
    
    float applicationHeight = kApplicationHeight;
    applicationHeight -= 40;
    float ios7_d_height = 0;
    
    if (IOS7) {
        applicationHeight += 60;
        ios7_d_height = IOS7_HEIGHT;
    }
   
    //无忧卡激活通道按钮
    UIButton * easyCardActivationBtn = [[[UIButton alloc] initWithFrame:CGRectMake(15, applicationHeight-110, 290, 47)] autorelease];
    [easyCardActivationBtn setBackgroundImage:[UIImage imageNamed:@"gray_btn_bg"] forState:UIControlStateNormal];
//    [easyCardActivationBtn setTitle:@"激活" forState:UIControlStateNormal];
    [easyCardActivationBtn setTitleColor:[UIColor colorWithRed:.99 green:.41 blue:.31 alpha:1] forState:UIControlStateNormal];
    [easyCardActivationBtn addTarget:self action:@selector(easyCardActivationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:easyCardActivationBtn];
    
    //登录
    UIButton * loginBtn = [[[UIButton alloc] initWithFrame:CGRectMake(15, applicationHeight-55, 144.5, 47)] autorelease];
//    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //自助购买通道
    UIButton * selfHelpBuyBtn = [[[UIButton alloc] initWithFrame:CGRectMake(161, applicationHeight-55, 144.5, 47)] autorelease];
//    [selfHelpBuyBtn setTitle:@"购买" forState:UIControlStateNormal];
    [selfHelpBuyBtn setBackgroundImage:[UIImage imageNamed:@"buy"] forState:UIControlStateNormal];
    [selfHelpBuyBtn addTarget:self action:@selector(selfHelpBuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selfHelpBuyBtn];
    
//    phone_easy_iphone4s@2x
    
    if (IPhone5) {
        self.indexImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_easy_index_have_no_nav_iphone5"]] autorelease];
        _indexImg.frame = CGRectMake(0, 0+ios7_d_height-10, 320, 398);
    } else{
        self.indexImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_phone_index_has_nav_iphone4"]] autorelease];
        _indexImg.frame = CGRectMake(0, 0+ios7_d_height-10, 320, 310);
    }
    [self.view addSubview:_indexImg];
}

//无忧卡激活通道 按钮点击
-(void)easyCardActivationBtnClick:(id)sender
{
    ActivateChannelViewController * activateChannelVC = [[[ActivateChannelViewController alloc] init] autorelease];
    [self.navigationController pushViewController:activateChannelVC animated:YES];
}

-(void)loginBtnClick:(id)sender
{
    NSLog(@"登录");
    LoginViewController * loginVC = [[[LoginViewController alloc] init] autorelease];
    [self.navigationController pushViewController:loginVC animated:YES];
}

//自助购买通道 按钮点击
-(void)selfHelpBuyBtnClick:(id)sender
{
    SelfHelpBuyViewController * selfHelpBuyVC = [[[SelfHelpBuyViewController alloc] init] autorelease];
    [self.navigationController pushViewController:selfHelpBuyVC animated:YES];
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

-(void)backButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//
//-(void)menuButton:(id)sender
//{
//    NSLog(@"菜单按钮");
//}

@end

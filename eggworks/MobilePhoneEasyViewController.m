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

@interface MobilePhoneEasyViewController ()

@end

@implementation MobilePhoneEasyViewController


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
    //自助购买通道
    UIButton * selfHelpBuyBtn = [[[UIButton alloc] initWithFrame:CGRectMake(10, applicationHeight-110, 300, 40)] autorelease];
    [selfHelpBuyBtn setTitle:@"自助购买通道" forState:UIControlStateNormal];
    [selfHelpBuyBtn setBackgroundImage:[UIImage imageNamed:@"orange_btn_bg"] forState:UIControlStateNormal];
    [selfHelpBuyBtn addTarget:self action:@selector(selfHelpBuyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selfHelpBuyBtn];
    
    //无忧卡激活通道按钮
    UIButton * easyCardActivationBtn = [[[UIButton alloc] initWithFrame:CGRectMake(10, applicationHeight-60, 300, 40)] autorelease];
    [easyCardActivationBtn setBackgroundImage:[UIImage imageNamed:@"gray_btn_bg"] forState:UIControlStateNormal];
    [easyCardActivationBtn setTitle:@"无忧卡激活通道" forState:UIControlStateNormal];
    [easyCardActivationBtn setTitleColor:[UIColor colorWithRed:.99 green:.41 blue:.31 alpha:1] forState:UIControlStateNormal];
    [easyCardActivationBtn addTarget:self action:@selector(easyCardActivationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:easyCardActivationBtn];
    
//    phone_easy_iphone4s@2x
    UIImageView * indexImg ;
    if (IPhone5) {
        indexImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_phone_index"]] autorelease];
        indexImg.frame = CGRectMake(0, 0+ios7_d_height, 320, 398);
    } else{
        indexImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_easy_iphone4s"]] autorelease];
        indexImg.frame = CGRectMake(0, 0+ios7_d_height, 320, 310);
    }
    [self.view addSubview:indexImg];
}

//无忧卡激活通道 按钮点击
-(void)easyCardActivationBtnClick:(id)sender
{
    ActivateChannelViewController * activateChannelVC = [[[ActivateChannelViewController alloc] init] autorelease];
    [self.navigationController pushViewController:activateChannelVC animated:YES];
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

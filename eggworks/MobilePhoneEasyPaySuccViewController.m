//
//  MobilePhoneEasyPaySuccViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MobilePhoneEasyPaySuccViewController.h"

@interface MobilePhoneEasyPaySuccViewController ()

@end

@implementation MobilePhoneEasyPaySuccViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"支付成功";
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    UIView * aView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, appHeight)] autorelease];
    [self.view addSubview:aView];
    
    UIImageView * okSiginIv = [[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 28.5, 28.5)] autorelease];
    okSiginIv.image = [UIImage imageNamed:@"ok_ expression"];
    [aView addSubview:okSiginIv];
    
    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(60, 20, 240, 28.5)] autorelease];
    titleLabel.text = @"支付成功!";
    titleLabel.textColor = orange_color;
    [aView addSubview:titleLabel];
    
    //橙色分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 2)] autorelease];
    divider.backgroundColor = orange_color;
    [aView addSubview:divider];
    
    UITextView * introduce1 = [[[UITextView alloc] initWithFrame:CGRectMake(20, 60, 280, 90)] autorelease];
    introduce1.text = @"您的服务合约将在48小时内生成.\n\n您所申购的服务将在次月1日生效，在生效日之前发生的故障不在维修或更换范围内。";
    introduce1.textColor = title_text_color;
    introduce1.scrollEnabled = NO;
    introduce1.editable = NO;
    introduce1.font = [UIFont systemFontOfSize:14];
    [aView addSubview:introduce1];
    
    UITextView * introduce2 = [[[UITextView alloc] initWithFrame:CGRectMake(20, IOS7 ? 130 : 140, 280, 80)] autorelease];
    introduce2.text = @"如：您在2014年11月4日购买了手机无忧计划，服务正式生效日期为2014年2月1日至2015年8月1日，在此期间发生的故障才能申请理赔，享受免费维修或更换服务。";
    introduce2.textColor = [UIColor colorWithRed:.59 green:.59 blue:.60 alpha:1];
    introduce2.font = [UIFont systemFontOfSize:12];
    introduce2.backgroundColor = [UIColor clearColor];
    introduce2.scrollEnabled = NO;
    introduce2.editable = NO;
    [aView addSubview:introduce2];
    
    UITextView * introduce3 = [[[UITextView alloc] initWithFrame:CGRectMake(20, IOS7 ? 210 : 220, 280, 160)] autorelease];
    
    introduce3.text = [NSString stringWithFormat:@"合约生成后，我们将以短信的形式通知您。服务期内您可在手机应用、微信服务号随时查询您的合约信息或申请理赔，登录名是用户名手机号，初始密码为手机号末尾6位。您也可以拨打%@直接咨询。",phone_number];
    introduce3.textColor = title_text_color;
    introduce3.font = [UIFont systemFontOfSize:14];
    introduce3.scrollEnabled = NO;
    introduce3.editable = NO;
    [aView addSubview:introduce3];
    
    UIButton * modifyPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    modifyPassBtn.frame = CGRectMake(20, IOS7 ? 300 : 350, 120, 40);
    [modifyPassBtn setTitle:@"点击修改密码" forState:UIControlStateNormal];
    [modifyPassBtn setTitleColor:orange_color forState:UIControlStateNormal];
    [modifyPassBtn addTarget:self action:@selector(modefyPassBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:modifyPassBtn];
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(20, IOS7 ? 350 : 390, 280, 40);
    [shareBtn setTitle:@"分享手机无忧到微信" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:shareBtn];
}

-(void)shareBtnClick:(id)sender
{
    NSLog(@"分享到微信");
}

//点击修改密码
-(void)modefyPassBtnClick:(id)sender
{
    NSLog(@"进入修改密码页面");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

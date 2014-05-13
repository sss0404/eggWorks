//
//  ActivationSuccessViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ActivationSuccessViewController.h"

@interface ActivationSuccessViewController ()

@end

@implementation ActivationSuccessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.title = @"激活成功";
    UIImageView * activationFailIm = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ok_ expression"]] autorelease];
    activationFailIm.frame = CGRectMake(40, 20+ios7_d_height, 28.5, 28.5);
    [self.view addSubview:activationFailIm];
    
    UILabel * failTitle = [[[UILabel alloc] initWithFrame:CGRectMake(80, 15+ios7_d_height, 240, 40)] autorelease];
    failTitle.text = @"激活成功！";
    failTitle.textColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    failTitle.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:failTitle];
    
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(20, 60+ios7_d_height, 280, 1)] autorelease];
    divider.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider];
    
    UITextView * succlNote = [[[UITextView alloc] initWithFrame:CGRectMake(20, 70+ios7_d_height, 280, 90)] autorelease];
    succlNote.text = @"您的服务合约将在48小时内生成。\n\n 您所申购的服务将在次月1日生效，在生效日之前发生的鼓掌不在维修或更换范围内。";
    succlNote.font = [UIFont systemFontOfSize:14];
    succlNote.scrollEnabled = NO;
    succlNote.editable = NO;
//    succlNote.backgroundColor = [UIColor greenColor];
    [self.view addSubview:succlNote];
    
    UITextView * exampleNote = [[[UITextView alloc] initWithFrame:CGRectMake(20, 150+ios7_d_height, 280, 80)] autorelease];
    exampleNote.text = @"如：您在2014年1月4日购买了手机无忧计划，服务正式生效日期为2014年2月1日至2015年8月1日，在此期间发生的故障才能申请理赔，享受免费维修或更换服务。";
    exampleNote.font = [UIFont systemFontOfSize:12];
    exampleNote.backgroundColor = [UIColor clearColor];
    exampleNote.scrollEnabled = NO;
    exampleNote.editable = NO;
    exampleNote.textColor = [UIColor colorWithRed:.74 green:.74 blue:.74 alpha:1];
    [self.view addSubview:exampleNote];
    
    UITextView * contractTakeEffectNote = [[[UITextView alloc] initWithFrame:CGRectMake(20, 230+ios7_d_height, 280, 100)] autorelease];
    contractTakeEffectNote.text = @"合约生成后，我们将以短信的形式通知您。服务期内您可在手机应用、微信服务号随时查询您的合约信息或申请理赔，登录名是用户名手机号，初始密码为IMEI号末尾6位。您也可以拨打400-00-00直接咨询。";
    contractTakeEffectNote.font = [UIFont systemFontOfSize:14];
    contractTakeEffectNote.scrollEnabled = NO;
    contractTakeEffectNote.editable = NO;
    [self.view addSubview:contractTakeEffectNote];
    
    UIButton * shareWXBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 340+ios7_d_height, 280, 40)] autorelease];
    [shareWXBtn setTitle:@"分享手机无忧到微信" forState:UIControlStateNormal];
//    shareWXBtn.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [shareWXBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [self.view addSubview:shareWXBtn];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

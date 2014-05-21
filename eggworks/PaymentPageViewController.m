//
//  PaymentPageViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-14.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "PaymentPageViewController.h"

@interface PaymentPageViewController ()

@end

@implementation PaymentPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"产品详情";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    UIButton * bankTelBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 20+ios7_d_height, 280, 40)] autorelease];
    [bankTelBtn setTitle:@"95588" forState:UIControlStateNormal];
    [bankTelBtn addTarget:self action:@selector(bankTelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bankTelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    bankTelBtn.backgroundColor = [UIColor colorWithRed:.86 green:.21 blue:.20 alpha:1];
    [self.view addSubview:bankTelBtn];
    
    UIButton * bankWebSuiteBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 80+ios7_d_height, 280, 40)] autorelease];
    [bankWebSuiteBtn setTitle:@"登录手机银行" forState:UIControlStateNormal];
    [bankWebSuiteBtn addTarget:self action:@selector(bankWebSuiteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bankWebSuiteBtn setTitleColor:title_text_color forState:UIControlStateNormal];
    bankWebSuiteBtn.backgroundColor = [UIColor colorWithRed:.94 green:.94 blue:.94 alpha:1];
    [self.view addSubview:bankWebSuiteBtn];
}

//拨打银行的电话
-(void)bankTelBtnClick:(id)sender
{
    //拨打银行电话
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", ((UIButton*)sender).titleLabel.text]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

//打开银行的网站
-(void)bankWebSuiteBtnClick:(id)sender
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", @"www.icbc.com.cn"]];
    [[UIApplication sharedApplication] openURL:phoneURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

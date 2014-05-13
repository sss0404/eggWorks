//
//  UserInfoViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ClaimsInfoInputViewController.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController


@synthesize dic = _dic;

- (void)dealloc
{
    [_dic release]; _dic = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"用户信息";
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    UIView * aVeiw = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, appHeight)] autorelease];
    [self.view addSubview:aVeiw];
    
    UIButton * btn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 320, 40)] autorelease];
    btn.backgroundColor = [UIColor whiteColor];
    [aVeiw addSubview:btn];
    
    //构造提示数据
    NSArray *       orders =        [_dic objectForKey:@"orders"];
    NSDictionary *  order =         [orders objectAtIndex:0];//默认取第一个产品
    NSString *      orderID =       [order objectForKey:@"id"];
    NSString *      purchase_date = [order objectForKey:@"purchase_date"];//购买日期
    NSString *      product_name =  [order objectForKey:@"product_name"];//产品名称
    NSString *      start =         [order objectForKey:@"start"];//产品生效日期
    NSString *      end =           [order objectForKey:@"end"];//产品结束日期
    int             claims_count =  [[order objectForKey:@"claims_count"] intValue];//理赔次数
    NSString *      quote =         [order objectForKey:@"quote"];//产品最高理赔额度
    NSString *      used_quote =    [order objectForKey:@"used_quote"];//已使用额度
    int             status =        [[order objectForKey:@"status"] intValue];
    
    //   保存订单id
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:orderID forKey:ORDER_ID];
    [userDefault synchronize];
    
    //现实提示的控件
    UITextView *    noteTextView =  [[[UITextView alloc] initWithFrame:CGRectMake(20, 20, 280, 200)] autorelease];
    noteTextView.text = [NSString stringWithFormat:@"尊敬的%@用户：\n您在%@购买了“%@”服务，服务正式生效日期为%@至%@, 在此期间发生的故障才能申请理赔，享受免费维修或更换服务。\n\n到木前为止，您已申请理赔%i次，已使用了%@元的理赔额度，还剩余%@元的理赔额度可以使用。" ,@"盛青",purchase_date,product_name,start,end,claims_count,used_quote,quote];
    noteTextView.font = [UIFont systemFontOfSize:14];
    noteTextView.scrollEnabled = NO;
    noteTextView.editable = NO;
    noteTextView.textColor = title_text_color;
    [aVeiw addSubview:noteTextView];
    
    //我要理赔按钮
    UIButton * claimsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 270, 280, 40)] autorelease];
    [claimsBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [claimsBtn setTitle:@"我要理赔" forState:UIControlStateNormal];
    [claimsBtn setTintColor:[UIColor whiteColor]];
    [claimsBtn addTarget:self action:@selector(claimsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aVeiw addSubview:claimsBtn];

    //服务热线电话
    UIButton * servicePhone = [UIButton buttonWithType:UIButtonTypeCustom];
    servicePhone.frame = CGRectMake(20, 315, 280, 40);
    [servicePhone setTitle:@"客户服务热线：400-000-000" forState:UIControlStateNormal];
    servicePhone.backgroundColor = [UIColor whiteColor];
    [servicePhone setTitleColor:title_text_color forState:UIControlStateNormal];
    [aVeiw addSubview:servicePhone];
    
}

//我要理赔按钮点击事件
-(void)claimsBtnClick:(id)sender
{
    NSLog(@"我要理赔");
    ClaimsInfoInputViewController * claimsInfoInputVC = [[[ClaimsInfoInputViewController alloc] init] autorelease];
    [self.navigationController pushViewController:claimsInfoInputVC animated:YES];
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

//
//  HomeDeliveryWayViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "HomeDeliveryWayViewController.h"
#import "ClaimsConfirmInfoViewController.h"

@interface HomeDeliveryWayViewController ()

@end

@implementation HomeDeliveryWayViewController

@synthesize pickupTimeBtn = _pickupTimeBtn;
@synthesize pickupAddrTF = _pickupAddrTF;
@synthesize info = _info;

- (void)dealloc
{
    [_pickupAddrTF release]; _pickupAddrTF = nil;
    [_pickupTimeBtn release]; _pickupTimeBtn = nil;
    [_info release];_info = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    UIScrollView * scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)] autorelease];
    self.aVeiw.frame = CGRectMake(self.aVeiw.frame.origin.x, self.aVeiw.frame.origin.y-ios7_d_height, self.aVeiw.frame.size.width, self.aVeiw.frame.size.height);
    [scrollView addSubview:self.aVeiw];
    scrollView.contentSize = CGSizeMake(320,self.aVeiw.frame.size.height+180);
    [self.view addSubview:scrollView];
    
    //取货时间
    UILabel * pickupTimeLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 270, 80, 30)] autorelease];
    pickupTimeLabel.text = @"取货时间";
    pickupTimeLabel.textColor = title_text_color;
    [self.aVeiw addSubview:pickupTimeLabel];
    
    _pickupTimeBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 270, 200, 30)];
    //    _sendWayBtn.backgroundColor = [UIColor yellowColor];
    [self.aVeiw addSubview:_pickupTimeBtn];
    UIImageView * downImg2 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_btn"]] autorelease];
    downImg2.frame = CGRectMake(180, 13, 11.5, 7);
    [_pickupTimeBtn addSubview:downImg2];
    
    //分割线
    UIView * divider7 = [[[UIView alloc] initWithFrame:CGRectMake(0, 300, 325, 1)] autorelease];
    divider7.backgroundColor = divider_color;
    [self.aVeiw addSubview:divider7];
    
    //取货地点
    UILabel * pickupAddrLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 305, 80, 30)] autorelease];
    pickupAddrLabel.text = @"取货地址";
    pickupAddrLabel.textColor = title_text_color;
    [self.aVeiw addSubview:pickupAddrLabel];
    
    _pickupAddrTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 305, 200, 30)];
    //    _sendWayBtn.backgroundColor = [UIColor yellowColor];
    _pickupAddrTF.delegate = self;
    [self.aVeiw addSubview:_pickupAddrTF];
//    UIImageView * downImg3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_btn"]];
//    downImg3.frame = CGRectMake(180, 13, 11.5, 7);
//    [_pickupAddrTF addSubview:downImg3];
    
    //分割线
    UIView * divider8 = [[[UIView alloc] initWithFrame:CGRectMake(0, 340, 325, 1)] autorelease];
    divider8.backgroundColor = divider_color;
    [self.aVeiw addSubview:divider8];
    
    CGRect nextBtnRGCect = self.nextBtn.frame;
    self.nextBtn.frame = CGRectMake(nextBtnRGCect.origin.x, nextBtnRGCect.origin.y+80, nextBtnRGCect.size.width, nextBtnRGCect.size.height);
    
    CGRect serviceBtnRGCect = self.servicePhone.frame;
    self.servicePhone.frame = CGRectMake(serviceBtnRGCect.origin.x, serviceBtnRGCect.origin.y+80, serviceBtnRGCect.size.width, serviceBtnRGCect.size.height);
    
    [self.cityBtn setTitle:[_info objectForKey:@"city"] forState:UIControlStateNormal];
    self.nameTF.text = [_info objectForKey:@"name"]; self.nameTF.enabled = NO;
    self.phoneNumberTF.text = [_info objectForKey:@"phoneNumber"]; self.phoneNumberTF.enabled = NO;
    self.connectPhoneNumberTF.text = [_info objectForKey:@"connectPhoneNumber"]; self.connectPhoneNumberTF.enabled = NO;
    [self.damageReasonBtn setTitle:[_info objectForKey:@"damageReason"] forState:UIControlStateNormal];
    [self.sendWayBtn setTitle:[_info objectForKey:@"sendWayBtn"] forState:UIControlStateNormal];self.sendWayBtn.enabled = NO;
    
}

-(void)nextBtnClick:(id)sender
{
    NSLog(@"下一步");
    if (_pickupAddrTF.text.length == 0) {
        Show_msg(@"提示", @"取货地址不能为空！");
        return;
    }
    ClaimsConfirmInfoViewController * claimsConfirmInfoVC = [[[ClaimsConfirmInfoViewController alloc] init] autorelease];
    
    [_info setValue:_pickupAddrTF.text forKey:@"addr"];
    claimsConfirmInfoVC.info = _info;
    [self.navigationController pushViewController:claimsConfirmInfoVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

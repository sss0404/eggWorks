//
//  ClaimsConfirmInfoViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-7.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ClaimsConfirmInfoViewController.h"
#import "SubmitSuccViewController.h"
#import "RequestUtils.h"
#import "AsynRuner.h"

@interface ClaimsConfirmInfoViewController ()

@end

@implementation ClaimsConfirmInfoViewController

@synthesize info = _info;

- (void)dealloc
{
    [_info release]; _info = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"确认信息";
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    UIView * aVeiw = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, appHeight)] autorelease];
    [self.view addSubview:aVeiw];
    
    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)] autorelease];
    
    titleLabel.text = [NSString stringWithFormat:@"您选择%@送修方式", [Utils strConversionWitd:[_info objectForKey:@"sendWayBtn"]]];
    titleLabel.textColor = orange_color;
    [aVeiw addSubview:titleLabel];
    
    //橙色分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 2)] autorelease];
    divider.backgroundColor = orange_color;
    [aVeiw addSubview:divider];
    
    
//    //取件地址
//    UILabel * addr = [[[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 40)] autorelease];
//    addr.text = [NSString stringWithFormat:@"取件地址：%@", [_info objectForKey:@"addr"]];
//    addr.textColor = title_text_color;
//    [aVeiw addSubview:addr];
    
    //联系电话
    UILabel * contactPhoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 280, 40)] autorelease];
    contactPhoneNumberLabel.text = [NSString stringWithFormat:@"联系电话：%@",[_info objectForKey:@"connectPhoneNumber"]];
    contactPhoneNumberLabel.textColor = title_text_color;
    [aVeiw addSubview:contactPhoneNumberLabel];
    
    //理赔信息
    UILabel * infoTitleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 150, 280, 40)] autorelease];
    infoTitleLabel.textColor = title_text_color;
    infoTitleLabel.text = @"理赔信息如下：";
    [aVeiw addSubview:infoTitleLabel];
    
    
    //姓名
    UILabel * nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 180, 280, 40)] autorelease];
    nameLabel.text = [NSString stringWithFormat:@"姓名：%@",[_info objectForKey:@"name"]];
    nameLabel.textColor = title_text_color;
    [aVeiw addSubview:nameLabel];
    
    //手机号
    UILabel * phoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 210, 280, 40)] autorelease];
    phoneNumberLabel.text = [NSString stringWithFormat:@"手机号：%@",[_info objectForKey:@"phoneNumber"]];
    phoneNumberLabel.textColor = title_text_color;
    [aVeiw addSubview:phoneNumberLabel];
    
    //imei
    UILabel * imeiLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 240, 280, 40)] autorelease];
    imeiLabel.text = [NSString stringWithFormat:@"IMEI：%@",[_info objectForKey:@"device_identity"]];
    imeiLabel.textColor = title_text_color;
    [aVeiw addSubview:imeiLabel];
    
    //品牌型号
    UILabel * brandModelLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 270, 280, 40)] autorelease];
    brandModelLabel.text = [NSString stringWithFormat:@"品牌型号：%@%@",[_info objectForKey:@"brand"],[_info objectForKey:@"model"]];
    brandModelLabel.textColor = title_text_color;
    [aVeiw addSubview:brandModelLabel];
    
    UIButton * modifyBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 310, 80, 40)] autorelease];
    [modifyBtn setTitle:@"点击修改" forState:UIControlStateNormal];
    [modifyBtn setTitleColor:orange_color forState:UIControlStateNormal];
    [modifyBtn addTarget:self action:@selector(modifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aVeiw addSubview:modifyBtn];
    
    UIButton * confirmBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 355, 280, 40)] autorelease];
    [confirmBtn setTitle:@"确认并提交信息" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aVeiw addSubview:confirmBtn];
    
    //服务热线电话
    UIButton * servicePhone = [UIButton buttonWithType:UIButtonTypeCustom];
    servicePhone.frame = CGRectMake(20, 400, 280, 40);
    [servicePhone setTitle:[NSString stringWithFormat:@"客户服务热线：%@",phone_number] forState:UIControlStateNormal];
    servicePhone.backgroundColor = [UIColor whiteColor];
    [servicePhone setTitleColor:title_text_color forState:UIControlStateNormal];
    [aVeiw addSubview:servicePhone];
    
    UIScrollView * scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)] autorelease];
//    self.aVeiw.frame = CGRectMake(self.aVeiw.frame.origin.x, self.aVeiw.frame.origin.y-ios7_d_height, self.aVeiw.frame.size.width, self.aVeiw.frame.size.height);
    [scrollView addSubview:aVeiw];
    scrollView.contentSize = CGSizeMake(320,aVeiw.frame.size.height+40);
    [self.view addSubview:scrollView];

}

//提交信息按钮
-(void)confirmBtnClick:(id)sender
{
    NSLog(@"提交信息");
    NSString * orderId = [[NSUserDefaults standardUserDefaults] objectForKey:ORDER_ID];
    AsynRuner * asynRunner = [[AsynRuner alloc] init];
    [asynRunner runOnBackground:^{
        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
        NSDictionary * dic = [requestUtils    claimRequestsWithOrderId:orderId
                                                         contactMobile:[_info objectForKey:@"connectPhoneNumber"]
                                                            pickMethod:0
                                                                damage:1
                                                               storeId:@"1"
                                                              pickTime:0
                                                           pickAddress:[_info objectForKey:@"addr"]
                                                                areaId:[_info objectForKey:@"user_selected_city_id"]];
        return dic;
    } onUpdateUI:^(id obj){
        BOOL success = [[obj objectForKey:@"success"] boolValue];
        if (success) {
            //提交成功后进入成功页面
            SubmitSuccViewController * submitSuccVC = [[[SubmitSuccViewController alloc] init] autorelease];
            [self.navigationController pushViewController:submitSuccVC animated:YES];
        } else {
            NSString * message = [obj objectForKey:@"message"];
            Show_msg(@"提示", message);
        }
    } inView:self.view];
    
}

//修改信息 按钮
-(void)modifyBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



@end

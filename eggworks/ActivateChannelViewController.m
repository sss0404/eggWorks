//
//  ActivateChannelViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ActivateChannelViewController.h"
#import "SelfHelpBuyViewController.h"
#import "ActivationFailViewController.h"
#import "ActivationSuccessViewController.h"
#import "RequestUtils.h"
#import "Utils.h"

@interface ActivateChannelViewController ()

@end

@implementation ActivateChannelViewController

@synthesize nameTextField = _nameTextField;
@synthesize phoneNumber = _phoneNumber;
@synthesize phoneIMEI = _phoneIMEI;
@synthesize phoneModel = _phoneModel;
@synthesize verificationCode = _verificationCode;
@synthesize asynRunner = _asynRunner;
@synthesize sendSMS = _sendSMS;

- (void)dealloc
{
    [_sendSMS stop];
    [_nameTextField release];
    [_phoneNumber release];
    [_phoneIMEI release];
    [_phoneModel release];
    [_verificationCode release];
    [_asynRunner release];
    [_sendSMS release]; _sendSMS = nil;
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"填写信息";
   
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = 60;
    }
    
    
    UITextView * noteMsg = [[[UITextView alloc] initWithFrame:CGRectMake(20, 10, 280, 90 +ios7_d_height)] autorelease];
    noteMsg.editable = NO;
    noteMsg.scrollEnabled = NO;
    noteMsg.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:noteMsg];
    noteMsg.text = @"注：如果您未在其他渠道购买本服务请返回首页，点击                           购买此项服务。";
    
    float selfHelpBuyHeight = 45;
    float selfHelpBuyX = 140;
    if (IOS7) {
        selfHelpBuyHeight = 40;
        selfHelpBuyX = 125;
    }
    UIButton * selfHelpBuy = [[UIButton alloc] initWithFrame:CGRectMake(selfHelpBuyX, selfHelpBuyHeight+ios7_d_height, 100, 20)];
    selfHelpBuy.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [selfHelpBuy setTitle:@"自助购买通道" forState:UIControlStateNormal];
    selfHelpBuy.font = [UIFont systemFontOfSize:13.5f];
    [selfHelpBuy addTarget:self action:@selector(selfHelpBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selfHelpBuy];
    
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90+ios7_d_height, 280, 40)] autorelease];
    label.text = @"请补充资料并激活";
    [self.view addSubview:label];
    
    //橙色分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 123+ios7_d_height, 320, 2)] autorelease];
    divider.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [self.view addSubview:divider];
    
    UILabel * nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 132+ios7_d_height, 60, 30)] autorelease];
    nameLabel.text = @"姓名";
//    nameLabel.backgroundColor = [UIColor yellowColor];
    nameLabel.textColor = title_text_color;
    [self.view addSubview:nameLabel];
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 132+ios7_d_height, 220, 30)];
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    _nameTextField.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_nameTextField];
    _nameTextField.delegate = self;
    
    //分割线
    UIView * divider1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 169+ios7_d_height, 320, 1)] autorelease];
    divider1.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider1];
    
    UILabel * phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 174+ios7_d_height, 60, 30)] autorelease] ;
    phoneLabel.text = @"手机号";
    phoneLabel.textColor = title_text_color;
    [self.view addSubview:phoneLabel];
    _phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(80, 174+ios7_d_height, 130, 30)];
//    _phoneNumber.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:_phoneNumber];
    _phoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumber.delegate = self;
    
    //发送短信按钮
    self.sendSMS = [[[CountdownButton alloc] initWithFrame:CGRectMake(214, 174+ios7_d_height, 100, 30)] autorelease];
//    _sendSMS.backgroundColor = [UIColor yellowColor];
    [_sendSMS setTitle:@"发送手机校验码" forState:UIControlStateNormal];
    [_sendSMS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _sendSMS.font = [UIFont systemFontOfSize:14];
    [_sendSMS addTarget:self action:@selector(sendSMSBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendSMS];
    
    //分割线
    UIView * divider9 = [[[UIView alloc] initWithFrame:CGRectMake(0, 209+ios7_d_height, 320, 1)] autorelease];
    divider9.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider9];
    
    UILabel * verificationCode = [[[UILabel alloc] initWithFrame:CGRectMake(20, 214+ios7_d_height, 60, 30)] autorelease];
    verificationCode.text = @"验证码";
    verificationCode.textColor = title_text_color;
    [self.view addSubview:verificationCode];
    _verificationCode = [[UITextField alloc] initWithFrame:CGRectMake(80, 214+ios7_d_height, 220, 30)];
    [self.view addSubview:_verificationCode];
    _verificationCode.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _verificationCode.delegate = self;
    
//    //分割线
//    UIView * divider8 = [[[UIView alloc] initWithFrame:CGRectMake(0, 289+ios7_d_height, 320, 1)] autorelease];
//    divider8.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
//    [self.view addSubview:divider8];
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 251+ios7_d_height, 320, 1)] autorelease];
    divider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider2];
    
    UILabel * phoneIMEI = [[[UILabel alloc] initWithFrame:CGRectMake(20, 258+ios7_d_height, 60, 30)] autorelease];
    phoneIMEI.text = @"IMEI";
    phoneIMEI.textColor = title_text_color;
    [self.view addSubview:phoneIMEI];
    _phoneIMEI = [[UITextField alloc] initWithFrame:CGRectMake(80, 258+ios7_d_height, 220, 30)];
    [self.view addSubview:_phoneIMEI];
    _phoneIMEI.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneIMEI.delegate = self;
    
    //分割线
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 294+ios7_d_height, 320, 1)] autorelease];
    divider3.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider3];
    
    UILabel * phoneModel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 306+ios7_d_height, 60, 30)] autorelease];
    phoneModel.text = @"型号";
    phoneModel.textColor = title_text_color;
    [self.view addSubview:phoneModel];
    _phoneModel = [[UITextField alloc] initWithFrame:CGRectMake(80, 306+ios7_d_height, 220, 30)];
    [self.view addSubview:_phoneModel];
    _phoneModel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneModel.delegate = self;
    
    //分割线
    UIView * divider4 = [[[UIView alloc] initWithFrame:CGRectMake(0, 338+ios7_d_height, 320, 1)] autorelease];
    divider4.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider4];
    
    //提交数据按钮
    UIButton * submitBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 360+ios7_d_height, 280, 40)] autorelease];
//    submitBtn.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    
}

-(void)sendSMSBtnClick:(id)sender
{
    if (![Utils verifyPhoneNumber:_phoneNumber.text]) {
        Show_msg(@"提示", @"请输入正确的手机号");
        return;
    }
    int second = _sendSMS.seconds;
    if (second == 0) {
        NSLog(@"发送短信");
        [_asynRunner runOnBackground:^id{
            NSDictionary * dic = [RequestUtils sendSMSVerifyWithNumber:_phoneNumber.text];
            BOOL success = [[dic objectForKey:@"success"] boolValue];
            return success ? @"ok" : @"fail";
        } onUpdateUI:^(id obj) {
            if ([obj isEqualToString:@"ok"]) {
                [_sendSMS start];
            } else {
                Show_msg(@"提示", @"发送失败，请重试!");
            }
        } inView:self.view];
    }
}


-(void)submitBtnClick:(id)sender
{
    if (_verificationCode.text.length == 0) {
        Show_msg(@"提示", @"请输入短信验证码");
        return;
    }
    if (_phoneModel.text.length == 0) {
        Show_msg(@"提示", @"手机型号不能为空");
        return;
    }
    //
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * userName = [userDefault objectForKey:@"userName"];
    if (userName.length == 0) {
        NSLog(@"未登录");
        AsynRuner * asynRunner = [[AsynRuner alloc] init];
        [asynRunner runOnBackground:^{
            return [RequestUtils anonymouusActiveWithUser:[Utils getAccount]
                                                 realName:_nameTextField.text
                                              mobilePhone:_phoneNumber.text
                                               verifyCode:_verificationCode.text
                                           deviceIdentity:_phoneIMEI.text
                                                    brand:@"apple"
                                                    model:_phoneModel.text];
        } onUpdateUI:^(id obj){
            BOOL success = [[obj objectForKey:@"success"] boolValue];
            if (success) {
                //提交成功
                ActivationSuccessViewController * submitSuccVC = [[ActivationSuccessViewController alloc] init];
                [self.navigationController pushViewController:submitSuccVC animated:YES];
                [submitSuccVC release];
            } else {
                //提交失败
//                NSString * message = [obj objectForKey:@"message"];
                ActivationFailViewController * submitFailVC = [[ActivationFailViewController alloc] init];
                [self.navigationController pushViewController:submitFailVC animated:YES];
                [submitFailVC release];
            }
        } inView:self.view];
       
    } else {
        NSLog(@"已登录");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

-(void)selfHelpBuyClick:(id)sender
{
    SelfHelpBuyViewController * selfHelpBuyVC = [[[SelfHelpBuyViewController alloc] init] autorelease];
    [self.navigationController pushViewController:selfHelpBuyVC animated:YES];
    
//    [self.navigationController popViewControllerAnimated:NO];

}

@end

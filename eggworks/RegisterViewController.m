//
//  RegisterViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RegisterViewController.h"
#import "CheckBox.h"
#import "CountdownButton.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "AgreementViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize sendSMS = _sendSMS;
@synthesize account = _account;
@synthesize verify = _verify;
@synthesize password = _password;
@synthesize conPassword = _conPassword;
@synthesize asynRunner = _asynRunner;
@synthesize agress = _agress;

- (void)dealloc
{
    [_sendSMS stop];
    [_sendSMS release]; _sendSMS = nil;
    [_account release]; _account = nil;
    [_verify release]; _verify = nil;
    [_password release]; _password = nil;
    [_conPassword release]; _conPassword = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_agress release]; _agress = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"注册";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, 265)] autorelease];
    topView.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [self.view addSubview:topView];
    
    UIView * accountBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 50)] autorelease];
    accountBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:accountBg];
    
    
    self.account = [[[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)] autorelease];
    //    account.backgroundColor = [UIColor yellowColor];
    _account.placeholder = @"请输入手机号";
    _account.delegate = self;
    [accountBg addSubview:_account];
    
    //验证码
    UIView * verifyBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 81, 320, 50)] autorelease];
    verifyBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:verifyBg];
    
    
    self.verify = [[[UITextField alloc] initWithFrame:CGRectMake(20, 10, 150, 30)] autorelease];
    //    account.backgroundColor = [UIColor yellowColor];
    _verify.placeholder = @"请输入短信验证码";
    _verify.delegate = self;
//    verify.backgroundColor = [UIColor yellowColor];
    [verifyBg addSubview:_verify];
    
    self.sendSMS = [[[CountdownButton alloc] initWithFrame:CGRectMake(180, 10, 120, 30)] autorelease];
    [_sendSMS setTitle:@"发送手机校验码" forState:UIControlStateNormal];
    [_sendSMS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _sendSMS.font = [UIFont systemFontOfSize:14];
    [_sendSMS addTarget:self action:@selector(sendSMSBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [verifyBg addSubview:_sendSMS];
    
    UIView * passwordBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 132, 320, 50)] autorelease];
    passwordBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:passwordBg];
 
    
    self.password = [[[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)] autorelease];
    //    password.backgroundColor = [UIColor yellowColor];
    _password.placeholder = @"设置您的密码";
    _password.delegate = self;
    _password.secureTextEntry = YES;
    [passwordBg addSubview:_password];
    
    UIView * conPasswordBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 183, 320, 50)] autorelease];
    conPasswordBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:conPasswordBg];
    
    
    self.conPassword = [[[UITextField alloc] initWithFrame:CGRectMake(20, 10, 280, 30)] autorelease];
    //    password.backgroundColor = [UIColor yellowColor];
    _conPassword.placeholder = @"重复输入密码";
    _conPassword.delegate = self;
    _conPassword.secureTextEntry = YES;
    [conPasswordBg addSubview:_conPassword];
    
    self.agress = [[[CheckBox alloc] initWithFrame:CGRectMake(55, 297+ios7_d_height, 70, 30)] autorelease];
    [_agress setCheck:YES];
    _agress.title.text = @"我同意";
    _agress.title.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_agress];
    
    //服务条款
    UIButton * termsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(90,290+ios7_d_height,200, 30 )] autorelease];
    [termsBtn setTitle:@"彩蛋财富用户使用协议" forState:UIControlStateNormal];
    [termsBtn setFont:[UIFont systemFontOfSize:14.5]];
    [termsBtn setTitleColor:[UIColor colorWithRed:.38 green:.76 blue:.98 alpha:1] forState:UIControlStateNormal];
//    termsBtn.backgroundColor = [UIColor redColor];
    [termsBtn addTarget:self action:@selector(termsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:termsBtn];
    
    UIButton * loginBtn = [[[UIButton  alloc] initWithFrame:CGRectMake(20, 330+ios7_d_height, 280, 40)] autorelease];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
}

-(void)termsBtnClick:(id) sender
{
    AgreementViewController * agreementVC = [[[AgreementViewController alloc] init] autorelease];
    [self.navigationController pushViewController:agreementVC animated:YES];
}

//注册提交
-(void)registerBtnClick:(id)sender
{
    NSLog(@"提交注册");
    NSString * account =  _account.text;
    NSString * password = _password.text;
    if (account.length == 0) {
        Show_msg(@"提示", @"手机号码不能为空");
        return;
    }
    if (_verify.text.length == 0) {
        Show_msg(@"提示", @"请输入收到的验证码");
        return;
    }
    if (password.length == 0) {
        Show_msg(@"提示", @"密码不能为空");
        return;
    }
    if (![_conPassword.text isEqualToString:password]) {
        Show_msg(@"提示", @"两次输入的密码不相同");
        return;
    }
    if (!_agress.selected) {
        Show_msg(@"提示", @"您必须同意彩蛋财富用户使用协议");
        return;
    }
    //提交
    [RequestUtils registerWithName:_account.text password:_password.text smsVerify:_verify.text callback:^(id obj) {
        BOOL success = [[obj objectForKey:@"success"] boolValue];
        if (success) {
            NSString * id_ = [obj objectForKey:@"id"];
            [Utils saveIdForUser:id_];
            [Utils saveAccount:account];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else{
            NSString * error_code = [obj objectForKey:@"error_code"];
            if ([error_code isEqualToString:@"001"]) {
                Show_msg(@"提示", @"手机号码已经被注册");
            }
        }
    } withView:self.view];
    
//    [_asynRunner runOnBackground:^id{
//        NSDictionary * dic = [RequestUtils registerWithName:_account.text password:_password.text smsVerify:_verify.text];
//        return dic;
//    } onUpdateUI:^(id obj) {
//        BOOL success = [[obj objectForKey:@"success"] boolValue];
//        if (success) {
//            NSString * id_ = [obj objectForKey:@"id"];
//            [Utils saveIdForUser:id_];
//            [Utils saveAccount:account];
//            RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        } else{
//            NSString * error_code = [obj objectForKey:@"error_code"];
//            if ([error_code isEqualToString:@"001"]) {
//                Show_msg(@"提示", @"手机号码已经被注册");
//            }
//        }
//    } inView:self.view];
    
}

-(void)sendSMSBtnClick:(id)sender
{
    if (_account.text.length == 0) {
        Show_msg(@"提示", @"电话号码不能为空");
        return;
    }
    int second = _sendSMS.seconds;
    if (second == 0) {
        NSLog(@"发送短信");
        [_asynRunner runOnBackground:^id{
            NSDictionary * dic = [RequestUtils sendSMSVerifyWithNumber:_account.text];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

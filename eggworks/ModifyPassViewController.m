//
//  ModifyPassViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ModifyPassViewController.h"
#import "RequestUtils.h"
#import "Utils.h"

@interface ModifyPassViewController ()

@end

@implementation ModifyPassViewController

@synthesize oldPassword = _oldPassword;
@synthesize newPassword = _newPassword;
@synthesize configNewPassword = _configNewPassword;
@synthesize asyrunner = _asyrunner;

- (void)dealloc
{
    [_oldPassword release]; _oldPassword = nil;
    [_newPassword release]; _newPassword = nil;
    [_configNewPassword release]; _configNewPassword = nil;
    [_asyrunner release]; _asyrunner = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"修改密码";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.asyrunner = [[[AsynRuner alloc] init] autorelease];
    
    UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, 160)] autorelease];
    topView.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [self.view addSubview:topView];
    
    UIView * accountBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 50)] autorelease];
    accountBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:accountBg];
    
    UILabel * oldPassTitle = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)] autorelease];
    oldPassTitle.text = @"旧密码";
    [accountBg addSubview:oldPassTitle];
    
    self.oldPassword = [[[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)] autorelease];
    //    account.backgroundColor = [UIColor yellowColor];
    _oldPassword.placeholder = @"请输入旧密码";
    _oldPassword.delegate = self;
    _oldPassword.secureTextEntry = YES;
    [accountBg addSubview:_oldPassword];
    
    UIView * newPassBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 81, 320, 50)] autorelease];
    newPassBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:newPassBg];
    
    UILabel * newPassTitle = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 60, 30)] autorelease];
    newPassTitle.text = @"新密码";
    [newPassBg addSubview:newPassTitle];
    
    self.newPassword = [[[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)] autorelease];
    //    account.backgroundColor = [UIColor yellowColor];
    _newPassword.placeholder = @"请输入新密码";
    _newPassword.delegate = self;
    _newPassword.secureTextEntry = YES;
    [newPassBg addSubview:_newPassword];
    
    UIView * configNewPassBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 132, 320, 50)] autorelease];
    configNewPassBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:configNewPassBg];
    
    UILabel * configNewPassTitle = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 70, 30)] autorelease];
    configNewPassTitle.text = @"确认密码";
    [configNewPassBg addSubview:configNewPassTitle];
    
    self.configNewPassword = [[[UITextField alloc] initWithFrame:CGRectMake(100, 10, 200, 30)] autorelease];
    //    account.backgroundColor = [UIColor yellowColor];
    _configNewPassword.placeholder = @"确认新密码";
    _configNewPassword.delegate = self;
    _configNewPassword.secureTextEntry = YES;
    [configNewPassBg addSubview:_configNewPassword];
    
    UIButton * btn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 252, 280, 40)] autorelease];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void) btnClick:(id)sender
{
    NSLog(@"提交");
    NSString * oldPassword = _oldPassword.text;
    if (oldPassword.length == 0) {
        Show_msg(@"提示", @"原始密码不能为空");
        return;
    }
    
    NSString * _newPassword_ = _newPassword.text;
    if (_newPassword_.length == 0) {
        Show_msg(@"提示", @"新密码不能为空");
        return;
    }
    
    NSString * newPasswordConfirm = _configNewPassword.text;
    if (newPasswordConfirm.length == 0) {
        Show_msg(@"提示", @"确认密码不能为空");
        return;
    }
    
    if (![_newPassword_ isEqualToString:newPasswordConfirm]) {
        Show_msg(@"提示", @"两次密码输入不相同");
        return;
    }
    
    [RequestUtils updatePasswordWithOldPsd:oldPassword andNewPassword:_newPassword_ callback:^(id obj) {
        BOOL success = [[obj objectForKey:@"success"] boolValue];
        if (success) {
            Show_msg(@"提示", @"修改密码成功");
            [Utils savePassword:_newPassword_];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    } withView:self.view];
    
//    [_asyrunner runOnBackground:^id{
//        return [RequestUtils updatePasswordWithOldPsd:oldPassword
//                                       andNewPassword:_newPassword_];
//    } onUpdateUI:^(id obj) {
//        BOOL success = [[obj objectForKey:@"success"] boolValue];
//        if (success) {
//            Show_msg(@"提示", @"修改密码成功");
//            [Utils savePassword:_newPassword_];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//    } inView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

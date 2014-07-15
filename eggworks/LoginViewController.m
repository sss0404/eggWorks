//
//  LoginViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "MyAccountViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize account = _account;
@synthesize password = _password;
@synthesize asynRunner = _asynRunner;
@synthesize action = _action;

- (void)dealloc
{
    [_account release]; _account = nil;
    [_password release]; _password = nil;
    [_asynRunner release]; _asynRunner = nil;
    [super dealloc];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
//    _action = default_action;
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    
    UIView * topView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, 160)] autorelease];
    topView.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [self.view addSubview:topView];
    
    UIView * accountBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 30, 320, 50)] autorelease];
    accountBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:accountBg];
    
    UILabel * accountTitle = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 40, 30)] autorelease];
    accountTitle.text = @"账户";
    [accountBg addSubview:accountTitle];
    
    self.account = [[[UITextField alloc] initWithFrame:CGRectMake(70, 10, 160, 30)] autorelease];
//    account.backgroundColor = [UIColor yellowColor];
    _account.placeholder = @"请输入手机号";
    _account.delegate = self;
    [accountBg addSubview:_account];
    
    UIView * passwordBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 81, 320, 50)] autorelease];
    passwordBg.backgroundColor = [UIColor whiteColor];
    [topView addSubview:passwordBg];
    
    UILabel * passwordTitle = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 40, 30)] autorelease];
    passwordTitle.text = @"密码";
    [passwordBg addSubview:passwordTitle];
    
    self.password = [[[UITextField alloc] initWithFrame:CGRectMake(70, 10, 160, 30)] autorelease];
//    password.backgroundColor = [UIColor yellowColor];
    _password.placeholder = @"请输入密码";
    _password.delegate = self;
    _password.secureTextEntry = YES;
    [passwordBg addSubview:_password];
    
    UIButton * forgetPsd = [[[UIButton alloc] initWithFrame:CGRectMake(230, 10, 80, 30)] autorelease];
    [forgetPsd setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetPsd setTitleColor:orange_color forState:UIControlStateNormal];
    forgetPsd.font = [UIFont systemFontOfSize:14];
    [forgetPsd addTarget:self action:@selector(forgetPsdBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    forgetPsd.hidden = YES;
    [passwordBg addSubview:forgetPsd];
    
    UIButton * loginBtn = [[[UIButton  alloc] initWithFrame:CGRectMake(20, 190+ios7_d_height, 280, 40)] autorelease];
    loginBtn.backgroundColor = [UIColor redColor];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    UIButton * registerBtn = [[[UIButton  alloc] initWithFrame:CGRectMake(20, 240+ios7_d_height, 280, 40)] autorelease];
    registerBtn.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
}



//忘记密码按钮
-(void)forgetPsdBtnClick:(id)sender
{
    NSLog(@"忘记密码");
}

//登录按钮
-(void)loginBtnClick:(id)sender
{
    NSLog(@"登录按钮");
    NSString * account = _account.text;
    NSString * password = _password.text;
    
    if (account.length == 0) {
        Show_msg(@"提示", @"用户名不能为空");
        return;
    }
    if (password.length == 0) {
        Show_msg(@"提示", @"密码不能为空");
        return;
    }
    
    
    [self getUserInfoWithAccount:account andPassword:password];
    
    
}

//
-(void) getUserInfoWithAccount:(NSString*)account andPassword:(NSString*)password
{
    [Utils saveAccount:account];
    [Utils savePassword:password];
    [RequestUtils getUserInfoWithCallBack:^(id data) {
        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
        if (data == nil) {
            [Utils saveAccount:@""];
            [Utils savePassword:@""];
            [Utils saveRealName:@""];
            [requestUtils removeHttpCredentials];
            Show_msg(@"提示", @"登陆失败，请稍候重试");
            return;
        }
        BOOL success = [[data objectForKey:@"success"] boolValue];
        if (success) {
            [Utils saveAccount:account];//将用户名保存到本地
            [Utils savePassword:password];//保存密码
            [Utils saveRealName:[data objectForKey:@"real_name"]];
            NSLog(@"登陆成功后保存数据 account：%@,  密码：%@",account,password);
            [self loginSuccAction:_action withObj:data];
        } else {
            [Utils saveAccount:@""];
            [Utils savePassword:@""];
            [Utils saveRealName:@""];
            [requestUtils removeHttpCredentials];
            Show_msg(@"提示", @"登录失败，请检查您的账号和密码");
        }
    } withView:self.view];
    return;
//    //以上为测试
//    [Utils saveAccount:account];
//    [Utils savePassword:password];
//    [_asynRunner runOnBackground:^id{
//        return [RequestUtils getUserInfo];
//    } onUpdateUI:^(id obj) {
//        BOOL success = [[obj objectForKey:@"success"] boolValue];
//        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
//        if (success) {
//            [Utils saveAccount:account];//将用户名保存到本地
//            [Utils savePassword:password];//保存密码
//            [Utils saveRealName:[obj objectForKey:@"real_name"]];
//            NSLog(@"登陆成功后保存数据 account：%@,  密码：%@",account,password);
//            [self loginSuccAction:_action withObj:obj];
//        } else {
//            [Utils saveAccount:@""];
//            [Utils savePassword:@""];
//            [Utils saveRealName:@""];
//            [requestUtils removeHttpCredentials];
//            Show_msg(@"提示", @"登录失败，请检查您的账号和密码");
//        }
//    } inView:self.view];
    
}

-(void)loginSuccAction:(int)action withObj:(id) obj
{
    switch (action) {
        case default_action://进入用户中心
            [self goMyAcountWith:obj];
            break;
        case action_return:
            [self.navigationController popViewControllerAnimated:NO];
            [self.passingParameters completeParameters:nil withTag:self.resultCode];
            break;
        default:
            break;
    }
}

//进入用户中心
-(void)goMyAcountWith:(id)obj
{
    MyAccountViewController * myAccountVC = [[[MyAccountViewController alloc] init] autorelease];
    myAccountVC.userInfo = obj;
    [self.navigationController pushViewController:myAccountVC animated:YES];
}


-(void)registerBtnClick:(id)sender
{
    NSLog(@"注册按钮");
    RegisterViewController * registerVC = [[[RegisterViewController alloc] init] autorelease];
    [self.navigationController pushViewController:registerVC animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+50);
}
@end

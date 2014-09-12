//
//  BaseViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"
#import "FinancialMarketMainViewController.h"
#import "EnjoyPrivateFinanceViewController.h"
#import "Utils.h"
#import "LoginViewController.h"
#import "MobilePhoneEasyViewController.h"
#import "RequestUtils.h"
#import "MyAlertView.h"
#import "UserInfoViewController.h"
#import "MyOrderViewController.h"
#import "Payment.h"
#import "AlixPayResult.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize passingParameters = _passingParameters;
@synthesize resultCode = _resultCode;
@synthesize menuItemView = _menuItemView;

- (void)dealloc
{
    [_resultCode release]; _resultCode = nil;
    [_menuItemView release]; _menuItemView = nil;
    [super dealloc];
}

//接收参数
-(void)completeParameters:(id)obj withTag:(NSString*)tag
{
    if ([tag isEqualToString:@"1"]) {
        FinancialMarketMainViewController * financalMarketMainVC = [[[FinancialMarketMainViewController alloc] init] autorelease];
        [self.navigationController pushViewController:financalMarketMainVC animated:YES];
    } else if ([tag isEqualToString:@"3"]) {
        EnjoyPrivateFinanceViewController * enjoyPrivateFinanceVC = [[[EnjoyPrivateFinanceViewController alloc] init] autorelease];
        [self.navigationController pushViewController:enjoyPrivateFinanceVC animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //返回按钮
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"return_pre_btn_bg"] forState:UIControlStateNormal];
    backbutton.frame = CGRectMake(0, 0, 12, 22.5);
    [backbutton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[[UIBarButtonItem alloc] initWithCustomView:backbutton] autorelease];
    buttonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"n_right_menu"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 19, 16);
    [menuBtn addTarget:self action:@selector(menuButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[[UIBarButtonItem alloc] initWithCustomView:menuBtn] autorelease];
    rightBtn.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = rightBtn;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)menuButton:(id)sender
{
    NSLog(@"菜单按钮");
    
    if (!_menuItemView) {
        float ios7_d_height = 0;
        if (IOS7) {
            ios7_d_height = IOS7_HEIGHT;
        }
        self.menuItemView = [[[MenuItemView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, kScreenWidth, kScreenHeight)] autorelease];
        _menuItemView.hidden = YES;
        _menuItemView.menuItemClickDelegate = self;
        [self.view addSubview:_menuItemView];
    }
    
//    NSTimeInterval animationDuration = 0.5;
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    if (_menuItemView.frame.size.width != 0) {
//        _menuItemView.frame = CGRectMake(0, 0+IOS7_HEIGHT, 0,0);
//    } else {
//        _menuItemView.frame = CGRectMake(0, 0+IOS7_HEIGHT, kScreenWidth, kScreenHeight);
//    }
//   
//    [UIView commitAnimations];
    _menuItemView.hidden = !_menuItemView.hidden;
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    NSLog(@"高度：%f",self.view.frame.size.height);
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    BOOL isScrollView = NO;
    NSArray * views = [self.view subviews];
    for (int i=0; i<views.count; i++) {
        UIView * view = [views objectAtIndex:i];
        if ([view isKindOfClass:[UIScrollView class]]&&[((UIScrollView*)view) contentSize].height>kApplicationHeight) {
            isScrollView = YES;
        }
    }
    if (!isScrollView) {
        ios7_d_height = 0;
    }
    self.view.frame =CGRectMake(0, 0+ios7_d_height, self.view.frame.size.width, self.view.frame.size.height+50);
}

-(void) onMenuItemClickedAt:(int)index
{
    ////理财集市   手机无忧   思想理财
    NSString * account = [Utils getAccount];
    if (index == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if(index == 1) {
        FinancialMarketMainViewController * financalMarketMainVC = [[[FinancialMarketMainViewController alloc] init] autorelease];
        [self.navigationController pushViewController:financalMarketMainVC animated:YES];
    } else if (index == 3) {
//        [self phoneEasySelected];
    } else if (index == 2) {
        if (account.length == 0) {
            LoginViewController * loginVC = [[[LoginViewController alloc] init] autorelease];
            loginVC.resultCode = @"3";
            loginVC.passingParameters = self;
            loginVC.action = action_return;
            [self.navigationController pushViewController:loginVC animated:YES];
            return;
        }
        EnjoyPrivateFinanceViewController * enjoyPrivateFinanceVC = [[[EnjoyPrivateFinanceViewController alloc] init] autorelease];
        [self.navigationController pushViewController:enjoyPrivateFinanceVC animated:YES];
    }
    
}

//手机无忧点击事件
-(void)phoneEasySelected
{
    NSLog(@"手机无忧点击事件");//user_id
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * user_id = [userDefault objectForKey:USER_ID];
    if (user_id.length == 0) {
        MobilePhoneEasyViewController * mobilePE = [[[MobilePhoneEasyViewController alloc] init] autorelease];
        [self.navigationController pushViewController:mobilePE animated:YES];
    } else {
//        AsynRuner * asynRunner = [[AsynRuner alloc] init];
        
        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
        [requestUtils ordersJsonWithCallback:^(id obj) {
            if (![[obj objectForKey:@"success"] boolValue]) {
                Show_msg(@"提示", @"获取数据失败");
                return ;
            }
            //获取数据成功
            //判断是否有未支付的订单，如果有则询问是否支付，如故用户点击不支付则停留在首页否则进入支付流程。如果用户不存在未支付的订单，则判断用户是否有多个保单，如果有多个保单则进入列表否则，如果只有一个保单则进入UserInfoViewController页面
            NSArray * orders = [obj objectForKey:@"orders"];
            for (int i=0; i<orders.count; i++) {
                NSDictionary * order = [orders objectAtIndex:i];
                int status = [[order objectForKey:@"status"] intValue];
                NSString * status_label = [order objectForKey:@"status_label"];
                if (status == 14) {//未支付
                    NSString * message = [NSString stringWithFormat:@"您有未支付的订单，是否支付？"];
                    MyAlertView * myAlertView = [[MyAlertView alloc] init];
                    [myAlertView showMessage:message withTitle:@"提示" withCancelBtnTitle:@"否" withBtnClick:^(NSInteger buttonIndex){
                        if (buttonIndex == 1) {
                            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"payMentOnResultOnIndexPageVC" object:nil];
                            [Utils setCurrPaymentPage:@"payMentOnResultOnIndexPageVC"];
                            //进行支付
                            NSString * order_id = [order objectForKey:@"id"];
                            Payment * payment = [[[Payment alloc] init] autorelease];
                            [payment createPaymentWithPayGateway:@"alipay_ws_secure"
                                                      objectType:@"PhoneInsuranceOrder"
                                                        objectId:order_id
                                                         subject:@""
                                                        totalFee:0
                                                          detail:@""];
                        }
                    } otherButtonTitles:@"是"];
                    return;
                }
            }
            
            if (orders.count == 1) {
                UserInfoViewController * userInfoVC = [[[UserInfoViewController alloc] init] autorelease];
                userInfoVC.dic = [[obj objectForKey:@"orders"] objectAtIndex:0];
                [self.navigationController pushViewController:userInfoVC animated:YES];
            } else {
                MyOrderViewController * myOrderVC = [[[MyOrderViewController alloc] init] autorelease];
                myOrderVC.myOrderArray = orders;
                [self.navigationController pushViewController:myOrderVC animated:YES];
            }
        } withView:self.view];
        
//        [asynRunner runOnBackground:^{
//            
//            return nil;
//        } onUpdateUI:^(id obj){
//            if (![[obj objectForKey:@"success"] boolValue]) {
//                Show_msg(@"提示", @"获取数据失败");
//                return ;
//            }
//            //获取数据成功
//            //判断是否有未支付的订单，如果有则询问是否支付，如故用户点击不支付则停留在首页否则进入支付流程。如果用户不存在未支付的订单，则判断用户是否有多个保单，如果有多个保单则进入列表否则，如果只有一个保单则进入UserInfoViewController页面
//            NSArray * orders = [obj objectForKey:@"orders"];
//            for (int i=0; i<orders.count; i++) {
//                NSDictionary * order = [orders objectAtIndex:i];
//                int status = [[order objectForKey:@"status"] intValue];
//                NSString * status_label = [order objectForKey:@"status_label"];
//                if (status == 14) {//未支付
//                    NSString * message = [NSString stringWithFormat:@"您有未支付的订单，是否支付？"];
//                    MyAlertView * myAlertView = [[MyAlertView alloc] init];
//                    [myAlertView showMessage:message withTitle:@"提示" withCancelBtnTitle:@"否" withBtnClick:^(NSInteger buttonIndex){
//                        if (buttonIndex == 1) {
//                            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"payMentOnResultOnIndexPageVC" object:nil];
//                            [Utils setCurrPaymentPage:@"payMentOnResultOnIndexPageVC"];
//                            //进行支付
//                            NSString * order_id = [order objectForKey:@"id"];
//                            Payment * payment = [[[Payment alloc] init] autorelease];
//                            [payment createPaymentWithPayGateway:@"alipay_ws_secure"
//                                                      objectType:@"PhoneInsuranceOrder"
//                                                        objectId:order_id
//                                                         subject:@""
//                                                        totalFee:0
//                                                          detail:@""];
//                        }
//                    } otherButtonTitles:@"是"];
//                    return;
//                }
//            }
//            
//            if (orders.count == 1) {
//                UserInfoViewController * userInfoVC = [[[UserInfoViewController alloc] init] autorelease];
//                userInfoVC.dic = [[obj objectForKey:@"orders"] objectAtIndex:0];
//                [self.navigationController pushViewController:userInfoVC animated:YES];
//            } else {
//                MyOrderViewController * myOrderVC = [[[MyOrderViewController alloc] init] autorelease];
//                myOrderVC.myOrderArray = orders;
//                [self.navigationController pushViewController:myOrderVC animated:YES];
//            }
//            
//        } inView:self.view];
    }
}

//用户支付结果处理
-(void)execute:(NSNotification *)notification
{
    AlixPayResult* result = notification.object;
    if (result.statusCode == 6001) {//用户取消付款
        Show_msg(@"提示", @"您已经取消付款");
    }
    NSLog(@"notification:%@",result);
}

@end

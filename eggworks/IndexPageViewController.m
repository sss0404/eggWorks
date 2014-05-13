//
//  IndexPageViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "IndexPageViewController.h"
#import "MobilePhoneEasyViewController.h"
#import "UserInfoViewController.h"
#import "RequestUtils.h"
#import "AsynRuner.h"
#import "MyAlertView.h"
#import "Payment.h"
#import "AlixPayResult.h"
#import "Utils.h"
#import "FinancialMarketMainViewController.h"

@interface IndexPageViewController ()

@end

@implementation IndexPageViewController

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1)
    {
        return NO;
    }
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (IOS7) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = 20;
    }
    
    
    float interval = 3;
    UIImageView * ad = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kApplicationWidth, 144)] autorelease];
    ad.image = [UIImage imageNamed:@"ad"];
    [self.view addSubview:ad];
//    CARelease(ad);
    
    //理财集市
    float financialMarketsHeight = IPhone5 ? 176 : 133.5;
//    float financialMarketsHeight = (kApplicationHeight - 144 - BOTTOM_HEIGHT -15 + ios7_d_height)/2;
    UIButton * financialMarketsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(interval, 144+ios7_d_height,(kApplicationWidth-interval*3)/2 ,financialMarketsHeight)] autorelease];
    [financialMarketsBtn setBackgroundImage:[UIImage imageNamed:@"IndexLCJS"] forState:UIControlStateNormal];
    [financialMarketsBtn addTarget:self action:@selector(financialMarketsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:financialMarketsBtn];
    
    //私享理财
    float privateFinanceY = financialMarketsBtn.frame.size.height + financialMarketsBtn.frame.origin.y+interval;
//    financialMarketsBtn.frame.size.height;
    UIButton * privateFinanceBtn = [[[UIButton alloc] initWithFrame:CGRectMake(interval, privateFinanceY, (kApplicationWidth-interval*3)/2, financialMarketsHeight)] autorelease];
    [privateFinanceBtn setBackgroundImage:[UIImage imageNamed:@"IndexSXLC"] forState:UIControlStateNormal];
    [privateFinanceBtn addTarget:self action:@selector(privateFinanceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:privateFinanceBtn];
    
    float cardBtnHeight = IPhone5 ? 87.5 : 72.5;
    //信用卡
    UIButton * cardBtn = [[[UIButton alloc] initWithFrame:CGRectMake((kApplicationWidth-interval*3)/2 + interval*2, 144+ios7_d_height, (kApplicationWidth-interval*3)/2, cardBtnHeight)] autorelease];
    [cardBtn setBackgroundImage:[UIImage imageNamed:@"IndexXYK"] forState:UIControlStateNormal];
    [cardBtn addTarget:self action:@selector(cardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cardBtn];
    
    float phoneEasyHeight = IPhone5 ? 173.5 : 117.5;
    //手机无忧
    float cardBtnX = cardBtn.frame.origin.x;
    float cardBtnY = cardBtn.frame.origin.y;
//    float cardHeight =  cardBtn.frame.size.height;
    float cardWidth =  cardBtn.frame.size.width;
    UIButton * phoneEasy = [[[UIButton alloc] initWithFrame:CGRectMake(cardBtnX, cardBtnY + cardBtnHeight + interval, cardWidth, phoneEasyHeight)] autorelease];
    [phoneEasy setBackgroundImage:[UIImage imageNamed:@"IndexSJWY"] forState:UIControlStateNormal];
    [phoneEasy addTarget:self action:@selector(phoneEasyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneEasy];
    
    float CarInsuranceBtnHeight = IPhone5 ? 87.5 : 72.5;
    //车险
    float phoneEasyBtnX = phoneEasy.frame.origin.x;
    float phoneEasyBtnY = phoneEasy.frame.origin.y;
//    float phoneEasyHeight =  phoneEasy.frame.size.height;
    float phoneEasyWidth =  phoneEasy.frame.size.width;
    UIButton * CarInsuranceBtn = [[[UIButton alloc] initWithFrame:CGRectMake(phoneEasyBtnX, phoneEasyBtnY + phoneEasyHeight + interval, phoneEasyWidth, CarInsuranceBtnHeight)] autorelease];
    [CarInsuranceBtn setBackgroundImage:[UIImage imageNamed:@"IndexCX"] forState:UIControlStateNormal];
    [CarInsuranceBtn addTarget:self action:@selector(CarInsuranceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CarInsuranceBtn];
}

//理财集市按钮点击事件
-(void)financialMarketsBtnClick:()sender
{
    NSLog(@"理财集市按钮点击事件");
    FinancialMarketMainViewController * financialMarketMainVC = [[[FinancialMarketMainViewController alloc] init] autorelease];
    [self.navigationController pushViewController:financialMarketMainVC animated:YES];
}

//私享理财点击事件
-(void)privateFinanceBtnClick:()sender
{
    NSLog(@"私享理财点击事件");
}

//信用卡点击事件
-(void)cardBtnClick:()sender
{
    NSLog(@"信用卡点击事件");
}

//手机无忧点击事件
-(void)phoneEasyClick:()sender
{
    NSLog(@"手机无忧点击事件");//user_id
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * user_id = [userDefault objectForKey:USER_ID];
    if (user_id.length == 0) {
        MobilePhoneEasyViewController * mobilePE = [[[MobilePhoneEasyViewController alloc] init] autorelease];
        [self.navigationController pushViewController:mobilePE animated:YES];
    } else {
        AsynRuner * asynRunner = [[AsynRuner alloc] init];
        [asynRunner runOnBackground:^{
            RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
            NSDictionary * dic = [requestUtils ordersJson];
            return dic;
        } onUpdateUI:^(id obj){
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
                userInfoVC.dic = obj;
                [self.navigationController pushViewController:userInfoVC animated:YES];
            } else {
                
            }
            
        }];
    }
}

//用户支付结果处理
-(void)execute:(NSNotification *)notification
{
    AlixPayResult* result = notification.object;
    if (result.statusCode == 6001) {//用户取消付款
        Show_msg(@"提示", @"您已经取消付款");
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];//返回首页
    }
        
    NSLog(@"notification:%@",result);
}

//车险点击事件
-(void)CarInsuranceBtnClick:()sender
{
    NSLog(@"车险点击事件");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

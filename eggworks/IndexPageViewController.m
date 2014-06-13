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
#import "LoginViewController.h"
#import "MyAccountViewController.h"
#import "CollectionViewController.h"
#import "RemindViewController.h"
#import "EnjoyPrivateFinanceViewController.h"
#import "MyOrderViewController.h"
#import "IndexButton.h"

enum IndexPageResultCode {
    EnjoyPrivateFinance
};

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
    
//    float ios7_d_height = 0;
//    if (IOS7) {
//        ios7_d_height = 20;
//    }
    
    float iphone5_height = 0;
    if (IPhone5) {
        iphone5_height = 20;
    }
    
//    float interval = 3;
//    UIImageView * ad = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kApplicationWidth, 141)] autorelease];
//    ad.image = [UIImage imageNamed:@"ad"];
//    [self.view addSubview:ad];
////    CARelease(ad);
//    
//    //理财集市
//    float financialMarketsHeight = IPhone5 ? 176 : 133.5;
////    float financialMarketsHeight = (kApplicationHeight - 144 - BOTTOM_HEIGHT -15 + ios7_d_height)/2;
//    UIButton * financialMarketsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(interval, 144+ios7_d_height,(kApplicationWidth-interval*3)/2 ,financialMarketsHeight)] autorelease];
//    [financialMarketsBtn setBackgroundImage:[UIImage imageNamed:@"index_lcjs"] forState:UIControlStateNormal];
//    [financialMarketsBtn setBackgroundImage:[UIImage imageNamed:@"index_lcjs_a"] forState:UIControlStateHighlighted];
//    [financialMarketsBtn addTarget:self action:@selector(financialMarketsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:financialMarketsBtn];
//    
//    UIImageView * financialMarketImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Financial_markets"]]autorelease];
//    financialMarketImg.frame = CGRectMake(52, 20+iphone5_height, 49, 53);
//    [financialMarketsBtn addSubview:financialMarketImg];
//    
//    UILabel * financialMarketsText = [[[UILabel alloc] initWithFrame:CGRectMake(45, 80+iphone5_height, 130, 30)] autorelease];
//    financialMarketsText.text = @"理财集市";
//    financialMarketsText.font = [UIFont systemFontOfSize:16];
//    financialMarketsText.textColor = [UIColor whiteColor];
//    [financialMarketsBtn addSubview:financialMarketsText];
//    
//    
//    //私享理财
//    float privateFinanceY = financialMarketsBtn.frame.size.height + financialMarketsBtn.frame.origin.y+interval;
////    financialMarketsBtn.frame.size.height;
//    UIButton * privateFinanceBtn = [[[UIButton alloc] initWithFrame:CGRectMake(interval, privateFinanceY, (kApplicationWidth-interval*3)/2, financialMarketsHeight)] autorelease];
//    [privateFinanceBtn setBackgroundImage:[UIImage imageNamed:@"index_sxlc"] forState:UIControlStateNormal];
//    [privateFinanceBtn setBackgroundImage:[UIImage imageNamed:@"index_sxlc_a"] forState:UIControlStateHighlighted];
//    [privateFinanceBtn addTarget:self action:@selector(privateFinanceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:privateFinanceBtn];
//    
//    UIImageView * privateFinanceImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thought_financial"]]autorelease];
//    privateFinanceImg.frame = CGRectMake(52, 20+iphone5_height, 49, 53);
//    [privateFinanceBtn addSubview:privateFinanceImg];
//    
//    UILabel * privateFinanceText = [[[UILabel alloc] initWithFrame:CGRectMake(45, 80+iphone5_height, 130, 30)] autorelease];
//    privateFinanceText.text = @"私享理财";
//    privateFinanceText.font = [UIFont systemFontOfSize:16];
//    privateFinanceText.textColor = [UIColor whiteColor];
//    [privateFinanceBtn addSubview:privateFinanceText];
//    
//    
//    float cardBtnHeight = IPhone5 ? 87.5 : 72.5;
//    //信用卡
//    UIButton * cardBtn = [[[UIButton alloc] initWithFrame:CGRectMake((kApplicationWidth-interval*3)/2 + interval*2, 144+ios7_d_height, (kApplicationWidth-interval*3)/2, cardBtnHeight)] autorelease];
//    [cardBtn setBackgroundImage:[UIImage imageNamed:@"index_xyk"] forState:UIControlStateNormal];
//    [cardBtn setBackgroundImage:[UIImage imageNamed:@"index_xyk"] forState:UIControlStateHighlighted];
//    [cardBtn addTarget:self action:@selector(cardBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cardBtn];
//    
//    UIImageView * cardImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"credit_card"]]autorelease];
//    cardImg.frame = CGRectMake(52, 20+iphone5_height, 49.5, 30.5);
//    [cardBtn addSubview:cardImg];
//    
//    UILabel * cardText = [[[UILabel alloc] initWithFrame:CGRectMake(45, 80+iphone5_height, 130, 30)] autorelease];
//    cardText.text = @"信用卡";
//    cardText.font = [UIFont systemFontOfSize:16];
//    cardText.textColor = [UIColor whiteColor];
//    [cardBtn addSubview:cardText];
//    
//    float phoneEasyHeight = IPhone5 ? 173.5 : 117.5;
//    //手机无忧
//    float cardBtnX = cardBtn.frame.origin.x;
//    float cardBtnY = cardBtn.frame.origin.y;
////    float cardHeight =  cardBtn.frame.size.height;
//    float cardWidth =  cardBtn.frame.size.width;
//    UIButton * phoneEasy = [[[UIButton alloc] initWithFrame:CGRectMake(cardBtnX, cardBtnY + cardBtnHeight + interval, cardWidth, phoneEasyHeight)] autorelease];
//    [phoneEasy setBackgroundImage:[UIImage imageNamed:@"index_sjwy"] forState:UIControlStateNormal];
//    [phoneEasy setBackgroundImage:[UIImage imageNamed:@"index_sjwy_a"] forState:UIControlStateNormal];
//    [phoneEasy addTarget:self action:@selector(phoneEasyClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:phoneEasy];
//    
//    UIImageView * phoneEasyImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"phone_easy"]]autorelease];
//    phoneEasyImg.frame = CGRectMake(62, 20+iphone5_height, 30, 51.5);
//    [phoneEasy addSubview:phoneEasyImg];
//    
//    UILabel * phoneEasyText = [[[UILabel alloc] initWithFrame:CGRectMake(45, 80+iphone5_height, 130, 30)] autorelease];
//    phoneEasyText.text = @"手机无忧";
//    phoneEasyText.font = [UIFont systemFontOfSize:16];
//    phoneEasyText.textColor = [UIColor whiteColor];
//    [phoneEasy addSubview:phoneEasyText];
//    
//    float CarInsuranceBtnHeight = IPhone5 ? 87.5 : 72.5;
//    //车险
//    float phoneEasyBtnX = phoneEasy.frame.origin.x;
//    float phoneEasyBtnY = phoneEasy.frame.origin.y;
////    float phoneEasyHeight =  phoneEasy.frame.size.height;
//    float phoneEasyWidth =  phoneEasy.frame.size.width;
//    if (!IPhone5) {
//        CarInsuranceBtnHeight += 1;
//    }
//    UIButton * CarInsuranceBtn = [[[UIButton alloc] initWithFrame:CGRectMake(phoneEasyBtnX, phoneEasyBtnY + phoneEasyHeight + interval, phoneEasyWidth, CarInsuranceBtnHeight)] autorelease];
//    [CarInsuranceBtn setBackgroundImage:[UIImage imageNamed:@"index_cx"] forState:UIControlStateNormal];
//    [CarInsuranceBtn setBackgroundImage:[UIImage imageNamed:@"index_cx"] forState:UIControlStateHighlighted];
//    [CarInsuranceBtn addTarget:self action:@selector(CarInsuranceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:CarInsuranceBtn];
//    
//    UIImageView * CarInsuranceImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car_insurance"]]autorelease];
//    CarInsuranceImg.frame = CGRectMake(52, 20+iphone5_height, 47.5, 26.5);
//    [CarInsuranceBtn addSubview:CarInsuranceImg];
//    
//    UILabel * CarInsuranceText = [[[UILabel alloc] initWithFrame:CGRectMake(45, 80+iphone5_height, 130, 30)] autorelease];
//    CarInsuranceText.text = @"车险";
//    CarInsuranceText.font = [UIFont systemFontOfSize:16];
//    CarInsuranceText.textColor = [UIColor whiteColor];
//    [CarInsuranceBtn addSubview:CarInsuranceText];
    
//    [IndexButton alloc] initWithFrame:CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    float adHeight = 206.75;
    
    if (!IPhone5) {
        adHeight = 206.75 - 35.2;
    }
    IndexButton * ad = [[[IndexButton alloc] initWithFrame:CGRectMake(10, 30, kScreenWidth-20, adHeight)] autorelease];
    ad.backgroundColor = [UIColor colorWithRed:.85 green:.04 blue:.14 alpha:1];
    ad.funcImg.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:ad];
    
    IndexButton * financialMarketsBtn = [[[IndexButton alloc] initWithFrame:CGRectMake(10, 10+ad.frame.origin.y+ad.frame.size.height, 146, IPhone5 ? 123.25 : 123.25-26.4)] autorelease];
    financialMarketsBtn.funcName.text = @"理财集市";
    financialMarketsBtn.describtion.text = @"当日收益最高理财产品排行";
    financialMarketsBtn.funcImg.image = [UIImage imageNamed:@"Financial_markets"];
    financialMarketsBtn.backgroundColor = [UIColor colorWithRed:1 green:.64 blue:.25 alpha:1];
    [financialMarketsBtn addTarget:self action:@selector(financialMarketsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:financialMarketsBtn];
    
    IndexButton * ejoyPrivateFinanceBtn = [[[IndexButton alloc] initWithFrame:CGRectMake(10, 10+financialMarketsBtn.frame.origin.y+financialMarketsBtn.frame.size.height, 146, IPhone5 ? 123.25 : 123.25-26.4)] autorelease];
    ejoyPrivateFinanceBtn.backgroundColor = [UIColor colorWithRed:.28 green:.85 blue:.78 alpha:1];
    ejoyPrivateFinanceBtn.funcName.text = @"私享理财";
    ejoyPrivateFinanceBtn.funcImg.image = [UIImage imageNamed:@"thought_financial"];
    [ejoyPrivateFinanceBtn addTarget:self action:@selector(privateFinanceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ejoyPrivateFinanceBtn];
    
    IndexButton * phoneEasyBtn = [[[IndexButton alloc] initWithFrame:CGRectMake(ejoyPrivateFinanceBtn.frame.origin.x+ejoyPrivateFinanceBtn.frame.size.width+7, financialMarketsBtn.frame.origin.y, 146, IPhone5 ? 256.5 : 256.5-52.8)] autorelease];
    phoneEasyBtn.backgroundColor = [UIColor colorWithRed:.24 green:.69 blue:.88 alpha:1];
    phoneEasyBtn.funcName.text = @"手机无忧";
    phoneEasyBtn.funcImg.image = [UIImage imageNamed:@"phone_easy"];
    [phoneEasyBtn addTarget:self action:@selector(phoneEasyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneEasyBtn];
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
    NSString * account = [Utils getAccount];
    if (account.length == 0) {
        LoginViewController * loginViewVC = [[[LoginViewController alloc] init] autorelease];
        loginViewVC.action = action_return;
        loginViewVC.passingParameters = self;
        loginViewVC.resultCode = EnjoyPrivateFinance;
        [self.navigationController pushViewController:loginViewVC animated:YES];
        return;
    }
    EnjoyPrivateFinanceViewController * enjoyPrivateFinanceVC = [[[EnjoyPrivateFinanceViewController alloc] init] autorelease];
    [self.navigationController pushViewController:enjoyPrivateFinanceVC animated:YES];
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
                userInfoVC.dic = [[obj objectForKey:@"orders"] objectAtIndex:0];
                [self.navigationController pushViewController:userInfoVC animated:YES];
            } else {
                MyOrderViewController * myOrderVC = [[[MyOrderViewController alloc] init] autorelease];
                myOrderVC.myOrderArray = orders;
                [self.navigationController pushViewController:myOrderVC animated:YES];
            }
            
        } inView:self.view];
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

-(void)bottomClick:(id)sender
{
    int tag = ((UIButton*)sender).tag;
    switch (tag) {
        case 0:
            [self remindBtnClick:sender];
            break;
        case 1:
            [self collectionBtnClick:sender];
            break;
        case 2:
            [self accountBtnClick:sender];
            break;
        default:
            break;
    }
    
}

//提醒按钮点击
-(void)remindBtnClick:(id)sender
{
    NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    if (userId.length == 0) {
        //进入登录页面
        [self.navigationController pushViewController:[self getLoginVC] animated:YES];
    } else {
        RemindViewController * remindVC = [[[RemindViewController alloc] init] autorelease];
        [self.navigationController pushViewController:remindVC animated:YES];
    }
}

//收藏按钮点击
-(void)collectionBtnClick:(id)sender
{
    NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    if (userId.length == 0) {
        //进入登录页面
        [self.navigationController pushViewController:[self getLoginVC] animated:YES];
    } else {
        CollectionViewController * collectionVC = [[[CollectionViewController alloc] init] autorelease];
        [self.navigationController pushViewController:collectionVC animated:YES];
    }
}

//账户按钮
-(void)accountBtnClick:(id)sender
{
    NSString * userId = [[NSUserDefaults standardUserDefaults] objectForKey:USER_ID];
    if (userId.length == 0) {
        //进入登录页面
        [self.navigationController pushViewController:[self getLoginVC] animated:YES];
    } else {
        //进入我的账户页面
        MyAccountViewController * myAccountVC = [[[MyAccountViewController alloc] init] autorelease];
        [self.navigationController pushViewController:myAccountVC animated:YES];
    }
}

-(UIViewController*) getLoginVC
{
    LoginViewController * loginVC = [[[LoginViewController alloc] init] autorelease];
    return loginVC;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 返回页面
-(void)completeParameters:(id)obj withTag:(NSString *)tag
{
    if ([tag intValue] == EnjoyPrivateFinance) {//点击私享理财 登录成功后返回
        EnjoyPrivateFinanceViewController * enjoyPrivateFinanceVC = [[[EnjoyPrivateFinanceViewController alloc] init] autorelease];
        [self.navigationController pushViewController:enjoyPrivateFinanceVC animated:YES];
    }
}


@end

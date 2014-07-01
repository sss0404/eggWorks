//
//  ConfirmInformationViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ConfirmInformationViewController.h"
#import "RequestUtils.h"
#import "AsynRuner.h"
#import "MyAlertView.h"
#import "MobilePhoneEasyPaySuccViewController.h"
#import "AlixLibService.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "Payment.h"
#import "Utils.h"

@interface ConfirmInformationViewController ()

@end

@implementation ConfirmInformationViewController

@synthesize product = _product;
@synthesize name =_name;
@synthesize phoneNumber = _phoneNumber;
@synthesize IMEI = _IMEI;
@synthesize boand = _boand;
@synthesize model = _model;


- (void)dealloc
{
    [_product release]; _product = nil;
    [_name release]; _name = nil;
    [_phoneNumber release]; _phoneNumber = nil;
    [_IMEI release]; _IMEI = nil;
    [_boand release]; _boand = nil;
    [_model release]; _model = nil;
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
    
    UIView * aView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, appHeight)] autorelease];
//    aView.backgroundColor = [UIColor redColor];
    [self.view addSubview:aView];
    
    //标题
    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)] autorelease];
    titleLabel.text = @"申购信息";
    titleLabel.textColor = orange_color;
    [aView addSubview:titleLabel];
    
    //分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 2)] autorelease];
    divider.backgroundColor = orange_color;
    [aView addSubview:divider];
    
    //
    UITextView * buyInfo = [[[UITextView alloc] initWithFrame:CGRectMake(20, 60, 280, 80)] autorelease];
    [aView addSubview:buyInfo];
    buyInfo.font = [UIFont systemFontOfSize:14];
    buyInfo.textColor = title_text_color;
    buyInfo.text = [NSString stringWithFormat:@"您已申购“%@”服务。\n服务期为%@到%@，免费维修金额上限为%@\n服务价格为%@元/年",_product.name,[self getCurrDataStr], [self getOneYearAfterDateStr],_product.period, _product.price];
    buyInfo.scrollEnabled = NO;
    buyInfo.editable = NO;
    [aView addSubview:buyInfo];
    
    UILabel * ClaimInfolabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 150, 280, 40)] autorelease];
    ClaimInfolabel.text = @"理赔信息如下:";
    ClaimInfolabel.backgroundColor = [UIColor clearColor];
    ClaimInfolabel.textColor = title_text_color;
    [aView addSubview:ClaimInfolabel];
    
    UILabel * nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 190, 280, 30)] autorelease];
    nameLabel.text = [NSString stringWithFormat:@"姓名：%@",_name];
    nameLabel.textColor = title_text_color;
    [aView addSubview:nameLabel];
    
    UILabel * phoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 220, 280, 30)] autorelease];
    phoneNumberLabel.text = [NSString stringWithFormat:@"手机号：%@",_phoneNumber];
    phoneNumberLabel.textColor = title_text_color;
    [aView addSubview:phoneNumberLabel];
    
    UILabel * ImeiLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 250, 280, 30)] autorelease];
    
    ImeiLabel.text = [NSString stringWithFormat:@"IMEI：%@",_IMEI];
    ImeiLabel.textColor = title_text_color;
    [aView addSubview:ImeiLabel];
    
    UILabel * boandLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 280, 280, 30)] autorelease];
    boandLabel.text = [NSString stringWithFormat:@"品牌型号：%@ %@",_boand,_model];
    boandLabel.textColor = title_text_color;
    [aView addSubview:boandLabel];
    
    UIButton * modifyBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 310, 80, 40)] autorelease];
    [modifyBtn setTitle:@"点击修改" forState:UIControlStateNormal];
    [modifyBtn setTitleColor:orange_color forState:UIControlStateNormal];
    [modifyBtn addTarget:self action:@selector(modifyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:modifyBtn];
    
    UIButton * alipayBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 355, 280, 40)] autorelease];
    [alipayBtn setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [alipayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alipayBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [alipayBtn addTarget:self action:@selector(alipayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [aView addSubview:alipayBtn];
}

-(void)alipayBtnClick:(id)sender
{
    [self submitIsMandatory:NO];
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

//提交
-(void)submitIsMandatory:(BOOL)isMandatory
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(execute:) name:@"payMentOnResultOnConfirmInfoVC" object:nil];
    [Utils setCurrPaymentPage:@"payMentOnResultOnConfirmInfoVC"];
    
    AsynRuner * asynRunner = [[AsynRuner alloc] init];
//    [asynRunner runOnBackground:^{
//        //查询是否有未提交的保单
//        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
//        NSDictionary * dic_ = [requestUtils ordersJson];
//        return dic_;
//    } onUpdateUI:^(id obj){
//        NSArray * orders = [obj objectForKey:@"orders"];
//        for (int i=0; i<orders.count; i++) {
//            NSDictionary * order = [orders objectAtIndex:i];
//            int status = [[order objectForKey:@"status"] intValue];
            //检查是否有未付款的保单   暂时关闭
//            if (status == 14) {//
//                NSString * order_id = [order objectForKey:@"id"];
//                Payment * payment = [[Payment alloc] init];
//                [payment createPaymentWithPayGateway:@"alipay_ws_secure"
//                                          objectType:@"PhoneInsuranceOrder"
//                                            objectId:order_id
//                                             subject:@""
//                                            totalFee:0
//                                              detail:@""];
//                return ;
//            }
            
//            //如果不存在未支付的保单
            [asynRunner runOnBackground:^{
                NSDictionary * dic = [RequestUtils anonymousCreateWithProductId:_product.id_
                                                                       realName:_name
                                                                    mobilePhone:_phoneNumber
                                                                 deviceIdentity:_IMEI
                                                                          brand:_boand
                                                                          model:_model
                                                                          force:isMandatory];
                return dic;
            } onUpdateUI:^(id obj){
                BOOL success = [[obj objectForKey:@"success"] boolValue];
                if (success) {
                    [self submitOnSucc:obj];
                } else {
                    [self submitOnFail:obj];
                }
            } inView:self.view];
//        }
//    }];
}


//提交成功的处理
-(void)submitOnSucc:(NSDictionary*)dic
{
    NSString * order_id = [dic objectForKey:ORDER_ID];
    NSString * user_id = [dic objectForKey:USER_ID];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:order_id forKey:ORDER_ID];
    [userDefault setObject:_phoneNumber forKey:USER_ID];
    [userDefault setObject:_phoneNumber forKey:PHONE_NUMBER];
    NSString * password = [_phoneNumber substringWithRange:NSMakeRange(5,6)];
    [userDefault setObject:password forKey:PASSWORD];
    [userDefault synchronize];
    
    //调用支付宝付款
    Payment * payment = [[[Payment alloc] init] autorelease];
    [payment createPaymentWithPayGateway:@"alipay_ws_secure"
                              objectType:@"PhoneInsuranceOrder"
                                objectId:order_id
                                 subject:@""
                                totalFee:0
                                  detail:@""];
}



//提交失败的处理
-(void)submitOnFail:(NSDictionary*)dic
{
    //获取信息判断是否强制提交
    int  errorCode = [[dic objectForKey:@"error_code"] integerValue];
    MyAlertView * myAlert;
    switch (errorCode) {
        case mobile_phone_easy_phone_already_reg:
            Show_msg(@"提示", @"手机号已被注册");
            break;
        case mobile_phone_easy_phone_202:
            Show_msg(@"提示", @"手机型号不在手机保障服务范围内。");
            break;
        case mobile_phone_easy_wait_activation:
            //提示用户是否强制提交
            myAlert = [[MyAlertView alloc] init];
            [myAlert showMessage:@"有一个待激活的手机保障服务,是否继续自主申购？"
                       withTitle:@"提示"
              withCancelBtnTitle:@"否"
                    withBtnClick:^(NSInteger buttonIndex){
                        if (buttonIndex == 1) {
                            [self submitIsMandatory:YES];
                        }
                    }
               otherButtonTitles:@"继续"];
            break;
        case verification_code_error:
            Show_msg(@"提示", @"验证码错误");
            break;
        default:
            break;
    }
}

////创建支付
//-(void)createPaymentWithPayGateway:(NSString*)pay_gateway objectType:(NSString*)object_type objectId:(NSString*)object_id subject:(NSString*)subject totalFee:(float)total_fee detail:(NSString*)detail
//{
//    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
//    NSDictionary * paymentResult = [requestUtils paymentTransactionsWithPayGateway:pay_gateway
//                                                                        objectType:object_type
//                                                                          objectId:object_id
//                                                                           subject:subject
//                                                                          totalFee:total_fee
//                                                                            detail:detail];
//    BOOL success = [[paymentResult objectForKey:@"success"] boolValue];
//    //创建保单失败
//    if (!success) {
//        NSString * message = [paymentResult objectForKey:@"message"];
//        Show_msg(@"提示", message);
//        return;
//    }
//    //创建保单成功
//    NSString * id_ = [paymentResult objectForKey:@"id"];//生成的支付交易的 ID
//    NSString * order_info = [paymentResult objectForKey:@"order_info"];//调用支付宝接口时需要的订单信息参数
//    NSString * sign_type = [paymentResult objectForKey:@"sign_type"];//签名方式
//    NSString * sign = [paymentResult objectForKey:@"sign"];//签名
//    NSString * notify_url = [paymentResult objectForKey:@"notify_url"];//服务器异步通知路径
//    //调用支付宝
//    NSString *appScheme = @"eggworks";
//    [AlixLibService payOrder:order_info AndScheme:appScheme seletor:@selector(paymentResultDo:) target:self];
//    
//}
//
//
//-(void)paymentResultDo:(NSString*)result
//{
//    NSLog(@"result");
//}


//修改按钮点击事件
-(void)modifyBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//获取当前的时间
-(NSString*)getCurrDataStr
{
    NSDate * currDate = [NSDate date];
    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    NSString *  locationString = [dateformatter stringFromDate:currDate];
    return locationString;
}

//获取一年后的时间
-(NSString*)getOneYearAfterDateStr
{
    NSDateFormatter  *dateformatter=[[[NSDateFormatter alloc] init] autorelease];
    [dateformatter setDateFormat:@"YYYY年MM月dd日"];
    
    NSDate* datenow = [NSDate date];
    NSTimeZone* zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate* localeDate = [datenow dateByAddingTimeInterval:interval];
    long long curr = [localeDate timeIntervalSince1970];
    long long yearM = 60*60*24*365;
    long long oneYearAfter = yearM + curr;//1399297826
    NSLog(@"curr:%lli",oneYearAfter);
    
    NSDate * oneYearAfterD = [NSDate dateWithTimeIntervalSince1970:oneYearAfter];
    NSString *  oneYearAfterString=[dateformatter stringFromDate:oneYearAfterD];
    NSLog(@"locationString:%@",oneYearAfterString);
    return oneYearAfterString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

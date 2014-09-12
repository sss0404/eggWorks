//
//  FinancialProductDetailsViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "FinancialProductDetailsViewController.h"
#import "AsynRuner.h"
#import "RequestUtils.h"
#import "FinancialMarketTableViewCell.h"
#import "MyselfTableViewCell.h"
#import "SBJsonParser.h"
#import "Utils.h"
#import "PaymentPageViewController.h"
#import "LoginViewController.h"
#import "RemindDialog.h"
#import "TimeUtils.h"
#import "ShuMi_Plug_Function.h"
#import "ShuMiDetailViewController.h"
#import "AppDelegate.h"


//收藏产品
#define COLLECTION_PRODUCT @"collection_product"
#define SU_MI @"su_mi"

@interface FinancialProductDetailsViewController ()

@end

@implementation FinancialProductDetailsViewController

@synthesize financialProduct = _financialProduct;
@synthesize productInfoTableView = _productInfoTableView;
@synthesize productInfoBtn = _productInfoBtn;
@synthesize calculateEarningsBtn = _calculateEarningsBtn;
@synthesize aboutProductsBtn = _aboutProductsBtn;
@synthesize productName = _productName;
@synthesize yield = _yield;
@synthesize timesLabel = _timesLabel;
@synthesize monthLastContent = _monthLastContent;
@synthesize yearLastContent = _yearLastContent;
@synthesize calculateEarningsView = _calculateEarningsView;
@synthesize aboutProductsView = _aboutProductsView;
@synthesize asynRunner = _asynRunner;
@synthesize productInfo = _productInfo;
@synthesize aboutProducts = _aboutProducts;
@synthesize investmentAmount = _investmentAmount;
@synthesize baseInterestRates = _baseInterestRates;
@synthesize earningsLabel = _earningsLabel;
@synthesize purchaseAmount = _purchaseAmount;
@synthesize collectionBtn = _collectionBtn;
@synthesize earningsResult = _earningsResult;
@synthesize dialog = _dialog;
@synthesize setRemindBtn = _setRemindBtn;

- (void)dealloc
{
    [NotificationCenter removeObserver:self name:@"onNotification" object:nil];
    [_financialProduct release]; _financialProduct = nil;
    [_productInfoTableView release]; _productInfoTableView = nil;
    [_productInfoBtn release]; _productInfoBtn = nil;
    [_calculateEarningsBtn release]; _calculateEarningsBtn = nil;
    [_aboutProductsBtn release]; _aboutProductsBtn = nil;
    [_productName release]; _productName = nil;
    [_yield release]; _yield = nil;
    [_timesLabel release]; _timesLabel = nil;
    [_monthLastContent release]; _monthLastContent = nil;
    [_yearLastContent release]; _yearLastContent = nil;
    [_calculateEarningsView release]; _calculateEarningsView = nil;
    [_aboutProductsView release]; _aboutProductsView = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_productInfo release]; _productInfo = nil;
    [_aboutProducts release]; _aboutProducts = nil;
    [_investmentAmount release]; _investmentAmount = nil;
    [_baseInterestRates release]; _baseInterestRates = nil;
    [_earningsLabel release]; _earningsLabel = nil;
    [_purchaseAmount release]; _purchaseAmount = nil;
    [_collectionBtn release]; _collectionBtn = nil;
    [_earningsResult release]; _earningsResult = nil;
    [_dialog release]; _dialog = nil;
    [_setRemindBtn release]; _setRemindBtn = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"产品详情";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    _asynRunner = [[AsynRuner alloc] init];
    
    
    
    
    //产品名称
    _productName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+ios7_d_height, 280, 30)];
    _productName.textColor = title_text_color;
//    _productName.text = _financialProduct.name;
    [self.view addSubview:_productName];
    
    UILabel * earningsTitle = [[[UILabel alloc] initWithFrame:CGRectMake(320-90, 30+ios7_d_height, 90, 20)] autorelease];
    earningsTitle.textColor = title_text_color;
    earningsTitle.text = @"是活期收益的";
    earningsTitle.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:earningsTitle];
    
    //收益率
    _yield = [[UILabel alloc] initWithFrame:CGRectMake(20, 45+ios7_d_height, 140, 30)];
    _yield.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
//    _yield.text = [NSString stringWithFormat:@"%@%@",_financialProduct.interest,@"%"];
    _yield.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:25];
    [self.view addSubview:_yield];
    
    //是活期的多少倍
    _timesLabel = [[UILabel alloc] initWithFrame:CGRectMake(320-80, 45+ios7_d_height, 90, 30)];
//    _timesLabel.text = @"1.38";
    _timesLabel.textColor = title_text_color;
    _timesLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:23];
    [self.view addSubview:_timesLabel];
    UILabel * bei = [[[UILabel alloc] initWithFrame:CGRectMake(320-30, 52+ios7_d_height, 20, 20)] autorelease];
    bei.textColor = title_text_color;
    bei.text = @"倍";
    bei.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:bei];
    
    //7日年华收益率   标签   修改为28日年化
    UILabel * day7 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 75+ios7_d_height, 140, 20)] autorelease];
    day7.text = @"28日年化收益率";
    day7.textColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1];
    day7.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:day7];
    
    
    //设置提醒
    self.setRemindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _setRemindBtn.frame = CGRectMake(320-168, 80+ios7_d_height, 70, 25);
    _setRemindBtn.backgroundColor = [UIColor colorWithRed:.85 green:.2 blue:.17 alpha:1];
    [_setRemindBtn setTitle:@"设置提醒" forState:UIControlStateNormal];
    _setRemindBtn.font = [UIFont systemFontOfSize:12];
    [_setRemindBtn addTarget:self action:@selector(setRemindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_setRemindBtn];
    
    //加入收藏
    self.collectionBtn = [[[UIButton alloc] initWithFrame:CGRectMake(320-88, 80+ios7_d_height, 70, 25)] autorelease];
    _collectionBtn.backgroundColor = [UIColor colorWithRed:.19 green:.52 blue:.98 alpha:1];
    [_collectionBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
    [_collectionBtn addTarget:self action:@selector(collectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _collectionBtn.font = [UIFont systemFontOfSize:12];;
    [self.view addSubview:_collectionBtn];
    
    //最近一个月的收益率   7日收益率(货币基金)
    UIView * monthLast = [[[UIView alloc] initWithFrame:CGRectMake(20, 115+ios7_d_height, 137.5, 27)] autorelease];
    monthLast.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.93 alpha:1];
    [self.view addSubview:monthLast];
    
    _monthLastContent = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 68.75, 27)];
    _monthLastContent.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
    _monthLastContent.text = [NSString stringWithFormat:@"%@%@",_financialProduct.interest,@"%"];
    _monthLastContent.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [monthLast addSubview:_monthLastContent];
    
    UILabel * monthLastTitle = [[[UILabel alloc] initWithFrame:CGRectMake(73.75, 0, 68.75, 27)] autorelease];
    if ([_financialProduct.type isEqualToString:@"CashFund"]) {//
        monthLastTitle.text = @"7日年化"; //14 日年化改为7日年化
    } else {
        monthLastTitle.text = @"同类均值";
    }
    
    monthLastTitle.textColor = title_text_color;
    monthLastTitle.font = [UIFont systemFontOfSize:14];
    [monthLast addSubview:monthLastTitle];
    
    //最近一年的收益率    28日(货币基金)
    UIView * yearLast = [[[UIView alloc] initWithFrame:CGRectMake(162.5, 115+ios7_d_height, 137.5, 27)] autorelease];
    yearLast.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.93 alpha:1];
    [self.view addSubview:yearLast];
    
    _yearLastContent = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 68.75, 27)];
    _yearLastContent.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
    _yearLastContent.text = [NSString stringWithFormat:@"%@%@",_financialProduct.interest,@"%"];
    _yearLastContent.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [yearLast addSubview:_yearLastContent];
    
    UILabel * yearLastTitle = [[[UILabel alloc] initWithFrame:CGRectMake(73.75, 0, 68.75, 27)] autorelease];
    if ([_financialProduct.type isEqualToString:@"CashFund"]) {//
        yearLastTitle.text = @"业绩波动";//28日年化 修改为 业绩波动
    } else {
        yearLastTitle.text = @"万元收益差";
    }
    yearLastTitle.textColor = title_text_color;
    yearLastTitle.font = [UIFont systemFontOfSize:12.6];
    [yearLast addSubview:yearLastTitle];
    
    //产品详情按钮
    _productInfoBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 152+ios7_d_height, 280/3, 25)];
    [_productInfoBtn setImage:[UIImage imageNamed:@"product_info_selected"] forState:UIControlStateNormal];
    [_productInfoBtn addTarget:self action:@selector(productInfoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_productInfoBtn];
    
    //计算收益
    _calculateEarningsBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+280/3, 152+ios7_d_height, 280/3, 25)];
    [_calculateEarningsBtn setImage:[UIImage imageNamed:@"calculate_earnings_normal"] forState:UIControlStateNormal];
    [_calculateEarningsBtn addTarget:self action:@selector(calculateEarningsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_calculateEarningsBtn];
    
    //相关产品
    _aboutProductsBtn = [[UIButton alloc] initWithFrame:CGRectMake(20+(280/3)*2, 152+ios7_d_height, 280/3, 25)];
    [_aboutProductsBtn setImage:[UIImage imageNamed:@"about_products_normal"] forState:UIControlStateNormal];
    [_aboutProductsBtn addTarget:self action:@selector(aboutProductsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_aboutProductsBtn];
    
    //立刻申购按钮
    UIButton * buyBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, kApplicationHeight-30, 280, 40)] autorelease];
    buyBtn.backgroundColor = [UIColor colorWithRed:.85 green:.21 blue:.20 alpha:1];
    [buyBtn setTitle:@"立即申购" forState:UIControlStateNormal];
    [buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buyBtn];
    
    //起购金额
    _purchaseAmount = [[UILabel alloc] initWithFrame:CGRectMake(180, 10, 100, 20)];
    _purchaseAmount.font = [UIFont systemFontOfSize:12];
    _purchaseAmount.textColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:0.5];
    [buyBtn addSubview:_purchaseAmount];
    
    //产品详情table
    float tableViewHeight = kApplicationHeight-30 - (177+ios7_d_height)-20;
    _productInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 187+ios7_d_height, 280, tableViewHeight)];
    _productInfoTableView.delegate = self;
    _productInfoTableView.dataSource = self;
    [self.view addSubview:_productInfoTableView];
    _productInfoTableView.tag = 1;
    _productInfoTableView.allowsSelection = NO;
    _productInfoTableView.hidden = NO;
    [_productInfoTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    //计算收益页面
    _calculateEarningsView = [[UIView alloc] initWithFrame:_productInfoTableView.frame];
//    _calculateEarningsView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_calculateEarningsView];
    _calculateEarningsView.hidden = YES;
    [self createCalculateEarningView:_calculateEarningsView];
    
    //相关产品列表
    _aboutProductsView = [[UITableView alloc] initWithFrame:_productInfoTableView.frame];
    [self.view addSubview:_aboutProductsView];
    _aboutProductsView.hidden = YES;
    _aboutProductsView.delegate = self;
    _aboutProductsView.dataSource = self;
    _aboutProductsView.tag = 2;
    [self getProductInfoWithProductId:_financialProduct.id_];
    [_aboutProductsView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    RemindDialog * rd = [[[RemindDialog alloc] initWithFrame:CGRectMake(0, 0, 250, 200)] autorelease];
    rd.days.delegate = self;
    rd.delegate = self;
    self.dialog = [[[Dialog alloc] initWithView:rd] autorelease];
    
    [self.view addSubview:_dialog];
    _dialog.hidden = YES;
}

-(void)onButton:(int)buttonIndex withSelectedItem:(ProductRemindType)productRemindType withRemindDays:(int)days
{
    long long  dayTime = 3600*24 * days;
    NSLog(@"buttonIndex=%i,  productRemindType=%i,    days=%i",buttonIndex,productRemindType,days);
    NSString * type = [_productInfo objectForKey:@"type"];
    NSMutableDictionary * dic = [[[NSMutableDictionary alloc] init] autorelease];
    [dic setObject:[_productInfo objectForKey:@"id"] forKey:@"id"];
    [dic setObject:[_productInfo objectForKey:@"name"] forKey:@"name"];
    if ([type isEqualToString:@"UniversalInsurance"]) {
        //万能险
        if (productRemindType == preSaleType) {
            Show_msg(@"提示", @"万能型不能设置购买提醒。");
            return;
        } else {
            [dic setObject:[_productInfo objectForKey:@"last_profit_month"] forKey:@"to"];
            long long time = [TimeUtils string2LongLongWithStr:[_productInfo objectForKey:@"last_profit_month"]
                                                    withFormat:YYYYMMDD];
            NSString * remindTime = [TimeUtils longlong2StringWithLongLong:time - dayTime withFormate:YYYYMMDDhhmmss];
            [Utils setCalendarWithStartDate:remindTime MainTitle:[_productInfo objectForKey:@"name"] location:@"a"];
        }
    } else {
        //银行理财产品
        if (productRemindType == preSaleType) {
            
            [dic setObject:[[_productInfo objectForKey:@"sales_date"] objectForKey:@"from"] forKey:@"from"];//购买
            [dic setObject:[[_productInfo objectForKey:@"sales_date"] objectForKey:@"to"] forKey:@"to"];
            //添加到日历
            long long time = [TimeUtils string2LongLongWithStr:[[_productInfo objectForKey:@"sales_date"] objectForKey:@"to"]
                                                    withFormat:YYYYMMDD];//销售的截止日期
            NSString * remindTime = [TimeUtils longlong2StringWithLongLong:time - dayTime withFormate:YYYYMMDDhhmmss];
            [Utils setCalendarWithStartDate:remindTime MainTitle:[_productInfo objectForKey:@"name"] location:@"a"];
        } else {
            [dic setObject:[[_productInfo objectForKey:@"interest_period"] objectForKey:@"from"] forKey:@"from"];//到期
            [dic setObject:[[_productInfo objectForKey:@"interest_period"] objectForKey:@"to"] forKey:@"to"];
            //添加到日历
            long long time = [TimeUtils string2LongLongWithStr:[[_productInfo objectForKey:@"interest_period"] objectForKey:@"to"]
                                                    withFormat:YYYYMMDD];
            NSString * remindTime = [TimeUtils longlong2StringWithLongLong:time - dayTime withFormate:YYYYMMDDhhmmss];
            [Utils setCalendarWithStartDate:remindTime MainTitle:[_productInfo objectForKey:@"name"] location:@"a"];
        }
    }
    PreSaleDao * psd = [[[PreSaleDao alloc] init] autorelease];
     [psd addPreSaleProduct:dic withType:productRemindType];
}

-(void)setRemindBtnClick:(id)sender
{
//    SetRemindViewController * setRemindVC = [[[SetRemindViewController alloc] init] autorelease];
//    [self presentViewController:setRemindVC animated:YES completion:^{
//        NSLog(@"页面返回");
//    }];

    _dialog.hidden = NO;
}
//判断用户是否已经绑定数米SDK
-(BOOL)isBind
{
//    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//    BOOL binded = [[userDefault objectForKey:@"binded"] boolValue];
//    return binded;
    AppDelegate * delete = [UIApplication sharedApplication].delegate;
    if (![delete.suMiInfo isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    NSString * tokenKey = [delete.suMiInfo objectForKey:@"tokenKey"];
    
    return tokenKey != nil || tokenKey.length != 0;

}

//立刻申购按钮被点击
-(void)buyBtnClick:(id)sender
{
    //如果用户点击“立即购买”，但是彩蛋财富不能提供在线购买功能的产品跳转到下一页
    //如果是货币基金的话接数米基金的sdk支付，如果不是的话则使用电话和银行
//    NSLog(@"_productInfo:%@",_financialProduct);

    NSString * account =  [Utils getAccount];
    if (account.length == 0) {
//        进入登陆页面
        LoginViewController * loginVC = [[[LoginViewController alloc] init] autorelease];
        loginVC.action = action_return;
        loginVC.passingParameters = self;
        loginVC.resultCode = SU_MI;
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    //检查是否绑定 数米sdk
    if ([self isBind]) {
        [self buy];
    } else {
//        [NotificationCenter addObserver:self selector:nil name:@"onNotification" object:nil];
        [ShuMi_Plug_Function userIdentityVrification:self.navigationController];
    }
}

//申购
-(void)buy
{
    NSString * type =  _financialProduct.type;
    if ([type isEqualToString:@"CashFund"]) {//采用数米基金sdk支付
        [ShuMi_Plug_Function subscribeAndPurchaseFund:[_productInfo objectForKey:@"vendor_product_code"]
                                             fundName:[_productInfo objectForKey:@"name"]
                                            buyAction:@"P"
                                 parentViewController:self.navigationController];
    } else {
        PaymentPageViewController * paymentPageVC = [[[PaymentPageViewController alloc] init] autorelease];
        [self.navigationController pushViewController:paymentPageVC animated:YES];
    }
}

//创建计算收益页面
-(void) createCalculateEarningView:(UIView *) view
{
    UILabel * investmentAmountLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 240, 20)] autorelease];
    investmentAmountLabel.text = @"投资金额:                                                元";
    investmentAmountLabel.font = [UIFont systemFontOfSize:12];
    investmentAmountLabel.textColor = title_text_color;
    [view addSubview:investmentAmountLabel];
    
    _investmentAmount = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, 160, 20)];
    _investmentAmount.text = @"100000";
    _investmentAmount.font = [UIFont systemFontOfSize:12];
    _investmentAmount.textColor = title_text_color;
    _investmentAmount.textAlignment = NSTextAlignmentRight;
    _investmentAmount.delegate = self;
    [view addSubview:_investmentAmount];
    
//    jssy_input@2x  [UIImage imageNamed:@"jssy_input"]
    UIImageView * noteInput = [[[UIImageView alloc] initWithFrame:CGRectMake(18, 22, 240, 6.5)] autorelease];
    noteInput.image = [UIImage imageNamed:@"jssy_input"];
    [view addSubview:noteInput];
    
    UILabel * label1 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 45, 240, 20)] autorelease];
    label1.textColor = title_text_color;
    label1.font = [UIFont systemFontOfSize:12];
    label1.text = @"预期收益率                       投资期限";
    [view addSubview:label1];
    
    //预期收益
    self.earningsLabel = [[[UILabel alloc] initWithFrame:CGRectMake(85, 45, 100, 20)] autorelease];
    _earningsLabel.textColor = [UIColor redColor];
    _earningsLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:_earningsLabel];
    
    UILabel * investmentHorizonLabel = [[[UILabel alloc] initWithFrame:CGRectMake(210, 45, 100, 20)] autorelease];
    investmentHorizonLabel.text = _financialProduct.period;
    investmentHorizonLabel.textColor = [UIColor redColor];
//    investmentHorizonLabel.backgroundColor = [UIColor yellowColor];
    investmentHorizonLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:investmentHorizonLabel];
    
    //计算收益
    UIButton * calculateEarningsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(90, 80, 100, 25)] autorelease];
    [calculateEarningsBtn setTitle:@"计算收益" forState:UIControlStateNormal];
    [calculateEarningsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    calculateEarningsBtn.backgroundColor = [UIColor colorWithRed:.81 green:.12 blue:.13 alpha:1];
    calculateEarningsBtn.font = [UIFont systemFontOfSize:14];
    [calculateEarningsBtn addTarget:self action:@selector(calculateEarningsBtnJS:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:calculateEarningsBtn];
    
    //计算结果
    UILabel * label2 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 125, 100, 20)] autorelease];
    label2.textColor = title_text_color;
    label2.text = @"预期收益：";
    label2.font = [UIFont systemFontOfSize:12];
    [view addSubview:label2];
    
    self.earningsResult = [[[UILabel alloc] initWithFrame:CGRectMake(80, 125, 100, 20)] autorelease];
    _earningsResult.textColor = [UIColor colorWithRed:.81 green:.12 blue:.13 alpha:1];
    _earningsResult.text = @"";
    _earningsResult.font = [UIFont systemFontOfSize:12];
    [view addSubview:_earningsResult];
    
}

-(void)calculateEarningsBtnJS:(id)sender
{
    [_investmentAmount resignFirstResponder];
    double amount = [_investmentAmount.text  doubleValue];//投资金额
    float earnings = [_earningsLabel.text floatValue] / 100.0f;
    _earningsResult.text = [NSString stringWithFormat:@"%@元",[Utils formatFloat:amount*earnings withNumber:1]];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    float ios7_d_height = 0;
//    if (IOS7) {
//        ios7_d_height = IOS7_HEIGHT;
//    }
   
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+50);
}

//产品详情按钮被点击
-(void)productInfoBtnClick:(id) sender
{
    [_productInfoBtn setImage:[UIImage imageNamed:@"product_info_selected"] forState:UIControlStateNormal];
    [_calculateEarningsBtn setImage:[UIImage imageNamed:@"calculate_earnings_normal"] forState:UIControlStateNormal];
    [_aboutProductsBtn setImage:[UIImage imageNamed:@"about_products_normal"] forState:UIControlStateNormal];
    
    _aboutProductsView.hidden = YES;
    _calculateEarningsView.hidden = YES;
    _productInfoTableView.hidden = NO;
}

//计算收益按钮被点击
-(void)calculateEarningsBtnClick:(id) sender
{
    [_productInfoBtn setImage:[UIImage imageNamed:@"product_info_normal"] forState:UIControlStateNormal];
    [_calculateEarningsBtn setImage:[UIImage imageNamed:@"calculate_earnings_selected"] forState:UIControlStateNormal];
    [_aboutProductsBtn setImage:[UIImage imageNamed:@"about_products_normal"] forState:UIControlStateNormal];
    
    _aboutProductsView.hidden = YES;
    _calculateEarningsView.hidden = NO;
    _productInfoTableView.hidden = YES;
    [self calculateEarningsBtnJS:nil];
}

//相关产品按钮被点击
-(void)aboutProductsBtnClick:(id) sender
{
    [_productInfoBtn setImage:[UIImage imageNamed:@"product_info_normal"] forState:UIControlStateNormal];
    [_calculateEarningsBtn setImage:[UIImage imageNamed:@"calculate_earnings_normal"] forState:UIControlStateNormal];
    [_aboutProductsBtn setImage:[UIImage imageNamed:@"about_products_selected"] forState:UIControlStateNormal];
    
    _aboutProductsView.hidden = NO;
    _calculateEarningsView.hidden = YES;
    _productInfoTableView.hidden = YES;
    //查询相关产品
    if (_aboutProducts.count == 0) {
        [self queryAboutProduct:1];
    }
    
}

//通过产品id获取产品详情
-(void)getProductInfoWithProductId:(NSString*)productId
{
//    @try {
        //获取产品详情
        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
        [requestUtils getfinancialInfoWithProductId:productId Callback:^(id obj) {
            [self setProductInfoWith:obj];
            //如果是货币基金则隐藏设置提醒按钮
            _setRemindBtn.hidden = [[obj objectForKey:@"type"] isEqualToString:@"CashFund"];
            
            //接口有问题   暂时注释
            //获取基础利率
            [RequestUtils getBaseInterestRatesWithCallback:^(id obj_) {
                BOOL success = [[obj_ objectForKey:@"success"] boolValue];
                if (success) {
                    NSArray * interestRates = [obj_ objectForKey:@"interest_rates"];
                    for (int i=0; i<interestRates.count; i++) {
                        NSDictionary * dicItem = [interestRates objectAtIndex:i];
                        int type = [[dicItem objectForKey:@"type"] intValue];
                        int quantity = [[[dicItem objectForKey:@"period"] objectForKey:@"quantity"] intValue];
                        if (type == 0 && quantity == 0) {
                            @try {
                                float rate = [[dicItem objectForKey:@"rate"] floatValue];
                                NSString * yieldStr = [obj objectForKey:@"interest_for_sort"];
                                if (yieldStr == [NSNull null]) {
                                    _timesLabel.text = @"";
                                } else {
                                    float yield = [yieldStr floatValue];
                                    float bei = yield / rate;
                                    _timesLabel.text = [NSString stringWithFormat:@"%@",[Utils formatFloat:bei withNumber:1]];
                                }
                            }
                            @catch (NSException *exception) {
                                
                            }
                            @finally {
                                
                            }
                        }
                    }
                }
            } withView:self.view];
        } withView:self.view];
    
}

//获取相关产品的数据
-(void) queryAboutProduct:(int)page
{
    [_asynRunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils getfinancialMarketsWithAreaID:[Utils getCurrRegionId]//获取当前选择的地区
                                                                 partyId:[self.productInfo objectForKey:@"party_id"]
                                                                  period:@"all"
                                                               threshold:@"all"
                                                                    page:page
                                                                 keywork:@""
                                                                   types:@""];
        NSArray * array = [[dic objectForKey:@"data"] objectForKey:@"json"];
        NSMutableArray * financialProductss = [[[NSMutableArray alloc] init] autorelease];
        NSDictionary * dicItem;
        financialProduct * finProduct = nil;
        for (int i=0; i<array.count; i++) {
            dicItem = [array objectAtIndex:i];
            finProduct = [[financialProduct alloc] init];
            finProduct.id_ = [dicItem objectForKey:@"id"];
            finProduct.name = [dicItem objectForKey:@"name"];
            finProduct.partyName = [dicItem objectForKey:@"party_name"];
            finProduct.interest = [dicItem objectForKey:@"interest"];
            finProduct.period = [dicItem objectForKey:@"period"];
            finProduct.threshold = [dicItem objectForKey:@"threshold"];
            finProduct.type = [dicItem objectForKey:@"type"];
            [financialProductss addObject:finProduct];
            [finProduct release]; finProduct = nil;
        }
        return financialProductss;
    } onUpdateUI:^(id obj){
        self.aboutProducts = obj;
        [_aboutProductsView reloadData];
    } inView:self.view];
}

//-(NSString *)formatFloat:(float)value withNumber:(int)numberOfPlace
//{
//    NSString *formatStr = @"%0.";
//    formatStr = [formatStr stringByAppendingFormat:@"%df", numberOfPlace];
//    formatStr = [NSString stringWithFormat:formatStr, value];
//    printf("formatStr %s\n", [formatStr UTF8String]);
//    return formatStr;
//}

//设置产品信息
-(void)setProductInfoWith:(NSDictionary*)dic
{
    @try {
        NSString * type =  _financialProduct.type;
        self.productInfo = dic;
        NSLog(@"type:%@",type);
        _productName.text = [dic objectForKey:@"name"];
        NSString * interest_for_sortTemp = [dic objectForKey:@"interest_for_sort"];
        float interest_for_sort = [interest_for_sortTemp floatValue]*100;
        NSString * interestForSort = [Utils formatFloat:interest_for_sort withNumber:2];
        interestForSort = [NSString stringWithFormat:@"%@%@", interestForSort,@"%"];
        _yield.text = interestForSort;
        _earningsLabel.text = interestForSort;
        NSString * qgje = [dic objectForKey:@"threshold"];
        NSString * favorite_id = [dic objectForKey:@"favorite_id"];//收藏记录的id
        
        @try {
            // 如果是银行理财产品   并且比同类均值低的时候显示绿色  否则显示红色
            if ([type isEqualToString:@"WealthInvestment"] && [[dic objectForKey:@"interest"] floatValue] < [[Utils strConversionWitd:[dic objectForKey:@"average_interest"]] floatValue]) {
                _yield.textColor = [UIColor colorWithRed:.46 green:.76 blue:.30 alpha:1];
            } else {
                _yield.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
            }
        }
        @catch (NSException *exception) {
            NSLog(@"exception:%@" ,exception);
        }
        @finally {
            
        }
        
        if (favorite_id.length == 0) {
            [_collectionBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
        } else {
            [_collectionBtn setTitle:@"取消收藏" forState:UIControlStateNormal];
        }
        
        NSLog(@"qgje:%@",qgje);
        
        _purchaseAmount.text = qgje == [NSNull null] ? @"": [NSString stringWithFormat:@"%@元起购",qgje];
        if ([type isEqualToString:@"CashFund"]) {
            //近一月的收益率   修改为7日年化
            _monthLastContent.text = [self realYields:[[dic objectForKey:@"day_7"] floatValue]];
            _yearLastContent.text = [self getScoreIncome10000WithLevel:[[dic objectForKey:@"score_income_10000"] intValue]];//需要新接口  修改为 业绩波动
        } else {
            _monthLastContent.text = [self realYields:[[Utils strConversionWitd:[dic objectForKey:@"average_interest"]] floatValue]];//同类产品平均收益
            _yearLastContent.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"profit_diff"]];//[NSString stringWithFormat:@"%@元", [Utils formatFloat:[[dic objectForKey:@"profit_diff"] floatValue] withNumber:1]];//同类产品万元收益差
            
        }
        
        [_productInfoTableView reloadData];
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@",exception);
    }
    @finally {
        
    }
    
}

//加入收藏按钮被点击
-(void)collectionBtnClick:(id) sender
{
    NSLog(@"加入收藏");
    
    if ([Utils getAccount].length == 0) {
        LoginViewController * loginVC = [[[LoginViewController alloc] init] autorelease];
        loginVC.action = action_return;
        loginVC.passingParameters = self;
        loginVC.resultCode = COLLECTION_PRODUCT;
        [self.navigationController pushViewController:loginVC animated:YES];
        return;
    }
    [self collectionProduct];
}

//收藏产品
-(void)collectionProduct
{
        if ([_collectionBtn.currentTitle isEqualToString:@"加入收藏"]) {
            [RequestUtils addFavoritesWithObjectType:_financialProduct.type
                                        withObjectId:[_productInfo objectForKey:@"id"]
                                            callback:^(id obj) {
                                                if ([[obj objectForKey:@"success"] boolValue]) {
                                                    Show_msg(@"提示", @"收藏成功");
                                                    [self getProductInfoWithProductId:_financialProduct.id_];
                                                }
        } withView:self.view];
        
    } else {
        //取消收藏
        [RequestUtils deleteFavoritesWithObjectType:[_productInfo objectForKey:@"type"]
                                        andObjectId:[_productInfo objectForKey:@"id"]
                                           callback:^(id obj) {
                                               if ([[obj objectForKey:@"success"] boolValue]) {
                                                   Show_msg(@"提示", @"取消收藏成功");
                                                   [self getProductInfoWithProductId:_financialProduct.id_];
                                               }
        } withView:self.view];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//UniversalInsurance  万能险
- (UITableViewCell *)universalInsuranceTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UniversalInsuranceProductDetailsCell";
    MyselfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[MyselfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    switch (indexPath.row) {
        case 0:
            cell.myLabel.text = [NSString stringWithFormat:@"产品名称  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"name"]]];
            break;
        case 1:
            cell.myLabel.text = [NSString stringWithFormat:@"发行机构  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"party_name"]]];
            break;
        case 2:
            cell.myLabel.text = [NSString stringWithFormat:@"产品状态  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"status"]]];
            break;
        case 3:
            cell.myLabel.text = [NSString stringWithFormat:@"投保年龄  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"require_age"]]];
            break;
        case 4:
            cell.myLabel.text = [NSString stringWithFormat:@"投保约定的保险期限  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"contract_years"]]];
            break;
        case 5:
            cell.myLabel.text = [NSString stringWithFormat:@"最低持有年限  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"actual_years"]]];
            break;
        case 6:
            cell.myLabel.text = [NSString stringWithFormat:@"退保手续费率  %@",[self procedureSurrenderRate:[self.productInfo objectForKey:@"quit_penalties"]]];
            break;
        case 7:
            cell.myLabel.text = [NSString stringWithFormat:@"最低投保金额  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"threshold"]]];
            break;
        case 8:
            cell.myLabel.text = [NSString stringWithFormat:@"保障责任  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"responsibility"]]];
            break;
        case 9:
            cell.myLabel.text = [NSString stringWithFormat:@"保单管理费率  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"manage_fee_rate"]]];
            break;
        case 10:
            cell.myLabel.text = [NSString stringWithFormat:@"保单管理费收取年限  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"manage_fee_years"]]];
            break;
        case 11:
            cell.myLabel.text = [NSString stringWithFormat:@"最新结算收益率  %@",[self realYields:[[self.productInfo objectForKey:@"last_profit_rate"] floatValue]]];
            break;
        case 12:
            cell.myLabel.text = [NSString stringWithFormat:@"最新收益结算日期  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"last_profit_month"]]];
            break;
        case 13:
            cell.myLabel.text = [NSString stringWithFormat:@"实际预期收益率  %@",[self realYields:[[self.productInfo objectForKey:@"interest_for_sort"] floatValue]]];
            break;
        default:
            break;
    }
    return cell;
}

//将float类型的数据转换成百分比的字符串，例如：（15％）
-(NSString*)realYields:(float) realYields
{
    NSString * result = @"";
    result = [NSString stringWithFormat:@"%@％",[Utils formatFloat:realYields * 100.f withNumber:2]];
    return result;
}

//退保手续费率计算
-(NSString*)procedureSurrenderRate:(NSArray*)rate
{
    NSString * str = @"";
//    NSString * baseStr1 = @"%@,%f";
//    NSString * baseStr2 = @"%f";
//    NSString * baseStr = @"";
    if (rate != nil && rate.count != 0) {
        for (NSString * rate_ in rate) {
//            baseStr = str.length == 0 ? baseStr2 : baseStr1;
            if (str.length == 0) {
                str = [NSString stringWithFormat:@"%@％ ", [Utils formatFloat:[rate_ floatValue] / 100.f withNumber:1]];
            } else {
                str = [NSString stringWithFormat:@"%@,%@％ ",str, [Utils formatFloat:[rate_ floatValue] / 100.f withNumber:1]];
            }
        }
    }
    return str;
}

//银行理财产品 cell
- (UITableViewCell *)bankFundtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"bankFundtableViewDetailsCell";
    MyselfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[MyselfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    @try {
        switch (indexPath.row) {
            case 0:
                cell.myLabel.text = [NSString stringWithFormat:@"产品代码  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"vendor_product_code"]]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 机构名称  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"party_name"]]];
                break;
            case 1:
                cell.myLabel.text = [NSString stringWithFormat:@"管理期限  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 购买渠道  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            case 2:
                cell.myLabel.text = [NSString stringWithFormat:@"起购金额  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"threshold"]]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 递增单位  %@",[Utils strConversionWitd:[_productInfo objectForKey:@"increment_unit"]]];
                break;
            case 3:
                cell.myLabel.text = [NSString stringWithFormat:@"销售起止日期  %@~%@",[Utils strConversionWitd:[[_productInfo objectForKey:@"sales_date"] objectForKey:@"from"]],[Utils strConversionWitd:[[_productInfo objectForKey:@"sales_date"] objectForKey:@"to"]]];
                break;
            case 4:
                cell.myLabel.text = [NSString stringWithFormat:@"收益起止日期  %@~%@",[Utils strConversionWitd:[[_productInfo objectForKey:@"interest_period"] objectForKey:@"from"]],[Utils strConversionWitd:[[_productInfo objectForKey:@"interest_period"] objectForKey:@"to"]]];
                break;
            case 5:
                cell.myLabel.text = [NSString stringWithFormat:@"销售地区  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            case 6:
                cell.myLabel.text = [NSString stringWithFormat:@"投资者是否有赎回权  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    
    return cell;
}

//相关产品 cell
-(UITableViewCell * )aboutProductsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aboutProductTableViewCell";
    FinancialMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[FinancialMarketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    @try {
        financialProduct * finProduct = [_aboutProducts objectAtIndex:indexPath.row];
        cell.ExpectedReturnTitle.text = @"预期收益";
        
        cell.ExpectedReturn.text = [NSString stringWithFormat:@"%@%@",[Utils formatFloat:[finProduct.interest floatValue] *100 withNumber:2],@"%"]; //@"5.61%";
        cell.financialProductsName.text = finProduct.name;
        cell.financialProductsDescribtion.text = [NSString stringWithFormat:@"起购金额%@  理财期限%@",[Utils strConversionWitd:finProduct.threshold],[Utils strConversionWitd:finProduct.period]];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return cell;
}


//货币基金 产品cell
- (UITableViewCell *)cashFundtableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"financialProductDetailsCell";
    MyselfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[MyselfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    @try {
        NSString * arrivalDays = [Utils strConversionWitd:[self.productInfo objectForKey:@"arrival_days"]];
        switch (indexPath.row) {
            case 0:
                if ([arrivalDays isEqualToString:@"0"] || arrivalDays.length == 0) {
                    cell.myLabel.text = [NSString stringWithFormat:@"取现时间  实时到账"];
                } else {
                    cell.myLabel.text = [NSString stringWithFormat:@"取现时间  T+%@ 实时到账",arrivalDays];
                }
                cell.myLabel.textColor = [UIColor colorWithRed:.85 green:.21 blue:.20 alpha:1];
                break;
            case 1:
                cell.myLabel.text = [NSString stringWithFormat:@"基金代码  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"vendor_product_code"]]];
                break;
            case 2:
                cell.myLabel.text = [NSString stringWithFormat:@"基金公司  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@"party_name"]]];
                break;
            case 3:
                cell.myLabel.text = [NSString stringWithFormat:@"成立日期  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            case 4:
                cell.myLabel.text = [NSString stringWithFormat:@"管理费    %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 托管费   %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            case 5:
                cell.myLabel.text = [NSString stringWithFormat:@"最新规模  %@亿元",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            case 6:
                cell.myLabel.text = [NSString stringWithFormat:@"基金经理  %@",[Utils strConversionWitd:[self.productInfo objectForKey:@""]]];
                break;
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    return cell;
}

#pragma mark - tableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * type =  _financialProduct.type;
    if (tableView.tag == 1) {
        if (_productInfo == nil) {
            return 0;
        }
        if ([type isEqualToString:@"CashFund"]) {
            return 7;
        } else if([type isEqualToString:@"UniversalInsurance"]) {
            return 14;
        } else {
            return 7;
        }
    } else if(tableView.tag == 2){
        return _aboutProducts.count;
    }
    
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是产品详情tag为1，如果是相关产品tag为2
    if (tableView.tag == 1) {
        NSString * type =  _financialProduct.type;
        if ([type isEqualToString:@"CashFund"]) {//货币基金
            return [self cashFundtableView:tableView cellForRowAtIndexPath:indexPath];
        } else if([type isEqualToString:@"UniversalInsurance"]) {//万能保险
            return [self universalInsuranceTableView:tableView cellForRowAtIndexPath:indexPath];
        } else {//银行理财产品
            return [self bankFundtableView:tableView cellForRowAtIndexPath:indexPath];
        }
    } else if (tableView.tag == 2) {//相关产品
        return [self aboutProductsTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    NSLog(@"fuck");
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    //如果是产品详情tableview 就返回31的高度，如果是相关产品tableview就返回89的高度
    switch (tableView.tag) {
        case 1:
            height = 31;
            break;
        case 2:
            height = 89;
        default:
            break;
    }
    return height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 2) {
        financialProduct * aboutFinancialP = [_aboutProducts objectAtIndex:indexPath.row];
        self.financialProduct = aboutFinancialP;
        [self getProductInfoWithProductId:aboutFinancialP.id_];
        [self productInfoBtnClick:nil];
    }
}


#pragma mark - 从其他页面返回
-(void)completeParameters:(id)obj withTag:(NSString *)tag
{
    if ([tag isEqualToString:COLLECTION_PRODUCT]) {//收藏登录后的页面
        [self collectionProduct];
    } else if([tag isEqualToString:SU_MI]) {
        [self buyBtnClick:nil];
    }
}

//获取万元波动指标
-(NSString*)getScoreIncome10000WithLevel:(int)level
{
    //1 非常小 2 比较小 3 一般 4 比较大 5 非常大
    NSArray * array = @[@"非常小",@"比较小",@"一般",@"比较大",@"非常大"];
    return [array objectAtIndex:level-1];
}


@end

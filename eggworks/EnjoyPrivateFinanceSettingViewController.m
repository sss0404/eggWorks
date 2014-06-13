//
//  EnjoyPrivateFinanceSettingViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "EnjoyPrivateFinanceSettingViewController.h"
#import "CitySelecteViewController.h"
#import "InvestmentAmountViewController.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "BankChoiceViewController.h"

#define CITY_SELECT @"CitySelecteViewController"                    //城市选择
#define INVESTMENT_AMOUNT_SELECT @"InvestmentAmountViewController"  //投资金额
#define ACCOUNT_SELECT @"BankChoiceViewController"                  //资金账户
#define INVESTMENTS_SELECT @"InvestmentsViewController"             //投资品种

@interface EnjoyPrivateFinanceSettingViewController ()

@end

@implementation EnjoyPrivateFinanceSettingViewController

@synthesize city = _city;
@synthesize institutionName = _institutionName;
@synthesize investmentAmount = _investmentAmount;
@synthesize investments = _investments;
@synthesize asynRunner = _asynRunner;
@synthesize citySelected = _citySelected;
@synthesize accountSelected = _accountSelected;
@synthesize investmentAmountSelected = _investmentAmountSelected;
@synthesize investmentsSelected = _investmentsSelected;

- (void)dealloc
{
    [_city release]; _city = nil;
    [_institutionName release]; _institutionName = nil;
    [_investmentAmount release]; _investmentAmount = nil;
    [_investments release]; _investments = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_citySelected release]; _citySelected = nil;
    [_accountSelected release]; _accountSelected = nil;
    [_investmentAmountSelected release]; _investmentAmountSelected = nil;
    [_investmentsSelected release]; _investmentsSelected = nil;
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
    self.title = @"定制需求";
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    
//    UIView * baseView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, kApplicationHeight)] autorelease];
//    [self.view addSubview:baseView];
    
    UITextView * topText = [[[UITextView alloc] initWithFrame:CGRectMake(20, 10, 280, 130)] autorelease];
    topText.scrollEnabled = NO;
    topText.editable = NO;
//    topText.backgroundColor = [UIColor yellowColor];
    topText.font = [UIFont systemFontOfSize:15];
    topText.text = @"为了更快捷、更准确的能帮您选择合适自身的理财产品和有效信息，请根据提示定制您的个性需求：";
    [self.view addSubview:topText];
    
    //所在城市
    self.city = [[[ScreeningItem alloc] initWithFrame:CGRectMake(0, 89+ios7_d_height, 320, 60)] autorelease];
    _city.tag = 1;
    _city.delegate = self;
    _city.label.text = @"所在城市";
    [_city setImageRight:NO];
    [self.view addSubview:_city];
    
    UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(205, 89+ios7_d_height, 120, 60)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton * myLocalBtn = [[[UIButton alloc] initWithFrame:CGRectMake(10, 17, 94, 34.5)] autorelease];
    [myLocalBtn setImage:[UIImage imageNamed:@"myLocal"] forState:UIControlStateNormal];
    [myLocalBtn addTarget:self action:@selector(myLocalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:myLocalBtn];
    
    //资金账户
    self.institutionName = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 149+ios7_d_height, 280, 60)];
    _institutionName.tag = 2;
    _institutionName.delegate = self;
    _institutionName.label.text = @"资金账户";
    [_institutionName.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_institutionName];
    
    //投资金额
    self.investmentAmount = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 209+ios7_d_height, 320, 60)];
    _investmentAmount.tag = 3;
    _investmentAmount.delegate = self;
    _investmentAmount.label.text = @"投资金额";
    [_investmentAmount.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_investmentAmount];
    
    //投资品种
    self.investments = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 269+ios7_d_height, 320, 60)];
    _investments.tag = 4;
    _investments.delegate = self;
    _investments.label.text = @"投资品种";
    [_investments.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_investments];
    
    //立即查看按钮
    UIButton * submitBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, kApplicationHeight - 35, 280, 40)] autorelease];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor colorWithRed:.85 green:.21 blue:.20 alpha:1];
    [self.view addSubview:submitBtn];
    
    [self myLocalBtnClick:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 提交按钮点击事件
-(void)submitClick:(id)sender
{
    NSLog(@"提交");
    //投资金额
    NSString * threshold = @"all";
//    NSDictionary * investmentAmountDic = [_obj objectForKey:@"investmentAmountDic"];
    if (_investmentAmountSelected != nil ) {
        BOOL w10 = [[_investmentAmountSelected objectForKey:@"10w"] boolValue];
        BOOL w10w50 = [[_investmentAmountSelected objectForKey:@"10w50w"] boolValue];
        BOOL w50 = [[_investmentAmountSelected objectForKey:@"50w"] boolValue];
        if (w10) {
            threshold = @"under10";
        }
        if (w10w50) {
            threshold = @"under50";
        }
        if (w50) {
            threshold = @"above50";
        }
    }
    
    //投资品种
    NSString * productTypes = @"";
    if (_investmentsSelected != nil) {
        BOOL bank = [[_investmentsSelected objectForKey:@"bank"] boolValue];   //  银行
        BOOL fund = [[_investmentsSelected objectForKey:@"fund"] boolValue];   // 基金
        BOOL insurance = [[_investmentsSelected objectForKey:@"insurance"] boolValue];  //万能险
        if (bank) {
            productTypes = [NSString stringWithFormat:@"&product_types[]=bank"];
        }
        if (fund) {
            productTypes = [NSString stringWithFormat:@"%@&product_types[]=fund",productTypes];
        }
        if (insurance) {
            productTypes = [NSString stringWithFormat:@"%@&product_types[]=insurance",productTypes];
        }
        
    }
    
    [_asynRunner runOnBackground:^id{
        return [RequestUtils customEnjoyPrivateFinanceWithAreaId:[_citySelected objectForKey:@"id"]
                                                       threshold:threshold
                                                        partyIds:_accountSelected
                                                    productTypes:productTypes];
    } onUpdateUI:^(id obj) {
        BOOL success = [[obj objectForKey:@"success"] boolValue];
        if (success) {
            Show_msg(@"提示", @"定制成功");
        }
    } inView:self.view];
    
}

#pragma mark - 接收其他页面传递的参数
-(void)completeParameters:(id)obj withTag:(NSString *)tag
{
    NSLog(@"tag:%@",tag);
    NSLog(@"传递过来的数据:%@", obj);
    if ([tag isEqualToString:CITY_SELECT]) {
        //城市选择后返回
        self.citySelected = obj;
    } else if([tag isEqualToString:ACCOUNT_SELECT]) {
        //资金账户选择后
        self.accountSelected = obj;
    } else if([tag isEqualToString:INVESTMENT_AMOUNT_SELECT]) {
        //投资金额选择后
        self.investmentAmountSelected = obj;
    } else if([tag isEqualToString:INVESTMENTS_SELECT]) {
        //投资品种选择后
        self.investmentsSelected = obj;
    }
    [self setUiDisplay];
}

#pragma mark - 设置用户选择的页面
-(void)setUiDisplay
{
    [_city.btn setTitle:[_citySelected objectForKey:@"name"] forState:UIControlStateNormal];
    
    //资金账户
    NSString * str = @"";
    for (int i=0; i<_accountSelected.count; i++) {
        str = [NSString stringWithFormat:@"%@%@,",str,[[_accountSelected objectAtIndex:i] objectForKey:@"name"]];
    }
    [_institutionName.btn setTitle:str forState:UIControlStateNormal];
    
    //投资金额选择
    if (_investmentAmountSelected != nil) {
        BOOL w10 = [[_investmentAmountSelected objectForKey:@"10w"] boolValue];
        BOOL w10w50 = [[_investmentAmountSelected objectForKey:@"10w50w"] boolValue];
        BOOL w50 = [[_investmentAmountSelected objectForKey:@"50w"] boolValue];
        NSString * str = @"";
        if (w10) {
            str = @"10万以下";
        }
        if (w10w50) {
            str = @"10万~50万";
        }
        if (w50) {
            str = @"50万以上";
        }
        if ([str isEqualToString:@""]) {
            str = @"不限";
        }
        [_investmentAmount.btn setTitle:str forState:UIControlStateNormal];
    }
    
    //投资品种筛选
    if (_investmentsSelected == nil) {
        [_investments.btn setTitle:@"不限" forState:UIControlStateNormal];
    } else {
        BOOL bank = [[_investmentsSelected objectForKey:@"bank"] boolValue];
        BOOL fund = [[_investmentsSelected objectForKey:@"fund"] boolValue];
        BOOL insurance = [[_investmentsSelected objectForKey:@"insurance"] boolValue];
        NSString * str = @"";
        if (bank) {
            str = @"银行理财产品,";
        }
        if (fund) {
            str = [NSString stringWithFormat:@"%@基金产品,",str];
        }
        if (insurance) {
            str = [NSString stringWithFormat:@"%@保险产品（万能险）",str];
        }
        if ([str isEqualToString:@""]) {
            str = @"不限";
        }
        [_investments.btn setTitle:str forState:UIControlStateNormal];
    }
}

#pragma mark - 定位按钮点击事件
-(void)myLocalBtnClick:(id)sender
{
    NSLog(@"定位按钮点击事件");
    [_asynRunner runOnBackground:^id {
        NSDictionary * city = [RequestUtils getMyCity];
        return city;
    }
                      onUpdateUI:^(id obj) {
                          self.citySelected = obj;
                          [Utils saveCurrCity:obj];
                          [_city.btn setTitle:[obj objectForKey:@"name"] forState:UIControlStateNormal];
                      } inView:self.view];
    
}

#pragma mark - screeningItem delegate method
-(void) onButtonClicked:(id)sender withTag:(int)tag
{
    NSLog(@"tag:%i",tag);
    switch (tag) {
        case 1:
            [self cityClick:sender];
            break;
        case 2:
            [self account:sender];
            break;
        case 3://投资金额
            [self investmentAmount:sender];
            break;
        case 4://投资品种
            [self investments:sender];
            break;
        default:
            break;
    }
}

#pragma mark - 城市选择
-(void)cityClick:(id)sender
{
    CitySelecteViewController * citySelecteVC = [[[CitySelecteViewController alloc] init] autorelease];
    citySelecteVC.passingParameters = self;
    citySelecteVC.resultCode = CITY_SELECT;
    [self.navigationController pushViewController:citySelecteVC animated:YES];
}

#pragma mark - 资金账户
-(void)account:(id)sender
{
    BankChoiceViewController * bankChoiceVC = [[[BankChoiceViewController alloc] init] autorelease];
    bankChoiceVC.passingParameters = self;
    bankChoiceVC.resultCode = ACCOUNT_SELECT;
    [self.navigationController pushViewController:bankChoiceVC animated:YES];
}

#pragma mark - 投资金额
-(void)investmentAmount:(id)sender
{
    InvestmentAmountViewController * investmentAmountVC = [[[InvestmentAmountViewController alloc] init] autorelease];
    investmentAmountVC.passingParameters = self;
    investmentAmountVC.resultCode = INVESTMENT_AMOUNT_SELECT;
    [self.navigationController pushViewController:investmentAmountVC animated:YES];
}

#pragma mark - 投资品种选择
-(void)investments:(id)sender
{
    InvestmentsViewController * investmentsVC = [[[InvestmentsViewController alloc] init] autorelease];
    investmentsVC.passingParameters = self;
    investmentsVC.resultCode = INVESTMENTS_SELECT;
    [self.navigationController pushViewController:investmentsVC animated:YES];
}
@end

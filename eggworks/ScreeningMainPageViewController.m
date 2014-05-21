//
//  ScreeningMainPageViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-15.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ScreeningMainPageViewController.h"
#import "CitySelecteViewController.h"
#import "Utils.h"
#import "RequestUtils.h"
#import "InstitutionalChoiceViewController.h"
#import "InvestmentsViewController.h"
#import "InvestmentAmountViewController.h"
#import "InvestmentHorizonViewController.h"

@interface ScreeningMainPageViewController ()

@end

@implementation ScreeningMainPageViewController

@synthesize searchInputTextField = _searchInputTextField;
@synthesize city = _city;
@synthesize institutionName = _institutionName;
@synthesize investments = _investments;
@synthesize investmentAmount = _investmentAmount;
@synthesize investmentHorizon = _investmentHorizon;
@synthesize asynRunner = _asynRunner;

- (void)dealloc
{
    [_searchInputTextField release]; _searchInputTextField = nil;
    [_city release]; _city = nil;
    [_institutionName release]; _institutionName = nil;
    [_investments release]; _investments = nil;
    [_investmentAmount release]; _investmentAmount = nil;
    [_investmentHorizon release]; _investmentHorizon = nil;
    [_asynRunner release]; _asynRunner = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"筛选条件";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"产品详情";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    _asynRunner = [[ AsynRuner alloc] init];
    
    UIImageView * inputBg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 4+ios7_d_height, 320, 44)] autorelease];
    inputBg.image = [UIImage imageNamed:@"search_input"];
    [self.view addSubview:inputBg];
    
    _searchInputTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 4+ios7_d_height, 240, 44)];
    _searchInputTextField.delegate = self;
    [self.view addSubview:_searchInputTextField];
    
    UIButton * searchBtn = [[[UIButton alloc] initWithFrame:CGRectMake(270, 17+ios7_d_height, 19, 19.5)] autorelease];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_input_confi"] forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    
    //所在城市
    _city = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 49+ios7_d_height, 320, 60)];
    _city.tag = 1;
    _city.delegate = self;
    _city.label.text = @"所在城市";
    [_city setImageRight:NO];
//    NSDictionary * currSelectedCity = [Utils getCurrSelectedCity];
//    [_city.btn setTitle:[currSelectedCity objectForKey:@"name"] forState:UIControlStateNormal];
    [self.view addSubview:_city];
    
    UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(205, 49+ios7_d_height, 120, 60)] autorelease];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton * myLocalBtn = [[[UIButton alloc] initWithFrame:CGRectMake(10, 17, 94, 34.5)] autorelease];
    [myLocalBtn setImage:[UIImage imageNamed:@"myLocal"] forState:UIControlStateNormal];
    [myLocalBtn addTarget:self action:@selector(myLocalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:myLocalBtn];
    
    //机构名称
    _institutionName = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 109+ios7_d_height, 280, 60)];
    _institutionName.tag = 2;
    _institutionName.delegate = self;
    _institutionName.label.text = @"机构名称";
    [_institutionName.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_institutionName];
    
    //投资品种
    _investments = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 169+ios7_d_height, 320, 60)];
    _investments.tag = 3;
    _investments.delegate = self;
    _investments.label.text = @"投资品种";
    [_investments.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_investments];
    
    //投资金额
    _investmentAmount = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 229+ios7_d_height, 320, 60)];
    _investmentAmount.tag = 4;
    _investmentAmount.delegate = self;
    _investmentAmount.label.text = @"投资金额";
    [_investmentAmount.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_investmentAmount];
    
    //投资期限
    _investmentHorizon = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 289+ios7_d_height, 320, 60)];
    _investmentHorizon.tag = 5;
    _investmentHorizon.delegate = self;
    _investmentHorizon.label.text = @"投资期限";
    [_investmentHorizon.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_investmentHorizon];
    
    //立即查看按钮
    UIButton * submitBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, kApplicationHeight - 35, 280, 40)] autorelease];
    [submitBtn setTitle:@"立即查看" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor colorWithRed:.85 green:.21 blue:.20 alpha:1];
    [self.view addSubview:submitBtn];
    
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0,  kApplicationHeight - 45, 320, 1)] autorelease];
    divider3.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [self.view addSubview:divider3];
    
    //设置城市为用户当前所在的城市
    [self myLocalBtnClick:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setCurrSelectedCity];
    //机构筛选结果
    NSArray * institutionals = [InstitutionalChoiceViewController getCurrSelectedInstitutional];
    if (institutionals == nil) {
        [_institutionName.btn setTitle:@"不限" forState:UIControlStateNormal];
    } else {
        NSString * str = [Utils array2String:institutionals with:@","];
        [_institutionName.btn setTitle:str forState:UIControlStateNormal];
    }
    
    //投资品种筛选
    NSMutableDictionary * investments = [InvestmentsViewController getCurrSelectedInvestments];
    if (investments == nil) {
        [_investments.btn setTitle:@"不限" forState:UIControlStateNormal];
    } else {
        BOOL bank = [[investments objectForKey:@"bank"] boolValue];
        BOOL fund = [[investments objectForKey:@"fund"] boolValue];
        BOOL insurance = [[investments objectForKey:@"insurance"] boolValue];
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
        
        [_investments.btn setTitle:str forState:UIControlStateNormal];
    }
    
    //投资金额选择
    NSMutableDictionary * investmentAmount = [InvestmentAmountViewController getCurrSelecteInvestmentAmount];
    if (investments != nil) {
        BOOL w10 = [[investmentAmount objectForKey:@"10w"] boolValue];
        BOOL w10w50 = [[investmentAmount objectForKey:@"10w50w"] boolValue];
        BOOL w50 = [[investmentAmount objectForKey:@"50w"] boolValue];
        if (w10) {
            [_investmentAmount.btn setTitle:@"10万以下" forState:UIControlStateNormal];
        }
        if (w10w50) {
            [_investmentAmount.btn setTitle:@"10万~50万" forState:UIControlStateNormal];
        }
        if (w50) {
            [_investmentAmount.btn setTitle:@"50万以上" forState:UIControlStateNormal];
        }
    }
    
    //
    NSMutableDictionary * investmentHorizon = [InvestmentHorizonViewController getCurrSelectedInvestmentHorizon];
    if (investments != nil) {
        BOOL t30 = [[investmentHorizon objectForKey:@"30t"] boolValue];
        BOOL t30t90 = [[investmentHorizon objectForKey:@"30t90t"] boolValue];
        BOOL t90 = [[investmentHorizon objectForKey:@"90t"] boolValue];
        if (t30) {
            [_investmentHorizon.btn setTitle:@"30天以下" forState:UIControlStateNormal];
        }
        if (t30t90) {
            [_investmentHorizon.btn setTitle:@"30天~90天" forState:UIControlStateNormal];
        }
        if (t90) {
            [_investmentHorizon.btn setTitle:@"90天以上" forState:UIControlStateNormal];
        }
    }
}

//设置当前选择的城市
-(void)setCurrSelectedCity
{
    NSDictionary * currSelectedCity = [Utils getCurrSelectedCity];
    [_city.btn setTitle:[currSelectedCity objectForKey:@"name"] forState:UIControlStateNormal];
}

//我的位置按钮
-(void)myLocalBtnClick:(id)sender
{
    [_asynRunner runOnBackground:^id {
        NSDictionary * city = [RequestUtils getMyCity];
        return city;
    }
                      onUpdateUI:^(id obj) {
                          [Utils saveCurrCity:obj];
                          [_city.btn setTitle:[obj objectForKey:@"name"] forState:UIControlStateNormal];
    }];
}

-(void) submitClick:(id)sender
{
    NSLog(@"提交");
}

#pragma mark - ScreeningItemDelegate
-(void) onButtonClicked:(id)sender withTag:(int)tag
{
    switch (tag) {
        case 1:
            [self cityClick:sender];
            break;
        case 2:
            [self institutionalClick:sender];
            break;
        case 3:
            [self investments:sender];
            break;
        case 4:
            [self investmentAmount:sender];
            break;
        case 5:
            [self investmentHorizonVC:sender];
            break;
        default:
            break;
    }
}

//城市选择
-(void)cityClick:(id)sender
{
    CitySelecteViewController * citySelecteVC = [[[CitySelecteViewController alloc] init] autorelease];
    [self.navigationController pushViewController:citySelecteVC animated:YES];
}

//机构选择
-(void)institutionalClick:(id)sender
{
    InstitutionalChoiceViewController * institutionalChoiceVC = [[[InstitutionalChoiceViewController alloc] init] autorelease];
    [self.navigationController pushViewController:institutionalChoiceVC animated:YES];
}

//投资品种选择
-(void)investments:(id)sender
{
    InvestmentsViewController * investmentsVC = [[[InvestmentsViewController alloc] init] autorelease];
    [self.navigationController pushViewController:investmentsVC animated:YES];
}

//投资金额
-(void)investmentAmount:(id)sender
{
    InvestmentAmountViewController * investmentAmountVC = [[[InvestmentAmountViewController alloc] init] autorelease];
    [self.navigationController pushViewController:investmentAmountVC animated:YES];
}

//投资期限
-(void)investmentHorizonVC:(id)sender
{
    InvestmentHorizonViewController * investmentHorizonVC = [[[InvestmentHorizonViewController alloc] init] autorelease];
    [self.navigationController pushViewController:investmentHorizonVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

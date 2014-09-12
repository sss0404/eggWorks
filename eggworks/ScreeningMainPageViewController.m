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
//@synthesize investments = _investments;
@synthesize investmentAmount = _investmentAmount;
@synthesize investmentHorizon = _investmentHorizon;
@synthesize asynRunner = _asynRunner;
@synthesize dataDic = _dataDic;
@synthesize institutionalsArray = _institutionalsArray;
@synthesize investmentsDic = _investmentsDic;
@synthesize investmentAmountDic = _investmentAmountDic;
@synthesize investmentHorizonDic = _investmentHorizonDic;
@synthesize cityDic = _cityDic;

- (void)dealloc
{
    [_searchInputTextField release]; _searchInputTextField = nil;
    [_city release]; _city = nil;
    [_institutionName release]; _institutionName = nil;
//    [_investments release]; _investments = nil;
    [_investmentAmount release]; _investmentAmount = nil;
    [_investmentHorizon release]; _investmentHorizon = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_dataDic release]; _dataDic = nil;
    [_institutionalsArray release]; _institutionalsArray = nil;
    [_investmentsDic release]; _investmentsDic = nil;
    [_investmentAmountDic release]; _investmentAmountDic = nil;
    [_investmentHorizonDic release]; _investmentHorizonDic = nil;
    [_cityDic release]; _cityDic = nil;
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
    
    self.dataDic = [[[NSMutableDictionary alloc] init] autorelease];
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
    
//    //投资品种
//    _investments = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 169+ios7_d_height, 320, 60)];
//    _investments.tag = 3;
//    _investments.delegate = self;
//    _investments.label.text = @"投资品种";
//    [_investments.btn setTitle:@"不限" forState:UIControlStateNormal];
//    [self.view addSubview:_investments];
    
    //投资金额
    _investmentAmount = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 169+ios7_d_height, 320, 60)];
    _investmentAmount.tag = 4;
    _investmentAmount.delegate = self;
    _investmentAmount.label.text = @"投资金额";
    [_investmentAmount.btn setTitle:@"不限" forState:UIControlStateNormal];
    [self.view addSubview:_investmentAmount];
    
    //投资期限
    _investmentHorizon = [[ScreeningItem alloc] initWithFrame:CGRectMake(0, 229+ios7_d_height, 320, 60)];
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
    self.institutionalsArray = [InstitutionalChoiceViewController getCurrSelectedInstitutional];
    if (_institutionalsArray == nil || _institutionalsArray.count == 0) {
        [_institutionName.btn setTitle:@"不限" forState:UIControlStateNormal];
    } else {
        NSString * str = [Utils array2String:_institutionalsArray with:@","];
        [_institutionName.btn setTitle:str forState:UIControlStateNormal];
    }
    
//    //投资品种筛选
//    self.investmentsDic = [InvestmentsViewController getCurrSelectedInvestments];
//    if (_investmentsDic == nil) {
//        [_investments.btn setTitle:@"不限" forState:UIControlStateNormal];
//    } else {
//        BOOL bank = [[_investmentsDic objectForKey:@"bank"] boolValue];
//        BOOL fund = [[_investmentsDic objectForKey:@"fund"] boolValue];
//        BOOL insurance = [[_investmentsDic objectForKey:@"insurance"] boolValue];
//        NSString * str = @"";
//        if (bank) {
//            str = @"银行理财产品,";
//        }
//        if (fund) {
//            str = [NSString stringWithFormat:@"%@基金产品,",str];
//        }
//        if (insurance) {
//            str = [NSString stringWithFormat:@"%@保险产品（万能险）",str];
//        }
//        if ([str isEqualToString:@""]) {
//            str = @"不限";
//        }
//        [_investments.btn setTitle:str forState:UIControlStateNormal];
//    }
    
    //投资金额选择
    self.investmentAmountDic = [InvestmentAmountViewController getCurrSelecteInvestmentAmount];
    if (_investmentAmountDic != nil) {
        BOOL w10 = [[_investmentAmountDic objectForKey:@"10w"] boolValue];
        BOOL w10w50 = [[_investmentAmountDic objectForKey:@"10w50w"] boolValue];
        BOOL w50 = [[_investmentAmountDic objectForKey:@"50w"] boolValue];
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
    
    //投资期限
    self.investmentHorizonDic = [InvestmentHorizonViewController getCurrSelectedInvestmentHorizon];
    if (_investmentHorizonDic != nil) {
        BOOL activity = [[_investmentHorizonDic objectForKey:@"activity"] boolValue];
        BOOL t30 = [[_investmentHorizonDic objectForKey:@"30t"] boolValue];
        BOOL t30t90 = [[_investmentHorizonDic objectForKey:@"30t90t"] boolValue];
        BOOL t90 = [[_investmentHorizonDic objectForKey:@"90t"] boolValue];
        NSString * str = @"";
        if (activity) {
            str = @"活期";
        }
        if (t30) {
            str = @"1天~30天";
        }
        if (t30t90) {
            str = @"30天~90天";
        }
        if (t90) {
            str = @"90天以上";
        }
        if ([str isEqualToString:@""]) {
            str = @"不限";
        }
        
        [_investmentHorizon.btn setTitle:str forState:UIControlStateNormal];
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
                          if (obj == nil) {
                              Show_msg(@"提示", @"无法获取城市，请您手动选择！");
                              return ;
                          }
                          [Utils saveCurrCity:obj];
                          [_city.btn setTitle:[obj objectForKey:@"name"] forState:UIControlStateNormal];
    } inView:self.view];
}

//立即查看按钮点击事件
-(void) submitClick:(id)sender
{
    NSLog(@"提交");
    self.cityDic = [Utils getCurrSelectedCity] ;
    [_dataDic setObject:_cityDic == nil ? @"" : _cityDic forKey:@"cityDic"];//用户选择的城市
    [_dataDic setObject:_institutionalsArray == nil ? @"" : _institutionalsArray forKey:@"institutionalsArray"];//机构名称
//    [_dataDic setObject:_investmentsDic == nil ? @"" : _investmentsDic forKey:@"investmentsDic"];//投资品种
    [_dataDic setObject:_investmentAmountDic == nil ? @"" : _investmentAmountDic forKey:@"investmentAmountDic"];//投资金额
    [_dataDic setObject:_investmentHorizonDic == nil ? @"" : _investmentHorizonDic forKey:@"investmentHorizonDic"];//投资期限
    [_dataDic setObject:_searchInputTextField.text forKey:@"keyword"];//搜索关键字
    
    [self.passingParameters completeParameters:_dataDic withTag:self.resultCode];
    [self.navigationController popViewControllerAnimated:YES];
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

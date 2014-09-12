//
//  FinancialMarketMainViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "FinancialMarketMainViewController.h"
#import "FinancialMarketTableViewCell.h"
#import "RequestUtils.h"
#import "AsynRuner.h"
#import "FinancialProductDetailsViewController.h"
#import "financialProduct.h"
#import "Utils.h"
#import "ScreeningMainPageViewController.h"

@interface FinancialMarketMainViewController ()

@end

@implementation FinancialMarketMainViewController

@synthesize tableView = _tableView;
@synthesize array = _array;
@synthesize currData = _currData;
@synthesize asynrunner = _asynrunner;
@synthesize obj = _obj;

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_array release]; _array = nil;
    [_currData release]; _currData = nil;
    [_asynrunner release]; _asynrunner = nil;
    [_obj release]; _obj = nil;
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
    
    self.obj = [[[NSMutableDictionary alloc] init] autorelease];
    isLoadState = NO;//表示没有加载
    _asynrunner = [[AsynRuner alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"理财集市";
    
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"search_right_btn"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 52, 44.5);
    [menuBtn addTarget:self action:@selector(menuButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[[UIBarButtonItem alloc] initWithCustomView:menuBtn] autorelease];
    rightBtn.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    float ios7_d_height = 0;
//    if (IOS7) {
//        ios7_d_height = IOS7_HEIGHT;
//    }
    _array = [[NSMutableArray alloc] init];
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appHeight+20)] autorelease];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self getfinancialMarkets:1
                   withAreaID:@"all"
                      partyID:nil
                       period:@"all"
                    threshold:@"all"
                      keywork:@""
                         type:@""];
}

-(void)menuButton:(id)sender
{
    ScreeningMainPageViewController * screeningMainPageVC = [[[ScreeningMainPageViewController alloc] init] autorelease];
    screeningMainPageVC.passingParameters = self;
    [self.navigationController pushViewController:screeningMainPageVC animated:YES];
}

-(void)completeParameters:(id)obj withTag:(NSString *)tag
{
    NSLog(@"接收到参数:%@",obj);
    self.obj = obj;
    [_array removeAllObjects];
    [self getOtherPage:1];
}

//获取理财产品
-(void) getfinancialMarkets:(int)page withAreaID:(NSString*)areaID partyID:(NSArray *)partyID period:(NSString*)period threshold:(NSString*)threshold keywork:(NSString*)keyword type:(NSString*)types
{
    NSLog(@"加载页面:%i",page);
    isLoadState = YES;
    [_asynrunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils getfinancialMarketsWithAreaID:areaID
                                                                 partyId:partyID
                                                                  period:period
                                                               threshold:threshold
                                                                    page:page
                                                                 keywork:keyword
                                                                   types:types];
        self.currData = dic;
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
            finProduct.arrival_days = [[dicItem objectForKey:@"arrival_days"] intValue];
            [financialProductss addObject:finProduct];
            [finProduct release]; finProduct = nil;
        }
        return financialProductss;
    } onUpdateUI:^(id obj){
//        current_page = 1;
        [_array addObjectsFromArray:obj];
        [self.tableView reloadData];
        isLoadState = NO;
    } inView:self.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView det
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FinancialMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[FinancialMarketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    @try {
        financialProduct * finProduct = [_array objectAtIndex:indexPath.row];
        cell.ExpectedReturnTitle.text = @"预期收益";
        if (finProduct.interest != [NSNull null]) {
            cell.ExpectedReturn.text = [NSString stringWithFormat:@"%@%@",[Utils formatFloat:[finProduct.interest floatValue]*100 withNumber:2],@"%"];
        }
        
        cell.financialProductsName.text = finProduct.name;
        if ([finProduct.type isEqualToString:@"CashFund"]) {//货币基金
            cell.financialProductsDescribtion.text = [NSString stringWithFormat:@"起购金额%@  T+%i",finProduct.threshold,finProduct.arrival_days];
        } else {
            cell.financialProductsDescribtion.text = [NSString stringWithFormat:@"起购金额%@  理财期限%@",finProduct.threshold,finProduct.period];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception:%@",exception);
    }
    @finally {
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 89;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击:%i", indexPath.row);
    financialProduct * finProduct = [_array objectAtIndex:indexPath.row];
    FinancialProductDetailsViewController * financialProductDetailsVC = [[[FinancialProductDetailsViewController alloc] init] autorelease];
    NSLog(@"finProduct::::%@",finProduct.type);
    financialProductDetailsVC.financialProduct = finProduct;
    [self.navigationController pushViewController:financialProductDetailsVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float currOffset_y = scrollView.contentOffset.y;
    float scrolly = scrollView.frame.size.height + currOffset_y;
    if (scrollView.contentSize.height - scrolly < 100) {
        int total_pages = [[_currData objectForKey:@"total_pages"] intValue];//总页数
        int current_page = [[_currData objectForKey:@"current_page"] intValue];//当前显示的页数
        if (total_pages == current_page) {
            return;
        }
        if (!isLoadState) {
            [self getOtherPage:current_page+1];
            NSLog(@"加载");
        }
    }
}

-(void)getOtherPage:(int)page
{
    NSString * areaID = @"all";
    NSDictionary * cityDic = [_obj objectForKey:@"cityDic"];
    if (![cityDic isKindOfClass:[NSString class]]) {
        areaID = [cityDic objectForKey:@"id"];//地区id
        if (areaID.length == 0) {
            areaID = @"all";
        }
    }
    
    
    
    NSArray * institutionalsArray = [_obj objectForKey:@"institutionalsArray"];
    NSDictionary * investmentHorizonDic = [_obj objectForKey:@"investmentHorizonDic"];
//    NSDictionary * investmentsDic = [_obj objectForKey:@"investmentsDic"];//投资品种
    
//    //投资品种
//    NSString * productTypes = @"";
//    if (investmentsDic != nil && ![investmentsDic isKindOfClass:[NSString class]]) {
//        BOOL bank = [[investmentsDic objectForKey:@"bank"] boolValue];   //  银行
//        BOOL fund = [[investmentsDic objectForKey:@"fund"] boolValue];   // 基金
//        BOOL insurance = [[investmentsDic objectForKey:@"insurance"] boolValue];  //万能险
//        if (bank) {
//            productTypes = [NSString stringWithFormat:@"&types[]=WealthInvestment"];
//        }
//        if (fund) {
//            productTypes = [NSString stringWithFormat:@"%@&types[]=CashFund",productTypes];
//        }
//        if (insurance) {
//            productTypes = [NSString stringWithFormat:@"%@&types[]=UniversalInsurance",productTypes];
//        }
//    }
    
    
    //投资期限
    NSString * period = @"3";
    if (investmentHorizonDic != nil && ![investmentHorizonDic isKindOfClass:[NSString class]]) {
        BOOL activity = [[investmentHorizonDic objectForKey:@"activity"] boolValue];
        BOOL t30 = [[investmentHorizonDic objectForKey:@"30t"] boolValue];
        BOOL t30t90 = [[investmentHorizonDic objectForKey:@"30t90t"] boolValue];
        BOOL t90 = [[investmentHorizonDic objectForKey:@"90t"] boolValue];
        if (activity) {
            period = @"open";
        }
        if (t30) {
            period = @"0";
        }
        if (t30t90) {
            period = @"1";
        }
        if (t90) {
            period = @"2";
        }
    } else {
        period = @"all";
    }
    
    //投资金额
    NSString * threshold = @"all";
    NSDictionary * investmentAmountDic = [_obj objectForKey:@"investmentAmountDic"];
    if (investmentAmountDic != nil && ![investmentAmountDic isKindOfClass:[NSString class]]) {
        BOOL w10 = [[investmentAmountDic objectForKey:@"10w"] boolValue];
        BOOL w10w50 = [[investmentAmountDic objectForKey:@"10w50w"] boolValue];
        BOOL w50 = [[investmentAmountDic objectForKey:@"50w"] boolValue];
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
    
    NSString * keyword = [_obj objectForKey:@"keyword"];
    //查询筛选过的数据
    [self getfinancialMarkets:page
                   withAreaID:areaID
                      partyID:institutionalsArray
                       period:period//期限
                    threshold:threshold
                      keywork:keyword == nil ? @"" : [keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                         type:@""];
}

-(void)backButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

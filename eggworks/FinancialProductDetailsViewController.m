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

- (void)dealloc
{
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
    
    //7日年华收益率   标签
    UILabel * day7 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 75+ios7_d_height, 140, 20)] autorelease];
    day7.text = @"7日年化收益率";
    day7.textColor = [UIColor colorWithRed:.84 green:.84 blue:.84 alpha:1];
    day7.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:day7];
    
    //加入收藏
    UIButton * collectionBtn = [[[UIButton alloc] initWithFrame:CGRectMake(320-88, 80+ios7_d_height, 70, 25)] autorelease];
    collectionBtn.backgroundColor = [UIColor colorWithRed:.19 green:.52 blue:.98 alpha:1];
    [collectionBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(collectionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    collectionBtn.font = [UIFont systemFontOfSize:12];;
    [self.view addSubview:collectionBtn];
    
    //最近一个月的收益率
    UIView * monthLast = [[[UIView alloc] initWithFrame:CGRectMake(20, 115+ios7_d_height, 137.5, 27)] autorelease];
    monthLast.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.93 alpha:1];
    [self.view addSubview:monthLast];
    
    _monthLastContent = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 68.75, 27)];
    _monthLastContent.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
    _monthLastContent.text = [NSString stringWithFormat:@"%@%@",_financialProduct.interest,@"%"];
    _monthLastContent.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [monthLast addSubview:_monthLastContent];
    
    UILabel * monthLastTitle = [[[UILabel alloc] initWithFrame:CGRectMake(73.75, 0, 68.75, 27)] autorelease];
    monthLastTitle.text = @"近一个月";
    monthLastTitle.textColor = title_text_color;
    monthLastTitle.font = [UIFont systemFontOfSize:14];
    [monthLast addSubview:monthLastTitle];
    
    //最近一年的收益率
    UIView * yearLast = [[[UIView alloc] initWithFrame:CGRectMake(162.5, 115+ios7_d_height, 137.5, 27)] autorelease];
    yearLast.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.93 alpha:1];
    [self.view addSubview:yearLast];
    
    _yearLastContent = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 68.75, 27)];
    _yearLastContent.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
    _yearLastContent.text = [NSString stringWithFormat:@"%@%@",_financialProduct.interest,@"%"];
    _yearLastContent.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [yearLast addSubview:_yearLastContent];
    
    UILabel * yearLastTitle = [[[UILabel alloc] initWithFrame:CGRectMake(73.75, 0, 68.75, 27)] autorelease];
    yearLastTitle.text = @"近一年";
    yearLastTitle.textColor = title_text_color;
    yearLastTitle.font = [UIFont systemFontOfSize:14];
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
    
}



//立刻申购按钮被点击
-(void)buyBtnClick:(id)sender
{
    //如果用户点击“立即购买”，但是彩蛋财富不能提供在线购买功能的产品跳转到下一页
    PaymentPageViewController * paymentPageVC = [[[PaymentPageViewController alloc] init] autorelease];
    [self.navigationController pushViewController:paymentPageVC animated:YES];
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
    _earningsLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 45, 100, 20)];
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
    [view addSubview:calculateEarningsBtn];
    
    //计算结果
    UILabel * label2 = [[[UILabel alloc] initWithFrame:CGRectMake(20, 125, 100, 20)] autorelease];
    label2.textColor = title_text_color;
    label2.text = @"预期收益：";
    label2.font = [UIFont systemFontOfSize:12];
    [view addSubview:label2];
    
    UILabel * earningsResult = [[[UILabel alloc] initWithFrame:CGRectMake(80, 125, 100, 20)] autorelease];
    earningsResult.textColor = [UIColor colorWithRed:.81 green:.12 blue:.13 alpha:1];
    earningsResult.text = @"3164元";
    earningsResult.font = [UIFont systemFontOfSize:12];
    [view addSubview:earningsResult];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
   
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
    @try {
        //获取产品详情
        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
        [_asynRunner runOnBackground:^{
            NSDictionary * dic = [requestUtils getfinancialInfoWithProductId:productId];
            return dic;
        } onUpdateUI:^(id obj){
            [self setProductInfoWith:obj];
            
            //接口有问题   暂时注释
            //获取基础利率
            [_asynRunner runOnBackground:^{
                NSDictionary * dic = [RequestUtils getBaseInterestRates];
                return dic;
            } onUpdateUI:^(id obj_){
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
                                    _timesLabel.text = [NSString stringWithFormat:@"%@",[Utils newFloat:bei withNumber:1]];
                                }
                            }
                            @catch (NSException *exception) {
                                
                            }
                            @finally {
                                
                            }
                            
                            
                        }
                    }
                }
            }];
            
        }];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

//获取相关产品的数据
-(void) queryAboutProduct:(int)page
{
    [_asynRunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils getfinancialMarketsWithAreaID:[Utils getCurrRegionId]//获取当前选择的地区
                                                                 partyId:[self.productInfo objectForKey:@"party_id"]
                                                                  period:@"all"
                                                               threshold:@"all"
                                                                    page:page];
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
    }];
}

//-(NSString *)newFloat:(float)value withNumber:(int)numberOfPlace
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
        NSString * interestForSort = [Utils newFloat:interest_for_sort withNumber:2];
        interestForSort = [NSString stringWithFormat:@"%@%@", interestForSort,@"%"];
        _yield.text = interestForSort;
        _earningsLabel.text = interestForSort;
        NSString * qgje = [dic objectForKey:@"threshold"];
        NSLog(@"qgje:%@",qgje);
        
        _purchaseAmount.text = qgje == [NSNull null] ? @"": [NSString stringWithFormat:@"%@元起购",qgje];
        //    if ([type isEqualToString:@"CashFund"]) {//货币基金
        //        interest_for_sort
        //        float interest_for_sort = [[dic objectForKey:@"interest_for_sort"] floatValue]*100;
        //        NSString * interestForSort = [self newFloat:interest_for_sort withNumber:2];
        //        interestForSort = [NSString stringWithFormat:@"%@%@", interestForSort,@"%"];
        //        _yield.text = interestForSort;
        //        _earningsLabel.text = interestForSort;
        //最近一个月  暂无
        //最近一年    暂无
        
        //        [_aboutProductsView reloadData];
        //    }
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
    
    [_asynRunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils addFavoritesWithObjectType:_financialProduct.type withObjectId:[_productInfo objectForKey:@"id"]];
        return dic;
    } onUpdateUI:^(id obj){
        if ([[obj objectForKey:@"success"] boolValue]) {
            Show_msg(@"提示", @"收藏成功");
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            cell.myLabel.text = [NSString stringWithFormat:@"产品名称  %@",[self.productInfo objectForKey:@"name"]];
            break;
        case 1:
            cell.myLabel.text = [NSString stringWithFormat:@"发行机构  %@",[self.productInfo objectForKey:@"party_name"]];
            break;
        case 2:
            cell.myLabel.text = [NSString stringWithFormat:@"产品状态  %@",[self.productInfo objectForKey:@"status"]];
            break;
        case 3:
            cell.myLabel.text = [NSString stringWithFormat:@"投保年龄  %@",[self.productInfo objectForKey:@"require_age"]];
            break;
        case 4:
            cell.myLabel.text = [NSString stringWithFormat:@"投保约定的保险期限  %@",[self.productInfo objectForKey:@"contract_years"]];
            break;
        case 5:
            cell.myLabel.text = [NSString stringWithFormat:@"最低持有年限  %@",[self.productInfo objectForKey:@"actual_years"]];
            break;
        case 6:
            cell.myLabel.text = [NSString stringWithFormat:@"退保手续费率  %@",[self.productInfo objectForKey:@"quit_penalties"]];
            break;
        case 7:
            cell.myLabel.text = [NSString stringWithFormat:@"最低投保金额  %@",[self.productInfo objectForKey:@"threshold"]];
            break;
        case 8:
            cell.myLabel.text = [NSString stringWithFormat:@"保障责任  %@",[self.productInfo objectForKey:@"responsibility"]];
            break;
        case 9:
            cell.myLabel.text = [NSString stringWithFormat:@"保单管理费率  %@",[self.productInfo objectForKey:@"manage_fee_rate"]];
            break;
        case 10:
            cell.myLabel.text = [NSString stringWithFormat:@"保单管理费收取年限  %@",[self.productInfo objectForKey:@"manage_fee_years"]];
            break;
        case 11:
            cell.myLabel.text = [NSString stringWithFormat:@"最新结算收益率  %@",[self.productInfo objectForKey:@"last_profit_rate"]];
            break;
        case 12:
            cell.myLabel.text = [NSString stringWithFormat:@"最新收益结算日期  %@",[self.productInfo objectForKey:@"last_profit_month"]];
            break;
        case 13:
            cell.myLabel.text = [NSString stringWithFormat:@"实际预期收益率  %@",[self.productInfo objectForKey:@"interest_for_sort"]];
            break;
        default:
            break;
    }
    return cell;
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
                cell.myLabel.text = [NSString stringWithFormat:@"产品代码  %@",[self.productInfo objectForKey:@"vendor_product_code"]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 机构名称  %@",[self.productInfo objectForKey:@"party_name"]];
                break;
            case 1:
                cell.myLabel.text = [NSString stringWithFormat:@"管理期限  %@",[self.productInfo objectForKey:@""]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 购买渠道  %@",[self.productInfo objectForKey:@""]];
                break;
            case 2:
                cell.myLabel.text = [NSString stringWithFormat:@"起购金额  %@",[self.productInfo objectForKey:@"threshold"]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 递增单位  %@",[_productInfo objectForKey:@"increment_unit"]];
                break;
            case 3:
                cell.myLabel.text = [NSString stringWithFormat:@"销售起止日期  %@~%@",[[_productInfo objectForKey:@"sales_date"] objectForKey:@"from"],[[_productInfo objectForKey:@"sales_date"] objectForKey:@"to"]];
                break;
            case 4:
                cell.myLabel.text = [NSString stringWithFormat:@"收益起止日期  %@~%@",[[_productInfo objectForKey:@"interest_period"] objectForKey:@"from"],[[_productInfo objectForKey:@"interest_period"] objectForKey:@"to"]];
                break;
            case 5:
                cell.myLabel.text = [NSString stringWithFormat:@"销售地区  %@",[self.productInfo objectForKey:@""]];
                break;
            case 6:
                cell.myLabel.text = [NSString stringWithFormat:@"投资者是否有赎回权  %@",[self.productInfo objectForKey:@""]];
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
        
        cell.ExpectedReturn.text = [NSString stringWithFormat:@"%@%@",[Utils newFloat:[finProduct.interest floatValue] *100 withNumber:2],@"%"]; //@"5.61%";
        cell.financialProductsName.text = finProduct.name;
        cell.financialProductsDescribtion.text = [NSString stringWithFormat:@"起购金额%@  理财期限%@",finProduct.threshold,finProduct.period];
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
        switch (indexPath.row) {
            case 0:
                cell.myLabel.text = [NSString stringWithFormat:@"取现时间  T+%@ 实时到账",[self.productInfo objectForKey:@"arrival_days"]];
                cell.myLabel.textColor = [UIColor colorWithRed:.85 green:.21 blue:.20 alpha:1];
                break;
            case 1:
                cell.myLabel.text = [NSString stringWithFormat:@"基金代码  %@",[self.productInfo objectForKey:@"vendor_product_code"]];
                break;
            case 2:
                cell.myLabel.text = [NSString stringWithFormat:@"基金公司  %@",[self.productInfo objectForKey:@"party_name"]];
                break;
            case 3:
                cell.myLabel.text = [NSString stringWithFormat:@"成立日期  %@",[self.productInfo objectForKey:@""]];
                break;
            case 4:
                cell.myLabel.text = [NSString stringWithFormat:@"管理费    %@",[self.productInfo objectForKey:@""]];
                cell.secondLabel.text = [NSString stringWithFormat:@"| 托管费   %@",[self.productInfo objectForKey:@""]];
                break;
            case 5:
                cell.myLabel.text = [NSString stringWithFormat:@"最新规模  %@亿元",[self.productInfo objectForKey:@""]];
                break;
            case 6:
                cell.myLabel.text = [NSString stringWithFormat:@"基金经理  %@",[self.productInfo objectForKey:@""]];
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

@end

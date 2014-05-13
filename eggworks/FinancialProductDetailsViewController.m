//
//  FinancialProductDetailsViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-12.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "FinancialProductDetailsViewController.h"
#import "AsynRuner.h"

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
    
    //产品名称
    _productName = [[UILabel alloc] initWithFrame:CGRectMake(20, 10+ios7_d_height, 280, 30)];
    _productName.textColor = title_text_color;
    _productName.text = _financialProduct.name;
    [self.view addSubview:_productName];
    
    UILabel * earningsTitle = [[[UILabel alloc] initWithFrame:CGRectMake(320-90, 30+ios7_d_height, 90, 20)] autorelease];
    earningsTitle.textColor = title_text_color;
    earningsTitle.text = @"是活期收益的";
    earningsTitle.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:earningsTitle];
    
    //收益率
    _yield = [[UILabel alloc] initWithFrame:CGRectMake(20, 45+ios7_d_height, 140, 30)];
    _yield.textColor = [UIColor colorWithRed:.82 green:.27 blue:.27 alpha:1];
    _yield.text = [NSString stringWithFormat:@"%@%@",_financialProduct.interest,@"%"];
    _yield.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:25];
    [self.view addSubview:_yield];
    
    //是活期的多少倍
    _timesLabel = [[UILabel alloc] initWithFrame:CGRectMake(320-80, 45+ios7_d_height, 90, 30)];
    _timesLabel.text = @"1.38";
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
    [self.view addSubview:buyBtn];
    
    //产品详情table
    float tableViewHeight = kApplicationHeight-30 - (177+ios7_d_height)-20;
    _productInfoTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 187+ios7_d_height, 280, tableViewHeight)];
    _productInfoTableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_productInfoTableView];
    _productInfoTableView.hidden = NO;
    
    //计算收益页面
    _calculateEarningsView = [[UIView alloc] initWithFrame:_productInfoTableView.frame];
    _calculateEarningsView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_calculateEarningsView];
    _calculateEarningsView.hidden = YES;
    
    //相关产品列表
    _aboutProductsView = [[UITableView alloc] initWithFrame:_productInfoTableView.frame];
    _aboutProductsView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_aboutProductsView];
    _aboutProductsView.hidden = YES;
    
    
    
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
}

-(void)getProductInfo
{
    AsynRuner
//    RequestUtils
}

//加入收藏按钮被点击
-(void)collectionBtnClick:(id) sender
{
    NSLog(@"加入收藏");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

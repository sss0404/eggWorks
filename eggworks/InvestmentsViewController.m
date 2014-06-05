//
//  InvestmentsViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-21.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "InvestmentsViewController.h"
#import "CheckBox.h"

@interface InvestmentsViewController ()

@end

@implementation InvestmentsViewController

@synthesize bankProduct = _bankProduct;
@synthesize fundProduct = _fundProduct;
@synthesize insuranceProduct = _insuranceProduct;
@synthesize title_ = _title_;


static NSMutableDictionary * currSelected;//当前选择的

+(NSMutableDictionary*)getCurrSelectedInvestments
{
    return currSelected;
}

- (void)dealloc
{
    [_bankProduct release]; _bankProduct = nil;
    [_fundProduct release]; _fundProduct = nil;
    [_insuranceProduct release]; _insuranceProduct = nil;
    [_title_ release]; _title_ = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"投资品种";
    
    if (currSelected == nil) {
        currSelected = [[NSMutableDictionary alloc] init];
    }
    
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    UIView * titleBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, 40)] autorelease];
    titleBg.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [self.view addSubview:titleBg];
    
    self.title_ = [[[UILabel alloc] initWithFrame:CGRectMake(20, 7, 320, 30)] autorelease];
    _title_.text = @"理财类型";
    [titleBg addSubview:_title_];
    
    //分割线
    UIView * divider1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 1)] autorelease];
    divider1.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [titleBg addSubview:divider1];
    
    UIView * bankBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 41+ios7_d_height, 320, 50)] autorelease];
//    bg.backgroundColor = [UIColor redColor];
    [self.view addSubview:bankBg];
    
    //分割线
    UIView * bankProductDivider2 = [[[UIView alloc] initWithFrame:CGRectMake(20, 50, 320, 1)] autorelease];
    bankProductDivider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [bankBg addSubview:bankProductDivider2];
    
    self.bankProduct = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 17.5, 320, 15)] autorelease];
    _bankProduct.title.text = @"银行理财产品";
    [bankBg addSubview:_bankProduct];
    
    
    //基金产品
    UIView * fundProductBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 92+ios7_d_height, 320, 50)] autorelease];
    //    bg.backgroundColor = [UIColor redColor];
    [self.view addSubview:fundProductBg];
    
    //分割线
    UIView * fundProductDivider2 = [[[UIView alloc] initWithFrame:CGRectMake(20, 50, 320, 1)] autorelease];
    fundProductDivider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [fundProductBg addSubview:fundProductDivider2];
    
    self.fundProduct = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 17.5, 320, 15)] autorelease];
    _fundProduct.title.text = @"基金产品";
    [fundProductBg addSubview:_fundProduct];
    
    //基金产品
    UIView * insuranceProductBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 142+ios7_d_height, 320, 50)] autorelease];
    //    bg.backgroundColor = [UIColor redColor];
    [self.view addSubview:insuranceProductBg];
    
    //分割线
    UIView * insuranceProductDivider2 = [[[UIView alloc] initWithFrame:CGRectMake(20, 50, 320, 1)] autorelease];
    insuranceProductDivider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [insuranceProductBg addSubview:insuranceProductDivider2];
    
    self.insuranceProduct = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 17.5, 320, 15)] autorelease];
    _insuranceProduct.title.text = @"保险产品（万能险）";
    [insuranceProductBg addSubview:_insuranceProduct];
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    divider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [self.view addSubview:divider2];
    
    UIView * tempView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, kApplicationHeight+20 - 60, 320, 60)] autorelease];
    //    tempView2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tempView2];
    [tempView2 addSubview:divider2];
    
    UIButton * confgBtn = [[[UIButton alloc] initWithFrame:CGRectMake(140, 10, 151, 37.5)] autorelease];
    [confgBtn setImage:[UIImage imageNamed:@"okBtnSmall"] forState:UIControlStateNormal];
    [confgBtn addTarget:self action:@selector(confgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempView2 addSubview:confgBtn];
    
    UIButton * resultBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 101.5, 37.5)] autorelease];
    [resultBtn setImage:[UIImage imageNamed:@"result"] forState:UIControlStateNormal];
    [resultBtn addTarget:self action:@selector(resultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempView2 addSubview:resultBtn];
    
    BOOL bank = [[currSelected objectForKey:@"bank"] boolValue];
    [self.bankProduct setCheck:bank];
    
    BOOL fund = [[currSelected objectForKey:@"fund"] boolValue];
    [self.fundProduct setCheck:fund];
    
    BOOL insurance = [[currSelected objectForKey:@"insurance"] boolValue];
    [self.insuranceProduct setCheck:insurance];
}

//确认按钮
-(void)confgBtnClick:(id)sender
{
    NSLog(@"银行理财：%@",_bankProduct.selected ? @"选中" :@"未选中");
    NSLog(@"基金理财：%@",_fundProduct.selected ? @"选中" :@"未选中");
    NSLog(@"保险理财：%@",_insuranceProduct.selected ? @"选中" :@"未选中");
    
    [currSelected setValue:[NSNumber numberWithBool:_bankProduct.selected] forKey:@"bank"];
    [currSelected setValue:[NSNumber numberWithBool:_fundProduct.selected] forKey:@"fund"];
    [currSelected setValue:[NSNumber numberWithBool:_insuranceProduct.selected] forKey:@"insurance"];
    [self.passingParameters completeParameters:currSelected withTag:self.resultCode];
    [self.navigationController popViewControllerAnimated:YES];
    
}

//重置按钮
-(void)resultBtnClick:(id)sender
{
    NSLog(@"重置按钮");
    [_bankProduct setCheck:NO];
    [_fundProduct setCheck:NO];
    [_insuranceProduct setCheck:NO];
    
    [currSelected removeAllObjects];
    [currSelected setValue:[NSNumber numberWithBool:NO] forKey:@"bank"];
    [currSelected setValue:[NSNumber numberWithBool:NO] forKey:@"fund"];
    [currSelected setValue:[NSNumber numberWithBool:NO] forKey:@"insurance"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  InvestmentHorizonViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-21.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "InvestmentHorizonViewController.h"

@interface InvestmentHorizonViewController ()

@end

@implementation InvestmentHorizonViewController

@synthesize activitys = _activitys;

static NSMutableDictionary * investmentHorizon;

- (void)dealloc
{
    [_activitys release]; _activitys = nil;
    [super dealloc];
}

+(NSMutableDictionary*)getCurrSelectedInvestmentHorizon
{
    return investmentHorizon;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    if (investmentHorizon == nil) {
        investmentHorizon = [[NSMutableDictionary alloc] init];
    }
    
    BOOL activity = [[investmentHorizon objectForKey:@"activity"] boolValue];
    BOOL t30 = [[investmentHorizon objectForKey:@"30t"] boolValue];
    BOOL t30t90 = [[investmentHorizon objectForKey:@"30t90t"] boolValue];
    BOOL t90 = [[investmentHorizon objectForKey:@"90t"] boolValue];
    
    self.title = @"投资期限";
    self.title_.text = @"理财期限";
    
    self.bankProduct.title.text = @"活期";
    [self.bankProduct setCheck:activity];
    
    self.fundProduct.title.text = @"1天～30天";
    [self.fundProduct setCheck:t30];
    
    self.insuranceProduct.title.text = @"30天～90天";
    [self.insuranceProduct setCheck:t30t90];
    
    
    
    //基金产品
    UIView * insuranceProductBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 192+ios7_d_height, 320, 50)] autorelease];
    //    bg.backgroundColor = [UIColor redColor];
    [self.view addSubview:insuranceProductBg];
    
    //分割线
    UIView * insuranceProductDivider2 = [[[UIView alloc] initWithFrame:CGRectMake(20, 50, 320, 1)] autorelease];
    insuranceProductDivider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [insuranceProductBg addSubview:insuranceProductDivider2];
    
    self.activitys = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 17.5, 320, 15)] autorelease];
    _activitys.title.text = @"90天以上";
    [self.activitys addTarget:self action:@selector(activitysClick:) forControlEvents:UIControlEventTouchUpInside];
    [insuranceProductBg addSubview:_activitys];
    [self.activitys setCheck:t90];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//确认按钮
-(void)confgBtnClick:(id)sender
{
    NSLog(@"30天以下：%@",self.bankProduct.selected ? @"选中" :@"未选中");
    NSLog(@"30天～90天：%@",self.fundProduct.selected ? @"选中" :@"未选中");
    NSLog(@"90天以上：%@",self.insuranceProduct.selected ? @"选中" :@"未选中");
    
    [investmentHorizon setValue:[NSNumber numberWithBool:self.bankProduct.selected] forKeyPath:@"activity"];
    [investmentHorizon setValue:[NSNumber numberWithBool:self.fundProduct.selected] forKey:@"30t"];
    [investmentHorizon setValue:[NSNumber numberWithBool:self.insuranceProduct.selected] forKey:@"30t90t"];
    [investmentHorizon setValue:[NSNumber numberWithBool:self.activitys.selected] forKey:@"90t"];
    [self.navigationController popViewControllerAnimated:YES];
}


//重置按钮
-(void)resultBtnClick:(id)sender
{
    NSLog(@"重置按钮");
    [self.activitys setCheck:NO];
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:NO];
    
    
    
    [investmentHorizon removeAllObjects];
    [investmentHorizon setValue:[NSNumber numberWithBool:NO] forKey:@"activity"];
    [investmentHorizon setValue:[NSNumber numberWithBool:NO] forKey:@"30t"];
    [investmentHorizon setValue:[NSNumber numberWithBool:NO] forKey:@"30t90t"];
    [investmentHorizon setValue:[NSNumber numberWithBool:NO] forKey:@"90t"];

}




//10w以上被点击
-(void)bancProductClick:(id)sender
{
    [self.bankProduct setCheck:YES];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:NO];
    [self.activitys setCheck:NO];
}

-(void)fundProductClick:(id)sender
{
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:YES];
    [self.insuranceProduct setCheck:NO];
    [self.activitys setCheck:NO];
}

-(void)insuranceProductClick:(id)sender
{
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:YES];
    [self.activitys setCheck:NO];
}

-(void)activitysClick:(id)sender
{
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:NO];
    [self.activitys setCheck:YES];
}

@end

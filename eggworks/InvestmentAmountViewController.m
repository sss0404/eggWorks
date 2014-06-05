//
//  InvestmentAmountViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-21.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "InvestmentAmountViewController.h"

@interface InvestmentAmountViewController ()

@end

@implementation InvestmentAmountViewController


static NSMutableDictionary * investmentAmount;


+(NSMutableDictionary*)getCurrSelecteInvestmentAmount
{
    return investmentAmount;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    if (investmentAmount == nil) {
        investmentAmount = [[NSMutableDictionary alloc] init];
    }
    
    BOOL w10 = [[investmentAmount objectForKey:@"10w"] boolValue];
    BOOL w10w50 = [[investmentAmount objectForKey:@"10w50w"] boolValue];
    BOOL w50 = [[investmentAmount objectForKey:@"50w"] boolValue];
    
    self.title = @"投资金额";
    self.title_.text = @"理财金额";
    self.bankProduct.title.text = @"10万以下";
    [self.bankProduct setCheck:w10];
    
    self.fundProduct.title.text = @"10万～50万";
    [self.fundProduct setCheck:w10w50];
    
    self.insuranceProduct.title.text = @"50万以上";
    [self.insuranceProduct setCheck:w50];
    
    [self.bankProduct addTarget:self action:@selector(bancProductClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.fundProduct addTarget:self action:@selector(fundProductClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.insuranceProduct addTarget:self action:@selector(insuranceProductClick:) forControlEvents:UIControlEventTouchUpInside];
}

//10w以上被点击
-(void)bancProductClick:(id)sender
{
    [self.bankProduct setCheck:YES];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:NO];
    
}

-(void)fundProductClick:(id)sender
{
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:YES];
    [self.insuranceProduct setCheck:NO];
    
}

-(void)insuranceProductClick:(id)sender
{
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:YES];
    
}

//确认按钮
-(void)confgBtnClick:(id)sender
{
    NSLog(@"10w：%@",self.bankProduct.selected ? @"选中" :@"未选中");
    NSLog(@"10w~50w：%@",self.fundProduct.selected ? @"选中" :@"未选中");
    NSLog(@"50w：%@",self.insuranceProduct.selected ? @"选中" :@"未选中");
    
    [investmentAmount setValue:[NSNumber numberWithBool:self.bankProduct.selected] forKey:@"10w"];
    [investmentAmount setValue:[NSNumber numberWithBool:self.fundProduct.selected] forKey:@"10w50w"];
    [investmentAmount setValue:[NSNumber numberWithBool:self.insuranceProduct.selected] forKey:@"50w"];
    [self.passingParameters completeParameters:investmentAmount withTag:self.resultCode];
    [self.navigationController popViewControllerAnimated:YES];
}

//重置按钮
-(void)resultBtnClick:(id)sender
{
    NSLog(@"重置按钮");
    [self.bankProduct setCheck:NO];
    [self.fundProduct setCheck:NO];
    [self.insuranceProduct setCheck:NO];
    
    
    
    [investmentAmount removeAllObjects];
    [investmentAmount setValue:[NSNumber numberWithBool:NO] forKey:@"10w"];
    [investmentAmount setValue:[NSNumber numberWithBool:NO] forKey:@"10w50w"];
    [investmentAmount setValue:[NSNumber numberWithBool:NO] forKey:@"50w"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

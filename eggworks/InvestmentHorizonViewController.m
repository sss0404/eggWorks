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

static NSMutableDictionary * investmentHorizon;

+(NSMutableDictionary*)getCurrSelectedInvestmentHorizon
{
    return investmentHorizon;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (investmentHorizon == nil) {
        investmentHorizon = [[NSMutableDictionary alloc] init];
    }
    
    BOOL t30 = [[investmentHorizon objectForKey:@"30t"] boolValue];
    BOOL t30t90 = [[investmentHorizon objectForKey:@"30t90t"] boolValue];
    BOOL t90 = [[investmentHorizon objectForKey:@"90t"] boolValue];
    
    self.title = @"投资期限";
    self.title_.text = @"理财期限";
    self.bankProduct.title.text = @"30天以下";
    [self.bankProduct setCheck:t30];
    
    self.fundProduct.title.text = @"30天～90天";
    [self.fundProduct setCheck:t30t90];
    
    self.insuranceProduct.title.text = @"90天以上";
    [self.insuranceProduct setCheck:t90];
    
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
    
    [investmentHorizon setValue:[NSNumber numberWithBool:self.bankProduct.selected] forKey:@"30t"];
    [investmentHorizon setValue:[NSNumber numberWithBool:self.fundProduct.selected] forKey:@"30t90t"];
    [investmentHorizon setValue:[NSNumber numberWithBool:self.insuranceProduct.selected] forKey:@"90t"];
    [self.navigationController popViewControllerAnimated:YES];
}



@end

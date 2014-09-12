//
//  RemindViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RemindViewController.h"
#import "PreSaleDao.h"
#import "RemindTableViewCell.h"
#import "FinancialProductDetailsViewController.h"
#import "Utils.h"

@interface RemindViewController ()

@end

@implementation RemindViewController

@synthesize preSaleProductsRemind = _preSaleProductsRemind;
@synthesize maturityProductsRemind = _maturityProductsRemind;
@synthesize preSaleProductArray = _preSaleProductArray;
@synthesize maturityProductArray = _maturityProductArray;
@synthesize asynRunner = _asynRunner;


- (void)dealloc
{
    [_preSaleProductsRemind release];
    [_preSaleProductArray release];
    [_maturityProductArray release];
    [_maturityProductsRemind release];
    [_asynRunner release]; _asynRunner = nil;
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    self.title = @"闹钟提醒";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    self.preSaleProductsRemind = [[[Remind alloc] initWithFrame:CGRectMake(0, ios7_d_height, kScreenWidth, (kScreenHeight-65)/2)] autorelease];
    _preSaleProductsRemind.mainTitle.text = @"预售产品提醒";
    _preSaleProductsRemind.tableViewDataSource = self;
    _preSaleProductsRemind.tableViewDelegate = self;
    _preSaleProductsRemind.tableView.tag = 1;
    [self.view addSubview:_preSaleProductsRemind];
    
    self.maturityProductsRemind = [[[Remind alloc] initWithFrame:CGRectMake(0, ios7_d_height+(kScreenHeight-65)/2, kScreenWidth, (kScreenHeight-65)/2)] autorelease];
    _maturityProductsRemind.mainTitle.text = @"到期产品提醒";
    _maturityProductsRemind.tableViewDataSource = self;
    _maturityProductsRemind.tableViewDelegate = self;
    _maturityProductsRemind.tableView.tag = 2;
    [self.view addSubview:_maturityProductsRemind];
    
}


-(void)getRemind
{
    [_asynRunner runOnBackground:^id{
        PreSaleDao * psd = [[[PreSaleDao alloc] init] autorelease];
        NSArray * array = [psd queryPreSaleProductWithType:preSaleType];
        NSArray * array2 = [psd queryPreSaleProductWithType:remindType];
        self.preSaleProductArray = array;
        self.maturityProductArray = array2;
        return _preSaleProductArray;
    } onUpdateUI:^(id obj) {
        [self.preSaleProductsRemind.tableView reloadData];
        [self.maturityProductsRemind.tableView reloadData];
    } inView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self getRemind];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableView.tag == 1 ? _preSaleProductArray.count : _maturityProductArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    RemindTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[RemindTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
    }
    NSDictionary * dic = nil;
    NSString * contentShow = nil;
    if (tableView.tag == 1) {
        dic = [_preSaleProductArray objectAtIndex:indexPath.row];
        cell.title.text = [dic objectForKey:@"name"];
        float startDay = [[dic objectForKey:@"saleStartDay"] floatValue];
        float endDay = [[dic objectForKey:@"saleEndDay"] floatValue];
        
        if (startDay < 0) {
            if (endDay < 0) {
                contentShow = [NSString stringWithFormat:@"已经过期%@天",[Utils formatFloat:0-endDay withNumber:0]];
            } else {
                contentShow = [NSString stringWithFormat:@"还有%@天停止发售。",[Utils formatFloat:endDay withNumber:0]];
            }
            
        } else {
            contentShow = [NSString stringWithFormat:@"还有%@天即将发售，敬请关注！",[Utils formatFloat:startDay withNumber:0]];
        }
    } else if (tableView.tag == 2){
        dic = [_maturityProductArray objectAtIndex:indexPath.row];
        cell.title.text = [dic objectForKey:@"name"];
        float day = [[dic objectForKey:@"expiredDay"] floatValue];
        if (day < 0) {
            contentShow = [NSString stringWithFormat:@"已经到期%@天，请抓紧赎回。",[Utils formatFloat:0-day withNumber:0]];
        } else {
            contentShow = [NSString stringWithFormat:@"还有%@天到期，请及时赎回！",[Utils formatFloat:day withNumber:0]];
        }
    }
    cell.content.text = contentShow;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    financialProduct * fp = [[[financialProduct alloc] init] autorelease];
    NSDictionary * product;
    if (tableView.tag == 1) {
        product = [_preSaleProductArray objectAtIndex:indexPath.row];
        
    } else if(tableView.tag == 2) {
        product = [_maturityProductArray objectAtIndex:indexPath.row];
    }
    fp.id_ = [product objectForKey:@"id_f_server"];
    fp.name = [product objectForKey:@"name"];
    fp.partyName = [product objectForKey:@"party_name"];
    fp.interest = [product objectForKey:@"interest_rate"];
    fp.period = [product objectForKey:@"period_label"];
    fp.threshold = [product objectForKey:@"threshold"];
    fp.type = [product objectForKey:@"object_type"];
    
    FinancialProductDetailsViewController * financialProductDetailsVC = [[[FinancialProductDetailsViewController alloc] init] autorelease];
    financialProductDetailsVC.financialProduct = fp;
    [self.navigationController pushViewController:financialProductDetailsVC animated:YES];
}

@end

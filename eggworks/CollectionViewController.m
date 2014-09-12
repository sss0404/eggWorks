//
//  CollectionViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionTableViewCell.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "financialProduct.h"
#import "FinancialProductDetailsViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

@synthesize tableView = _tableView;
@synthesize products = _products;
@synthesize asynRunner = _asynRunner;

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_products release]; _products = nil;
    [_asynRunner release]; _asynRunner = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的收藏";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.asynRunner = [[ AsynRuner alloc] autorelease];
    
    UILabel * title = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20+ios7_d_height, 280, 30)] autorelease];
    title.text = @"我的收藏";
    title.textColor = title_text_color;
    [self.view addSubview:title];
    
    UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(10, 50+ios7_d_height, 290, 2)] autorelease];
    view.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [self.view addSubview:view];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 55+ios7_d_height, 320, kApplicationHeight-95)] autorelease];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
//    [self getFavourites];
    
}

//获取收藏的产品
-(void) getFavourites
{
    [RequestUtils getFavoritesProductsCallback:^(id obj) {
        BOOL success = [[obj objectForKey:@"success"] boolValue];
        if (success) {
            self.products =  [obj objectForKey:@"favorites"];
            [_tableView reloadData];
        }
    } withView:self.view];
    
//    [_asynRunner runOnBackground:^id{
//        return [RequestUtils getFavoritesProducts];
//    } onUpdateUI:^(id obj) {
//        BOOL success = [[obj objectForKey:@"success"] boolValue];
//        if (success) {
//            self.products =  [obj objectForKey:@"favorites"];
//            [_tableView reloadData];
//        }
//    } inView:self.view];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self getFavourites];
}

#pragma mark - UITableView delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.f;
}

- (CollectionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary * product = [_products objectAtIndex:indexPath.row];
    NSString * object_type = [product objectForKey:@"object_type"];
    if ([object_type isEqualToString:@"CashFund"]) {
        //货币基金
        cell.title.text = [product objectForKey:@"name"];
        cell.firstItem.text = [NSString stringWithFormat:@"机构名称：%@",[product objectForKey:@"party_name"]];
        cell.secondItem.text = [NSString stringWithFormat:@"基金代码：%@",[product objectForKey:@"vendor_product_code"]];
        cell.threeItem.text = [NSString stringWithFormat:@"赎回时间："];
        
    } else {
        //万能险,银行理财产品
        cell.title.text = [product objectForKey:@"name"];
        cell.firstItem.text = [NSString stringWithFormat:@"起购金额：%@",[product objectForKey:@"threshold"]];
        cell.secondItem.text = [NSString stringWithFormat:@"投资期限：%@",[product objectForKey:@"period_label"]];
        
        NSString * interestRate = [product objectForKey:@"interest_rate"];
        if (interestRate != [NSNull null]) {
            interestRate = [Utils formatFloat:[interestRate floatValue] *100 withNumber:2];
        }
        cell.threeItem.text = [NSString stringWithFormat:@"预期最高收益率：%@％",interestRate];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * product = [_products objectAtIndex:indexPath.row];
    financialProduct * fp = [[[financialProduct alloc] init] autorelease];
    fp.id_ = [product objectForKey:@"object_id"];
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

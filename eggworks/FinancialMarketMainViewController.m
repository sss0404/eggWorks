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

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_array release]; _array = nil;
    [_currData release]; _currData = nil;
    [_asynrunner release]; _asynrunner = nil;
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
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    _array = [[NSMutableArray alloc] init];
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    _tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appHeight+20)] autorelease];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    
    [self getfinancialMarkets:1];
}

-(void)menuButton:(id)sender
{
    ScreeningMainPageViewController * screeningMainPageVC = [[[ScreeningMainPageViewController alloc] init] autorelease];
    [self.navigationController pushViewController:screeningMainPageVC animated:YES];
}

-(void) getfinancialMarkets:(int)page
{
    NSLog(@"加载页面:%i",page);
    isLoadState = YES;
    [_asynrunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils getfinancialMarketsWithAreaID:@"all"
                                                                 partyId:@""
                                                                  period:@"all"
                                                               threshold:@"all"
                                                                    page:page];
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
            [financialProductss addObject:finProduct];
            [finProduct release]; finProduct = nil;
        }
        return financialProductss;
    } onUpdateUI:^(id obj){
        [_array addObjectsFromArray:obj];
        [self.tableView reloadData];
        isLoadState = NO;
    }];
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
            cell.ExpectedReturn.text = [NSString stringWithFormat:@"%@%@",[Utils newFloat:[finProduct.interest floatValue]*100 withNumber:2],@"%"];
        }
        //@"5.61%";
        cell.financialProductsName.text = finProduct.name;
        cell.financialProductsDescribtion.text = [NSString stringWithFormat:@"起购金额%@  理财期限%@",finProduct.threshold,finProduct.period];
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
            [self getfinancialMarkets:current_page+1];//加载下一页
            NSLog(@"加载");
        }
    }
}

@end

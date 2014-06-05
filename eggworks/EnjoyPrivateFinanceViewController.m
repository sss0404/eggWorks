//
//  EnjoyPrivateFinanceViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-26.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "EnjoyPrivateFinanceViewController.h"
#import "FinancialMarketTableViewCell.h"
#import "Utils.h"
#import "financialProduct.h"
#import "RequestUtils.h"
#import "FinancialProductDetailsViewController.h"
#import "EnjoyPrivateFinanceSettingViewController.h"

@interface EnjoyPrivateFinanceViewController ()

@end

@implementation EnjoyPrivateFinanceViewController

@synthesize tableView = _tableView;
@synthesize asynRunner = _asynRunner;
@synthesize financialProductss = _financialProductss;
@synthesize currData = _currData;


- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_financialProductss release]; _financialProductss = nil;
    [_currData release]; _currData = nil;
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
    // Do any additional setup after loading the view.
    self.title = @"私享理财";
    isLoadState = NO;
    
    self.financialProductss = [[[NSMutableArray alloc] init] autorelease];
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    
    UIButton * settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"search_right_btn"] forState:UIControlStateNormal];
    settingBtn.frame = CGRectMake(0, 0, 52, 44.5);
    [settingBtn addTarget:self action:@selector(settingButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[[UIBarButtonItem alloc] initWithCustomView:settingBtn] autorelease];
    rightBtn.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, appHeight+20)] autorelease];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self getEnjoyPrivateFinanceProductsWithPage:1];
}


//设置按钮点击事件
-(void)settingButtonClick:(id)sender
{
    NSLog(@"设置按钮被点击");
    EnjoyPrivateFinanceSettingViewController * enjoyPrivateFinanceSettingVC = [[[EnjoyPrivateFinanceSettingViewController alloc] init] autorelease];
    [self.navigationController pushViewController:enjoyPrivateFinanceSettingVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getEnjoyPrivateFinanceProductsWithPage:(int)page
{
    NSLog(@"加载页面:%i",page);
    isLoadState = YES;
    [_asynRunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils getEnjoyPrivateFinanceProductsWithPage:page andForUser:[Utils getAccount]];
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
        [_financialProductss addObjectsFromArray:obj];
        [self.tableView reloadData];
        isLoadState = NO;
    }];
}

#pragma mark - tableView det
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _financialProductss.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EnjoyPrivateFinanceProductsCell";
    FinancialMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[FinancialMarketTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    @try {
        financialProduct * finProduct = [_financialProductss objectAtIndex:indexPath.row];
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
    financialProduct * finProduct = [_financialProductss objectAtIndex:indexPath.row];
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
            [self getEnjoyPrivateFinanceProductsWithPage:current_page+1];
            NSLog(@"加载");
        }
    }
}

@end

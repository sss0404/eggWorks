//
//  ShuMiDetailViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/7/4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ShuMiDetailViewController.h"
#import "ShuMi_Plug_Data.h"
#import "CollectionTableViewCell.h"
#import "SBJsonParser.h"
#import "AppDelegate.h"
#import "TimeUtils.h"

@interface ShuMiDetailViewController ()

@end

@implementation ShuMiDetailViewController

@synthesize tableView = _tableView;
@synthesize suMi = _suMi;
@synthesize array = _array;
@synthesize bussesTypeDic = _bussesTypeDic;
@synthesize HUD = _HUD;

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_array release]; _array = nil;
    [_bussesTypeDic release];
    [_HUD release]; _HUD = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kApplicationWidth, kScreenHeight)] autorelease];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    self.HUD = [[[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
    [self.view addSubview:_HUD];
//    [_HUD showWhileExecuting:@selector(background) onTarget:self withObject:nil animated:YES];
    
    [self initData];
}

//初始化数据
-(void)initData
{
    [_HUD show:YES];
    switch (_suMi) {
        case myFundProducts:
            self.title = @"我的基金产品";
            [self myFundProducts];
            break;
        case transactionRecords:
            self.title = @"我的交易记录";
            [self transactionRecords];
            break;
        case loadUserBindedCards:
            self.title = @"我的交易账号";
            [self loadUserBindedCards];
            break;
        default:
            break;
    }
    
}

//我的基金产品
-(void)myFundProducts
{
    [ShuMi_Plug_Data loadUserFundShares:^(BOOL success, NSError *error, NSArray *parsedData) {
        NSLog(@"我的基金产品:%@",parsedData);
        if (success) {
            self.array = parsedData;
            [_tableView reloadData];
        }
        [_HUD hide:NO];
    }];
}

//我的交易记录
-(void)transactionRecords
{
    long long currDate = [TimeUtils getCurrentTime];
    NSString * creeDateStr = [TimeUtils longlong2StringWithLongLong:currDate withFormate:YYYYMMDD];//现在的时间
    
    NSString * threeMouthAgoStr = [TimeUtils longlong2StringWithLongLong:currDate - 3600*24*30*3 withFormate:YYYYMMDD];//三个月前的日期
    
    [ShuMi_Plug_Data loadUserTradeRecordsWithStartTime:threeMouthAgoStr
                                               endTime:creeDateStr
                                             pageIndex:1
                                              pageSize:20
                                         finishedBlock:^(BOOL success, NSError *error, NSDictionary *parsedData) {
                                            if (success) {
                                                NSLog(@"我的交易记录：%@",parsedData);
                                                self.array = [parsedData objectForKey:@"Items"];
                                                [_tableView reloadData];
                                                
                                            }
                                             [_HUD hide:NO];
    }];
}

//我的交易账号
-(void)loadUserBindedCards
{                  //loadUserBindedCard
//    [ShuMi_Plug_Data loadUserBindedCards:^(BOOL success, NSError *error, NSArray *parsedData) {
//        if (success) {
//            NSLog(@"我的交易账号:%@", parsedData);
//            self.array = parsedData;
//            [_tableView reloadData];
//        }
//        [_HUD hide:NO];
//    }];
    
    NSMutableArray * arrayTemp = [[NSMutableArray alloc] initWithCapacity:1];
    [arrayTemp addObject:@""];
    self.array = arrayTemp;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 0;
    switch (_suMi) {
        case myFundProducts:
            height = 50.0f;
            break;
            
        default:
            height = 100.f;
            break;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = nil;
    switch (_suMi) {
        case myFundProducts:
            cell = [self myFundProductsTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        case transactionRecords:
            cell = [self transactionRecordsTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        case loadUserBindedCards:
            cell = [self loadUserBindedCardsTransactionRecordsTableView:tableView cellForRowAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    return cell;
}

//我的基金产品
-(UITableViewCell*)myFundProductsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"reuseIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    NSDictionary * dic = [_array objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"FundName"];
    return cell;
}

//我的交易记录
- (UITableViewCell *)transactionRecordsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"reuseIdentifier";
    CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
    NSDictionary * dic = [_array objectAtIndex:indexPath.row];
    cell.title.text = [dic objectForKey:@"FundName"];
    cell.firstItem.text = [NSString stringWithFormat:@"交易时间：%@",[dic objectForKey:@"ApplyDateTime"]];
    cell.secondItem.text = [NSString stringWithFormat:@"已购金额（元）：%@",[dic objectForKey:@"Amount"]];
    cell.threeItem.text = [NSString stringWithFormat:@"交易类型：%@", [self getBussesTypeWithCode:[dic objectForKey:@"BusinessType"]]];
    return cell;
}

//我的交易账号
- (UITableViewCell *)loadUserBindedCardsTransactionRecordsTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuseIdentifier = @"reuseIdentifier";
    CollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[[CollectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] autorelease];
    }
//    NSDictionary * dic = [_array objectAtIndex:indexPath.row];
    cell.title.text = @"数米基金账号";
    AppDelegate * delegate = [UIApplication sharedApplication].delegate;
    NSDictionary * suMiInfo = delegate.suMiInfo;
    cell.firstItem.text = [NSString stringWithFormat:@"用户名：%@",[suMiInfo objectForKey:@"realName"]];
    cell.secondItem.text = [NSString stringWithFormat:@"身份证：%@",[suMiInfo objectForKey:@"idNumber"]];
    return cell;
}

//获取业务类型
-(NSString*)getBussesTypeWithCode:(NSString*)bussesType
{
    NSString * typeStr = @"{ \"058\": \"修改主交易账号\", \"806\": \"资 金调增\", \"807\": \"资金调减\", \"804\": \"资金支出\", \"805\": \"资金调整\", \"802\": \"资金到帐\", \"803\": \"利息归本\", \"800\": \"资金存入\", \"801\": \"支票存入\", \"159\": \"定期定额申购协议签订\", \"158\": \"修 改主交易账号\", \"153\": \"撤销申请\", \"150\": \"基金清盘\", \"151\": \"基金终止\", \"053\": \"撤销申请\", \"A22\": \"货币赎回转购\", \"161\": \"定期定额申购协议修改\", \"039\": \"定 期定额申购\", \"036\": \"基金转换\", \"033\": \"非交易过户\", \"A89\": \"冲账确认\", \"924\": \"赎回行为 确认\", \"922\": \"申购行为确认\", \"A09\": \"盘后业务密码修改\", \"A08\": \"盘后业务密码清密\", \"A07\": \"盘 后业务签约资料修改\", \"109\": \"取消基金账号登记\", \"108\": \"基金账号登记\", \"A02\": \"风险揭示书签署\", \"031\": \"份 额冻结\", \"A01\": \"电子合同签署\", \"032\": \"份额解冻\", \"105\": \"基金账户解冻\", \"104\": \"基金 账户冻结\", \"103\": \"资料修改\", \"A06\": \"盘后业务签约\", \"102\": \"销户\", \"A05\": \"电子合同补正\", \"101\": \"开户\", \"A04\": \"约定书取消\", \"A03\": \"约定书 签署\", \"A99\": \"分拆合并撤销确认\", \"996\": \"银基通销户\", \"997\": \"银基通开通\", \"180\": \"确权确 认\", \"994\": \"交易账户冻结\", \"995\": \"交易账户解冻\", \"992\": \"发交 易账号卡\", \"993\": \"银行信息修改\", \"990\": \"发基金账号卡\", \"991\": \"解除锁定\", \"809\": \"资金支出 失败\", \"808\": \"资金清退\", \"998\": \"增加交易账号确认\", \"999\": \"交 易密码清密\", \"092\": \"优惠承诺协议\", \"989\": \"交易密码修改\", \"091\": \"定期定额赎回协议签订\", \"988\": \"定 期定额申购协议修改\", \"094\": \"定期定额赎回协议取消\", \"987\": \"定期定额赎回协议修改\", \"093\": \"定期定额申购协议取消\", \"096\": \"交 易账号销户\", \"095\": \"定期定额赎回\", \"098\": \"快速过户\", \"110\": \"增开TA基金帐户\", \"097\": \"内部转托管\", \"982\": \"定期定额转换协议签订\", \"195\": \"定 期定额赎回\", \"194\": \"定期定额赎回协议取消\", \"196\": \"交易账号销户\", \"986\": \"预约基金转换\", \"191\": \"定期 定额赎回协议修改\", \"985\": \"定期定额基金转换\", \"984\": \"定期定额转换协议取消\", \"090\": \"定期定额申购协议签订\", \"193\": \"定 期定额申购协议取消\", \"983\": \"定期定额转换协议修改\", \"192\": \"优惠承诺协议\", \"010\": \"撤销帐户申请\", \"198\": \"内部 转托管入\", \"199\": \"内部转托管出\", \"099\": \"分拆合并撤销\", \"127\": \"托管转入\", \"128\": \"托管转出\", \"122\": \"申购确认\", \"124\": \"赎回确认\", \"022\": \"申购\", \"A84\": \"ETF实物赎回确认\", \"023\": \"预约申购\", \"024\": \"赎回\", \"A86\": \"基金合并确认\", \"025\": \"预约赎回\", \"A85\": \"基金分拆 确认\", \"026\": \"转托管\", \"129\": \"设置分红方式\", \"027\": \"托管 转入\", \"028\": \"托管转出\", \"A82\": \"ETF实物申购确认\", \"029\": \"设 置分红方式\", \"021\": \"预约认购\", \"020\": \"认购\", \"120\": \"认购行为确认\", \"234\": \"快速 过户入\", \"235\": \"快速过户出\", \"134\": \"非交易过户入\", \"135\": \"非交易过户出\", \"132\": \"份额 解冻\", \"138\": \"基金转换出\", \"139\": \"定期定额申购\", \"137\": \"基金 转换入\", \"T02\": \"基金联动协议修改\", \"T03\": \"基金联动协议终止\", \"T01\": \"基金联动协议\", \"131\": \"份额 冻结\", \"130\": \"认购结果\", \"0AG\": \"子账户修改\", \"143\": \"红利发 放\", \"0AH\": \"子账户新增\", \"086\": \"基金合并\", \"144\": \"强制调增\", \"085\": \"基金分拆\", \"850\": \"资金存入\", \"145\": \"强制调减\", \"084\": \"ETF实物赎回\", \"852\": \"交易变动\", \"008\": \"基金账号 登记\", \"082\": \"ETF实物申购\", \"851\": \"资金支出\", \"009\": \"取消基金账号登记\", \"149\": \"发 行失败\", \"080\": \"确权\", \"004\": \"基金账户冻结\", \"005\": \"基金 账户解冻\", \"001\": \"开户\", \"002\": \"销户\", \"003\": \"资料修改\", \"142\": \"强制赎回\", \"089\": \"冲账\"}";
    
    
    if (_bussesTypeDic == nil) {
        SBJsonParser* jsonParser = [[[SBJsonParser alloc]init] autorelease];
        self.bussesTypeDic = [jsonParser objectWithString:typeStr];
    }
    return [_bussesTypeDic objectForKey:bussesType];
}

@end

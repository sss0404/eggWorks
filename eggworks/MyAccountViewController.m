//
//  MyAccountViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MyAccountViewController.h"
#import "PersonalDataViewController.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "CollectionViewController.h"
#import "SettingViewController.h"
#import "MyOrderViewController.h"
#import "ShuMi_Plug_Function.h"
#import "ShuMi_Plug_Data.h"
#import "ShuMiDetailViewController.h"
#import "AppDelegate.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

@synthesize tableView = _tableView;
@synthesize dic = _dic;
@synthesize name = _name;
@synthesize asynRunner = _asynRunner;
@synthesize userInfo = _userInfo;

- (void)dealloc
{
    [NotificationCenter removeObserver:self name:@"onNotification" object:nil];
    [_tableView release]; _tableView = nil;
    [_dic release]; _dic = nil;
    [_name release]; _name = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_userInfo release]; _userInfo = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的账户";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    
    NSArray * selection1 = @[@"我的基金产品"];
    NSArray * selection2 = @[@"我的交易账号",@"我的交易记录"];
    NSArray * selection3 = @[@"我的收藏",@"设置"];
    self.dic = [[[NSMutableDictionary alloc] init] autorelease];
    [_dic setObject:selection1 forKey:@"1"];
    [_dic setObject:selection2 forKey:@"2"];
    [_dic setObject:selection3 forKey:@"3"];
    
    UIView * topBg = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, 20)] autorelease];
    topBg.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    [self.view addSubview:topBg];
    
    UIButton * btn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 20+ios7_d_height, 320, 70)] autorelease];
    btn.backgroundColor = [UIColor colorWithRed:.86 green:.21 blue:.20 alpha:1];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //用户头像
    UIImageView * head = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_head_pic"]]autorelease];
    head.frame = CGRectMake(20, 12, 46, 46);
    [btn addSubview:head];
    
    UILabel * nameTitle = [[[UILabel alloc] initWithFrame:CGRectMake(80, 12, 100, 20)] autorelease];
    nameTitle.text = @"用户名";
    nameTitle.textColor = [UIColor whiteColor];
    nameTitle.font = [UIFont systemFontOfSize:14];
    nameTitle.backgroundColor = [UIColor clearColor];
    [btn addSubview:nameTitle];
    
    self.name = [[[UILabel alloc] initWithFrame:CGRectMake(80, 30, 200, 30)] autorelease];
    _name.textColor = [UIColor whiteColor];
    _name.backgroundColor = [UIColor clearColor];
    [btn addSubview:_name];
    
    UIImageView * view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_white"]] autorelease];
    view.frame = CGRectMake(300, 29, 7.5 ,12);
    [btn addSubview:view];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 90+ios7_d_height, 320, kApplicationHeight+20-90)] autorelease];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [self getUserInfo];
    
//    NSString * id_ = [_userInfo objectForKey:@"id"];
//    if (id_ == [NSNull null]) {
//        [Utils saveIdForUser:nil];
//    } else {
//        [Utils saveIdForUser:id_];
//    }
//    NSString * realName = [_userInfo objectForKey:@"real_name"];
//    if (realName == [NSNull null]) {
//        _name.text = @"";
//    } else {
//        _name.text = realName;
//    }
}

-(void)backButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void) getUserInfo
{
    [RequestUtils getUserInfoWithCallBack:^(id data) {
        BOOL success = [[data objectForKey:@"success"] boolValue];
        self.userInfo = data;
        if (success) {
            NSString * id_ = [data objectForKey:@"id"];
            [Utils saveIdForUser:[Utils strConversionWitd:id_]];
            NSString * realName = [data objectForKey:@"real_name"];
            NSString * realNameR = [Utils strConversionWitd:realName];
            _name.text = realNameR;
            [Utils saveRealName:realNameR];
        }
    } withView:self.view];
    
//    [_asynRunner runOnBackground:^id{
//        return [RequestUtils getUserInfo];
//    } onUpdateUI:^(id obj) {
//        BOOL success = [[obj objectForKey:@"success"] boolValue];
//        self.userInfo = obj;
//        if (success) {
//            NSString * id_ = [obj objectForKey:@"id"];
//            [Utils saveIdForUser:[Utils strConversionWitd:id_]];
//            NSString * realName = [obj objectForKey:@"real_name"];
//            NSString * realNameR = [Utils strConversionWitd:realName];
//            _name.text = realNameR;
//            [Utils saveRealName:realNameR];
//        }
//    } inView:self.view];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//账号信息
-(void)btnClick:(id)sender
{
    PersonalDataViewController * personalDataVC = [[[PersonalDataViewController alloc] init] autorelease];
    personalDataVC.userInfo = _userInfo;
    [self.navigationController pushViewController:personalDataVC animated:YES];
}


#pragma mark - UITableView delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    int num = 0;
    switch (section) {
        case 0:
            num = [[_dic objectForKey:@"1"] count];
            break;
        case 1:
            num = [[_dic objectForKey:@"2"] count];
            break;
        case 2:
            num = [[_dic objectForKey:@"3"] count];
            break;
        default:
            break;
    }
    NSLog(@"num:%i",num);
    return num;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] autorelease];
    view.backgroundColor = [UIColor colorWithRed:.92 green:.92 blue:.92 alpha:1];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSArray * array;
    switch (indexPath.section) {
        case 0:
            array = [_dic objectForKey:@"1"];
            break;
        case 1:
            array = [_dic objectForKey:@"2"];
            break;
        case 2:
            array = [_dic objectForKey:@"3"];
            break;
        default:
            break;
    }
    NSString * str = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = str;
    
    UIImageView * view = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right"]] autorelease];
    view.frame = CGRectMake(300, 18, 7.5 ,12);
    [cell addSubview:view];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * array = [_dic objectForKey:[NSString stringWithFormat:@"%i", indexPath.section+1]];
    NSString * item = [array objectAtIndex:indexPath.row];
    if ([item isEqualToString:@"我的基金产品"]) {
        [self myFundProducts];
    } else if([item isEqualToString:@"我的保单"]) {
        [self myOrderClick];
    } else if ([item isEqualToString:@"我的交易账号"]) {
        [self loadUserBindedCards];
    } else if ([item isEqualToString:@"我的交易记录"]) {
        [self transactionRecords];
    } else if ([item isEqualToString:@"我的收藏"]) {
        CollectionViewController * collectionVC = [[[CollectionViewController alloc] init] autorelease];
        [self.navigationController pushViewController:collectionVC animated:YES];
    } else if([item isEqualToString:@"设置"]) {
        SettingViewController * settingVC = [[[SettingViewController alloc] init] autorelease];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}

//我的保单
-(void)myOrderClick
{
    RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
    [requestUtils ordersJsonWithCallback:^(id obj) {
        if (![[obj objectForKey:@"success"] boolValue]) {
            Show_msg(@"提示", @"获取数据失败");
            return ;
        }
        NSArray * orders = [obj objectForKey:@"orders"];
        MyOrderViewController * myOrderVC = [[[MyOrderViewController alloc] init] autorelease];
        myOrderVC.myOrderArray = orders;
        [self.navigationController pushViewController:myOrderVC animated:YES];
    } withView:self.view];
    
//    [_asynRunner runOnBackground:^id{
//        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
//        NSDictionary * dic = [requestUtils ordersJson];
//        return dic;
//    } onUpdateUI:^(id obj) {
//        if (![[obj objectForKey:@"success"] boolValue]) {
//            Show_msg(@"提示", @"获取数据失败");
//            return ;
//        }
//        NSArray * orders = [obj objectForKey:@"orders"];
//        MyOrderViewController * myOrderVC = [[[MyOrderViewController alloc] init] autorelease];
//        myOrderVC.myOrderArray = orders;
//        [self.navigationController pushViewController:myOrderVC animated:YES];
//    } inView:self.view];
}

//我的基金产品
-(void)myFundProducts
{
    suMiOpType = myFundProducts;
    if ([self isBind]) {
        ShuMiDetailViewController * suMiDetailVC = [[[ShuMiDetailViewController alloc] init] autorelease];
        suMiDetailVC.suMi = myFundProducts;
        [self.navigationController pushViewController:suMiDetailVC animated:YES];
    } else {
        [NotificationCenter addObserver:self selector:@selector(onNotification:) name:@"onNotification" object:nil];
        [ShuMi_Plug_Function userIdentityVrification:self.navigationController];
    }
}

//我的交易记录
-(void)transactionRecords
{
    suMiOpType = transactionRecords;
    if ([self isBind]) {
        ShuMiDetailViewController * suMiDetailVC = [[[ShuMiDetailViewController alloc] init] autorelease];
        suMiDetailVC.suMi = transactionRecords;
        [self.navigationController pushViewController:suMiDetailVC animated:YES];
    } else {
        [NotificationCenter addObserver:self selector:@selector(onNotification:) name:@"onNotification" object:nil];
        [ShuMi_Plug_Function userIdentityVrification:self.navigationController];
    }
}

//我的交易账号
-(void)loadUserBindedCards
{
    suMiOpType = loadUserBindedCards;
    if ([self isBind]) {
        ShuMiDetailViewController * suMiDetailVC = [[[ShuMiDetailViewController alloc] init] autorelease];
        suMiDetailVC.suMi = loadUserBindedCards;
        [self.navigationController pushViewController:suMiDetailVC animated:YES];
        
    } else {
        [NotificationCenter addObserver:self selector:@selector(onNotification:) name:@"onNotification" object:nil];
        [ShuMi_Plug_Function userIdentityVrification:self.navigationController];
    }
    
}

//接收到Notification
-(void)onNotification:(NSNotification *)notification
{
    switch (suMiOpType) {
        case transactionRecords:
            [self transactionRecords];
            break;
        case myFundProducts:
            [self myFundProducts];
            break;
        case loadUserBindedCards:
            [self loadUserBindedCards];
            break;
        default:
            break;
    }
    
}



//判断用户是否已经绑定数米SDK
-(BOOL)isBind
{
    AppDelegate * delete = [UIApplication sharedApplication].delegate;
    id suMiInfo = delete.suMiInfo;
    if (![suMiInfo isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    NSString * tokenKey = [delete.suMiInfo objectForKey:@"tokenKey"];
    
    return tokenKey != nil || tokenKey.length != 0;
    
//    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
//    BOOL binded = [[userDefault objectForKey:@"binded"] boolValue];
//    return binded;
}

@end

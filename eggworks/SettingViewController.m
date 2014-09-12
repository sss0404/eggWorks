//
//  SettingViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/5.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "SettingViewController.h"
#import "ModifyPassViewController.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "LoginViewController.h"
#import "AboutViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize tableView = _tableView;
@synthesize funcArray = _funcArray;

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_funcArray release]; _funcArray = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    
    self.funcArray = @[@"修改登录密码",@"关于盘算",@"退出登录"];
    
    self.tableView = [[[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
//    _tableView.backgroundColor = [UIColor redColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.funcArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [_funcArray objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * func =  [_funcArray objectAtIndex:indexPath.row];
    if ([func isEqualToString:@"修改登录密码"]) {
        ModifyPassViewController * modifyPassVC = [[[ModifyPassViewController alloc] init] autorelease];
        [self.navigationController pushViewController:modifyPassVC animated:YES];
    } else if([func isEqualToString:@"退出登录"]) {
        RequestUtils * requestUtils = [[[RequestUtils alloc] init] autorelease];
//        [Utils saveAccount:nil];
        
        [Utils saveAccount:@""];
        [Utils savePassword:@""];
        [Utils saveRealName:@""];
        [requestUtils removeHttpCredentials];
        
        //清除数米绑定信息
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"authorizedToken"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"tokenSecret"];
        BOOL binded = NO;
        [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:binded] forKey:@"binded"];
        
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"realName"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"idNumber"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else if([func isEqualToString:@"关于盘算"]) {
        AboutViewController * about = [[[AboutViewController alloc] init] autorelease];
        [self.navigationController pushViewController:about animated:YES];
    }
}


@end

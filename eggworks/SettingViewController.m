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
    
    self.funcArray = @[@"修改登录密码",@"关于理财集市",@"退出登录"];
    
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
        [requestUtils saveWithUid:@"" andPassword:@""];
        [Utils saveAccount:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


@end

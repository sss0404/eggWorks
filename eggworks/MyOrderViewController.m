//
//  MyOrderViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MyOrderViewController.h"
#import "Utils.h"
#import "MyOrderCellTableViewCell.h"
#import "UserInfoViewController.h"

@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

@synthesize tableView = _tableView;
@synthesize myOrderArray = _myOrderArray;

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_myOrderArray release]; _myOrderArray = nil;
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
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 30 + ios7_d_height, 280, 30)] autorelease];
    label.text = [NSString stringWithFormat:@"尊敬的%@用户：",[Utils getRealName]];
    label.textColor = orange_color;
    [self.view addSubview:label];
    
    UITextView * info = [[[UITextView alloc] initWithFrame:CGRectMake(20, 60+ios7_d_height, 280, 60)] autorelease];
    info.text = [NSString stringWithFormat:@"您在手机无忧购买了%i份意外损坏保障服务，具体如下：",_myOrderArray.count];
    info.textColor = title_text_color;
    info.scrollEnabled = NO;
    info.editable = NO;
    [self.view addSubview:info];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 120+ios7_d_height, kScreenWidth, kScreenHeight - 140)] autorelease];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myOrderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyOrderCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[MyOrderCellTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
     NSDictionary * dic = [_myOrderArray objectAtIndex:indexPath.row];
    NSString * brand =  [dic objectForKey:@"brand"];//品牌
    NSString * model = [dic objectForKey:@"model"];//手机型号
    NSString * start = [dic objectForKey:@"start"];//生效开始日期
    NSString * end = [dic objectForKey:@"end"];//生效结束日期
    cell.phoneModel.text = [NSString stringWithFormat:@"%@ %@", brand, model];
    cell.serviceData.text = [NSString stringWithFormat:@"%@ %@", start, end];
    cell.imageView.highlightedImage = nil;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserInfoViewController * userInfoVC = [[[UserInfoViewController alloc] init] autorelease];
    NSDictionary * dic = [_myOrderArray objectAtIndex:indexPath.row];
    userInfoVC.dic = dic;
    [self.navigationController pushViewController:userInfoVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)backButton:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

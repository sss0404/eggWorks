//
//  RemindViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-22.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "RemindViewController.h"

@interface RemindViewController ()

@end

@implementation RemindViewController

@synthesize preSaleProductsRemind = _preSaleProductsRemind;
@synthesize maturityProductsRemind = _maturityProductsRemind;


- (void)dealloc
{
    [_preSaleProductsRemind release];
    [_maturityProductsRemind release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%i",indexPath.row];
    return cell;
}

@end

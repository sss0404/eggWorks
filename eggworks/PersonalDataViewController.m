//
//  PersonalDataViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-23.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "PersonalDataViewController.h"

@interface PersonalDataViewController ()

@end

@implementation PersonalDataViewController

@synthesize userInfo = _userInfo;

- (void)dealloc
{
    [_userInfo release]; _userInfo = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人资料";
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    UITableView * tableVeiw = [[[UITableView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height-ios7_d_height, 320, kApplicationHeight + 20)] autorelease];
    tableVeiw.dataSource = self;
    tableVeiw.delegate = self;
    [self.view addSubview:tableVeiw];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(170, 10, 130, 30)] autorelease];
    label.textAlignment = UITextAlignmentRight;
    [cell addSubview:label];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"姓名";
            NSString * realName =  [_userInfo objectForKey:@"real_name"];
            if (realName == [NSNull null]) {
                label.text = @"";
            } else {
                label.text = realName;
            }
            break;
        case 1:
            cell.textLabel.text = @"身份证";
            NSString * idCardNo =  [_userInfo objectForKey:@"id_card_no"];
            if (idCardNo == [NSNull null]) {
                label.text = @"";
            } else {
                label.text = idCardNo;
            }
//            label.text = @"3****************3";
            break;
        case 2:
            cell.textLabel.text = @"手机号";
            NSString * mobilePhones = [[_userInfo objectForKey:@"mobile_phones"] objectAtIndex:0];
            label.text = mobilePhones;
            break;
        default:
            break;
    }
    
    return cell;
}

@end

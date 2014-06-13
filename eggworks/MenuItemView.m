//
//  MenuItemView.m
//  eggworks
//
//  Created by 陈 海刚 on 14/6/11.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "MenuItemView.h"
#import "AppDelegate.h"

@implementation MenuItemView

@synthesize tableView = _tableView;
@synthesize menuItems = _menuItems;
@synthesize navigationController = _navigationController;
@synthesize menuItemClickDelegate = _menuItemClickDelegate;

- (void)dealloc
{
    [_tableView release]; _tableView = nil;
    [_menuItems release]; _menuItems = nil;
    [_navigationController release]; _navigationController = nil;
    [_menuItemClickDelegate release]; _menuItemClickDelegate = nil;
    [super dealloc];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        // Initialization code
        self.menuItems = @[menu_items];
        self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth*0.6, 0, kScreenWidth*0.4, 200)] autorelease];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGBA(83,92,102,0.9);
        [self addSubview:_tableView];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.hidden = YES;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BaseViewControllerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    NSString * imgName = nil;
    switch (indexPath.row) {
        case 0:
            imgName = @"menuIndex";
            break;
        case 1:
            imgName = @"menuFinancialMarkets";
            break;
        case 2:
            imgName = @"menuPhoneEasy";
            break;
        case 3:
            imgName = @"menuEnjoyFrivateFinance";
            break;
        default:
            break;
    }
    cell.image = [UIImage imageNamed:imgName];
    cell.textLabel.text = [_menuItems objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];//RGBA(83,92,102,0.8);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_menuItemClickDelegate onMenuItemClickedAt:indexPath.row];
}

@end

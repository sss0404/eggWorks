//
//  MenuItemView.h
//  eggworks
//
//  Created by 陈 海刚 on 14/6/11.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemClickDeletate <NSObject>

-(void)onMenuItemClickedAt:(int)index;

@end

@interface MenuItemView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, retain) id<MenuItemClickDeletate> menuItemClickDelegate;
@property (nonatomic, retain) NSArray * menuItems;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UINavigationController * navigationController;

@end

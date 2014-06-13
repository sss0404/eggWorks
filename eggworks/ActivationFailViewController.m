//
//  ActivationFailViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ActivationFailViewController.h"

@interface ActivationFailViewController ()

@end

@implementation ActivationFailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.title = @"激活失败";
    UIImageView * activationFailIm = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fail_ expression"]] autorelease];
    activationFailIm.frame = CGRectMake(40, 20+ios7_d_height, 28.5, 28.5);
//    activationFailIm.backgroundColor = [UIColor redColor];
    [self.view addSubview:activationFailIm];
    
    UILabel * failTitle = [[[UILabel alloc] initWithFrame:CGRectMake(80, 15+ios7_d_height, 240, 40)] autorelease];
    failTitle.text = @"激活失败！";
    failTitle.textColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    failTitle.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:failTitle];
    
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(20, 60+ios7_d_height, 280, 1)] autorelease];
    divider.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider];
    
    UITextView * failNote = [[[UITextView alloc] initWithFrame:CGRectMake(20, 70+ios7_d_height, 280, 80)] autorelease];
    failNote.text = @"对不起，可能您的手机机型不在保修范围内。如有疑问请致电：4000000000";
    failNote.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:failNote];
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



@end

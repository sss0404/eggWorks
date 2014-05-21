//
//  BottomNavigotionViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BottomNavigotionViewController.h"



@interface BottomNavigotionViewController ()

@end

@implementation BottomNavigotionViewController

@synthesize bottomView = _bottomView;

- (void)dealloc
{
    [_bottomView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    float applicationHeight = kApplicationHeight;
    if (IOS7) {
        applicationHeight += 20;
    }
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, applicationHeight - BOTTOM_HEIGHT, kApplicationWidth, BOTTOM_HEIGHT)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    NSArray * bottomBtnStrArray = @[IndexBottomFuncArray];
    
    float offset_x = 0;
    float btnWidth = kApplicationWidth/3;
    for (int i=0; i<bottomBtnStrArray.count; i++) {
//        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"string"]];
        
        UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(offset_x, 0, btnWidth, 45)];
        btn.tag = i;
        [btn setBackgroundImage:[UIImage imageNamed:[bottomBtnStrArray objectAtIndex:i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
        CARelease(btn);
        offset_x += btnWidth;
    }
    [self.view addSubview:_bottomView];
    CARelease(_bottomView);
}

-(void)bottomClick:(id)sender
{
    int tag = ((UIButton*)sender).tag;
    NSLog(@"tag:%i", tag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  BaseViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-4.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize passingParameters = _passingParameters;
@synthesize resultCode = _resultCode;

- (void)dealloc
{
    [_resultCode release]; _resultCode = nil;
    [super dealloc];
}

//接收参数
-(void)completeParameters:(id)obj withTag:(NSString*)tag
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //返回按钮
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton* backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"return_pre_btn_bg"] forState:UIControlStateNormal];
    backbutton.frame = CGRectMake(0, 0, 12, 22.5);
    [backbutton addTarget:self action:@selector(backButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[[UIBarButtonItem alloc] initWithCustomView:backbutton] autorelease];
    buttonItem.style = UIBarButtonItemStylePlain;
    self.navigationItem.leftBarButtonItem = buttonItem;
    
    UIButton * menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"n_right_menu"] forState:UIControlStateNormal];
    menuBtn.frame = CGRectMake(0, 0, 19, 16);
    [menuBtn addTarget:self action:@selector(menuButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[[UIBarButtonItem alloc] initWithCustomView:menuBtn] autorelease];
    rightBtn.style = UIBarButtonItemStylePlain;
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)menuButton:(id)sender
{
    NSLog(@"菜单按钮");
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    BOOL isScrollView = NO;
    NSArray * views = [self.view subviews];
    for (int i=0; i<views.count; i++) {
        UIView * view = [views objectAtIndex:i];
        if ([view isKindOfClass:[UIScrollView class]]&&[((UIScrollView*)view) contentSize].height>kApplicationHeight) {
            NSLog(@"----------");
            isScrollView = YES;
//            break;
        }
    }
    if (!isScrollView) {
        ios7_d_height = 0;
    }
    self.view.frame =CGRectMake(0, 0+ios7_d_height, self.view.frame.size.width, self.view.frame.size.height+50);
}

@end

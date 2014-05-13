//
//  SubmitSuccViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-7.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "SubmitSuccViewController.h"

@interface SubmitSuccViewController ()

@end

@implementation SubmitSuccViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"提交成功";
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    UIView * aVeiw = [[[UIView alloc] initWithFrame:CGRectMake(0, 0+ ios7_d_height, 320, appHeight)] autorelease];
    [self.view addSubview:aVeiw];
    
    UILabel * titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 40)] autorelease];
    titleLabel.text = @"理赔申请提交成功!";
    titleLabel.textColor = orange_color;
    [aVeiw addSubview:titleLabel];
    
    //橙色分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 55, 320, 2)] autorelease];
    divider.backgroundColor = orange_color;
    [aVeiw addSubview:divider];
    
    UITextView * noteTv = [[[UITextView alloc] initWithFrame:CGRectMake(20, 60, 280, 100)] autorelease];
    noteTv.textColor = title_text_color;
    noteTv.text = [NSString stringWithFormat:@"您的申请已成功提交相关部门受理，你可在工作日内将您的手机送至%@区%@路%@号维修网点维修，网点联系电话%@。工作人员随时准备为您提供服务，感谢您的支持，我们将一如既往的为您提供最优质的服务！",@"浦东",@"俄山路",@"55",@"12345678900"];
    noteTv.scrollEnabled = NO;
    noteTv.editable = NO;
    noteTv.textColor = title_text_color;
    noteTv.font = [UIFont systemFontOfSize:14];
    [aVeiw addSubview:noteTv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

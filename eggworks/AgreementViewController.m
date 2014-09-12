//
//  AgreementViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14/9/11.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextView * tv = [[[UITextView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
    tv.editable = NO;
    tv.text = @"上海采旦金融信息服务有限公司将根据行业标准严格保密您注册时所填写的个人信息，使您的信息处于安全状态，未经您的同意我们不会提供您的信息给第三者（公司或个人）。但以下情况除外：\n(1) 用户授权网站公开、透露这些信息；\n(2) 相关的法律法规或监管机构、司法机构要求盘算提供用户的个人资料；国家司法机关符合法律规定并经法定程序的检查及其他操作；\n(3) 任何第三方盗用、冒用或未经许可擅自披露、使用或对外公开用户的个人隐私资料。\n(4) 注册会员自己要求网站提供特定服务时，需要把注册会员的姓名和地址提供给第三方的。\n(5) 在适合的情况下，并在您同意的前提下，我们会利用您的信息来联络您，为您发送信息。";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ActivateChannelViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ActivateChannelViewController.h"
#import "SelfHelpBuyViewController.h"
#import "ActivationFailViewController.h"
#import "ActivationSuccessViewController.h"
#import "RequestUtils.h"
#import "AsynRuner.h"

@interface ActivateChannelViewController ()

@end

@implementation ActivateChannelViewController

@synthesize nameTextField = _nameTextField;
@synthesize phoneNumber = _phoneNumber;
@synthesize phoneIMEI = _phoneIMEI;
@synthesize phoneModel = _phoneModel;

- (void)dealloc
{
    [_nameTextField release];
    [_phoneNumber release];
    [_phoneIMEI release];
    [_phoneModel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"填写信息";
   
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = 60;
    }
    
    
    UITextView * noteMsg = [[[UITextView alloc] initWithFrame:CGRectMake(20, 10, 280, 90 +ios7_d_height)] autorelease];
    noteMsg.editable = NO;
    noteMsg.scrollEnabled = NO;
    noteMsg.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:noteMsg];
    noteMsg.text = @"注：如果您未在其他渠道购买本服务请返回首页，点击                           购买此项服务。";
    
    float selfHelpBuyHeight = 45;
    float selfHelpBuyX = 140;
    if (IOS7) {
        selfHelpBuyHeight = 40;
        selfHelpBuyX = 125;
    }
    UIButton * selfHelpBuy = [[UIButton alloc] initWithFrame:CGRectMake(selfHelpBuyX, selfHelpBuyHeight+ios7_d_height, 100, 20)];
    selfHelpBuy.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [selfHelpBuy setTitle:@"自助购买通道" forState:UIControlStateNormal];
    selfHelpBuy.font = [UIFont systemFontOfSize:13.5f];
    [selfHelpBuy addTarget:self action:@selector(selfHelpBuyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selfHelpBuy];
    
    UILabel * label = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90+ios7_d_height, 280, 40)] autorelease];
    label.text = @"请补充资料并激活";
    [self.view addSubview:label];
    
    //橙色分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 123+ios7_d_height, 320, 2)] autorelease];
    divider.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [self.view addSubview:divider];
    
    UILabel * nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 130+ios7_d_height, 60, 30)] autorelease];
    nameLabel.text = @"姓名";
    nameLabel.textColor = title_text_color;
    [self.view addSubview:nameLabel];
    _nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(80, 130+ios7_d_height, 220, 30)];
    _nameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:_nameTextField];
    _nameTextField.delegate = self;
    
    //分割线
    UIView * divider1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 164+ios7_d_height, 320, 1)] autorelease];
    divider1.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider1];
    
    UILabel * phoneLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 166+ios7_d_height, 60, 30)] autorelease] ;
    phoneLabel.text = @"手机号";
    phoneLabel.textColor = title_text_color;
    [self.view addSubview:phoneLabel];
    _phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(80, 166+ios7_d_height, 220, 30)];
    [self.view addSubview:_phoneNumber];
    _phoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneNumber.delegate = self;
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 198+ios7_d_height, 320, 1)] autorelease];
    divider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider2];
    
    UILabel * phoneIMEI = [[[UILabel alloc] initWithFrame:CGRectMake(20, 202+ios7_d_height, 60, 30)] autorelease];
    phoneIMEI.text = @"IMEI";
    phoneIMEI.textColor = title_text_color;
    [self.view addSubview:phoneIMEI];
    _phoneIMEI = [[UITextField alloc] initWithFrame:CGRectMake(80, 202+ios7_d_height, 220, 30)];
    [self.view addSubview:_phoneIMEI];
    _phoneIMEI.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneIMEI.delegate = self;
    
    //分割线
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 234+ios7_d_height, 320, 1)] autorelease];
    divider3.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider3];
    
    UILabel * phoneModel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 238+ios7_d_height, 60, 30)] autorelease];
    phoneModel.text = @"型号";
    phoneModel.textColor = title_text_color;
    [self.view addSubview:phoneModel];
    _phoneModel = [[UITextField alloc] initWithFrame:CGRectMake(80, 238+ios7_d_height, 220, 30)];
    [self.view addSubview:_phoneModel];
    _phoneModel.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _phoneModel.delegate = self;
    
    //分割线
    UIView * divider4 = [[[UIView alloc] initWithFrame:CGRectMake(0, 270+ios7_d_height, 320, 1)] autorelease];
    divider4.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:1];
    [self.view addSubview:divider4];
    
    //提交数据按钮
    UIButton * submitBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 290+ios7_d_height, 280, 40)] autorelease];
//    submitBtn.backgroundColor = [UIColor colorWithRed:.99 green:.41 blue:.33 alpha:1];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:submitBtn];
    
    
}

-(void)submitBtnClick:(id)sender
{
    
    //
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
    NSString * userName = [userDefault objectForKey:@"userName"];
    if (userName.length == 0) {
        NSLog(@"未登录");
        AsynRuner * asynRunner = [[AsynRuner alloc] init];
        [asynRunner runOnBackground:^{
            NSDictionary * dic = [RequestUtils anonymousActiveWithName:_nameTextField.text
                                                           mobilePhone:_phoneNumber.text
                                                        deviceIdentity:_phoneIMEI.text
                                                                 brand:@"apple"
                                                                 model:@"iphone4s"];
            return dic;
        } onUpdateUI:^(id obj){
            BOOL success = [[obj objectForKey:@"success"] boolValue];
            if (success) {
                //提交成功
                ActivationSuccessViewController * submitSuccVC = [[ActivationSuccessViewController alloc] init];
                [self.navigationController pushViewController:submitSuccVC animated:YES];
                [submitSuccVC release];
            } else {
                //提交失败
//                NSString * message = [obj objectForKey:@"message"];
                ActivationFailViewController * submitFailVC = [[ActivationFailViewController alloc] init];
                [self.navigationController pushViewController:submitFailVC animated:YES];
                [submitFailVC release];
            }
        }];
       
    } else {
        NSLog(@"已登录");
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)selfHelpBuyClick:(id)sender
{
    SelfHelpBuyViewController * selfHelpBuyVC = [[[SelfHelpBuyViewController alloc] init] autorelease];
    [self.navigationController pushViewController:selfHelpBuyVC animated:YES];
    
//    [self.navigationController popViewControllerAnimated:NO];

}

@end

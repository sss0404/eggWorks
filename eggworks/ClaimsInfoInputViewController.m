//
//  ClaimsInfoInputViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-6.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "ClaimsInfoInputViewController.h"
#import "MyselfSendWayViewController.h"
#import "HomeDeliveryWayViewController.h"
#import "RequestUtils.h"
#import "Utils.h"
#import "CitySelecteViewController.h"
#import "ClaimsConfirmInfoViewController.h"
#import "RequestUtils.h"

@interface ClaimsInfoInputViewController ()

@end

@implementation ClaimsInfoInputViewController

@synthesize cityBtn = _cityBtn;
@synthesize nameTF  = _nameTF;
@synthesize phoneNumberTF = _phoneNumberTF;
@synthesize connectPhoneNumberTF = _connectPhoneNumberTF;
@synthesize damageReasonBtn = _damageReasonBtn;
@synthesize sendWayBtn = _sendWayBtn;
@synthesize aVeiw = _aVeiw;
@synthesize nextBtn = _nextBtn;
@synthesize servicePhone = _servicePhone;
@synthesize info = _info;
@synthesize asyRunner = _asyRunner;
@synthesize damageReasonArray = _damageReasonArray;

- (void)dealloc
{
    [_cityBtn release]; _cityBtn = nil;
    [_nameTF release]; _nameTF = nil;
    [_phoneNumberTF release]; _phoneNumberTF = nil;
    [_connectPhoneNumberTF release]; _connectPhoneNumberTF = nil;
    [_damageReasonBtn release]; _damageReasonBtn = nil;
    [_sendWayBtn release]; _sendWayBtn = nil;
    [_aVeiw release]; _aVeiw = nil;
    [_nextBtn release]; _nextBtn = nil;
    [_servicePhone release]; _servicePhone = nil;
    [_info release]; _info = nil;
    [_asyRunner release]; _asyRunner = nil;
    [_damageReasonArray release]; _damageReasonArray = nil;
    [super dealloc];
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"填写信息";
    self.view.backgroundColor = [UIColor whiteColor];
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.asyRunner = [[[AsynRuner alloc] init] autorelease];
    
//    self.info = [[[NSMutableDictionary alloc] init] autorelease];
    
    float appHeight = [[UIScreen mainScreen] applicationFrame].size.height;
    _aVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, appHeight)];
    [self.view addSubview:_aVeiw];
    
    //分割线
    UIView * divider1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 1)] autorelease];
    divider1.backgroundColor = divider_color;
    [_aVeiw addSubview:divider1];
    
    //所在城市
    UILabel * cityLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 28, 80, 30)] autorelease];
    cityLabel.textColor = title_text_color;
    cityLabel.text = @"所在城市";
    [_aVeiw addSubview:cityLabel];
    
    _cityBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 25, 100, 34.5)];
//    [_cityBtn setTitle:@"上海" forState:UIControlStateNormal];//down_btn@2x
    [_cityBtn setTitleColor:title_text_color forState:UIControlStateNormal];
    [_cityBtn addTarget:self action:@selector(selectCity:) forControlEvents:UIControlEventTouchUpInside];
    
//    _cityBtn.backgroundColor = [UIColor redColor];
//    _cityBtn.frame = CGRectMake(100, 25, 100, 34.5);
    [_aVeiw addSubview:_cityBtn];
    UIImageView * downImg = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_btn"]] autorelease];
    downImg.frame = CGRectMake(80, 13, 11.5, 7);
    [_cityBtn addSubview:downImg];
    
    
    UIButton * local = [UIButton buttonWithType:UIButtonTypeCustom];
    local.frame = CGRectMake(200, 25, 94, 34.5);
    [local addTarget:self action:@selector(myLocalBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [local setBackgroundImage:[UIImage imageNamed:@"my_location"] forState:UIControlStateNormal];
    [_aVeiw addSubview:local];
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 65, 320, 1)] autorelease];
    divider2.backgroundColor = divider_color;
    [_aVeiw addSubview:divider2];
    
    //姓名
    UILabel * nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 80, 30)] autorelease];
    nameLabel.text = @"姓名";
    nameLabel.textColor = title_text_color;
    [_aVeiw addSubview:nameLabel];
    
    _nameTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 70, 200, 30)];
//    _nameTF.backgroundColor = [UIColor yellowColor];
    _nameTF.delegate = self;
    [_aVeiw addSubview:_nameTF];
    
    //分割线
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 105, 320, 1)] autorelease];
    divider3.backgroundColor = divider_color;
    [_aVeiw addSubview:divider3];
    
    //手机号
    UILabel * phoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 110, 80, 30)] autorelease];
    phoneNumberLabel.text = @"手机号";
    phoneNumberLabel.textColor = title_text_color;
    [_aVeiw addSubview:phoneNumberLabel];
    
    _phoneNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 110, 200, 30)];
//    _phoneNumberTF.backgroundColor = [UIColor yellowColor];
    _phoneNumberTF.delegate = self;
    _phoneNumberTF.placeholder = @"购买时登记号码";
    [_aVeiw addSubview:_phoneNumberTF];
    
    //分割线
    UIView * divider4 = [[[UIView alloc] initWithFrame:CGRectMake(0, 145, 320, 1)] autorelease];
    divider4.backgroundColor = divider_color;
    [_aVeiw addSubview:divider4];
    
    // 联系电话
    UILabel * connectionPhoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 150, 80, 30)] autorelease];
    connectionPhoneNumberLabel.text = @"联系电话";
    connectionPhoneNumberLabel.textColor = title_text_color;
    [_aVeiw addSubview:connectionPhoneNumberLabel];
    
    _connectPhoneNumberTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 150, 200, 30)];
//    _connectPhoneNumberTF.backgroundColor = [UIColor yellowColor];
    _connectPhoneNumberTF.delegate = self;
    _connectPhoneNumberTF.placeholder = @"用于客服和快递联系";
    [_aVeiw addSubview:_connectPhoneNumberTF];
    
    //分割线
    UIView * divider5 = [[[UIView alloc] initWithFrame:CGRectMake(0, 185, 320, 1)] autorelease];
    divider5.backgroundColor = divider_color;
    [_aVeiw addSubview:divider5];
    
    //损坏原因
    UILabel * damageReasonLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 190, 80, 30)] autorelease];
    damageReasonLabel.text = @"损坏原因";
    damageReasonLabel.textColor = title_text_color;
    [_aVeiw addSubview:damageReasonLabel];
    
    _damageReasonBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 190, 170, 30)];
//    _damageReasonBtn.backgroundColor = [UIColor yellowColor];
    [_damageReasonBtn addTarget:self action:@selector(damageReasonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_aVeiw addSubview:_damageReasonBtn];
    UIImageView * downImg1 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_btn"]] autorelease];
    downImg1.frame = CGRectMake(180, 13, 11.5, 7);
//    [_damageReasonBtn setTitle:@"测试" forState:UIControlStateNormal];
    [_damageReasonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_damageReasonBtn addSubview:downImg1];
    
    //分割线
    UIView * divider6 = [[[UIView alloc] initWithFrame:CGRectMake(0, 225, 320, 1)] autorelease];
    divider6.backgroundColor = divider_color;
    [_aVeiw addSubview:divider6];
    
//    //送修方式
//    UILabel * sendWayBtnLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 230, 80, 30)] autorelease];
//    sendWayBtnLabel.text = @"送修方式";
//    sendWayBtnLabel.textColor = title_text_color;
//    [_aVeiw addSubview:sendWayBtnLabel];
//    
//    _sendWayBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 230, 200, 30)];
////    _sendWayBtn.backgroundColor = [UIColor yellowColor];
//    [_sendWayBtn setTitleColor:title_text_color forState:UIControlStateNormal];
//    [_aVeiw addSubview:_sendWayBtn];
//    [_sendWayBtn addTarget:self action:@selector(sendWayBtnClic:) forControlEvents:UIControlEventTouchUpInside];
//    UIImageView * downImg2 = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"down_btn"]] autorelease];
//    downImg2.frame = CGRectMake(180, 13, 11.5, 7);
//    [_sendWayBtn addSubview:downImg2];
//    
//    //分割线
//    UIView * divider7 = [[[UIView alloc] initWithFrame:CGRectMake(0, 265, 320, 1)] autorelease];
//    divider7.backgroundColor = divider_color;
//    [_aVeiw addSubview:divider7];
    
    //下一步
    _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 300, 280, 40)];
//    _nextBtn.frame = CGRectMake(20, 300, 280, 40);
    [_nextBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_aVeiw addSubview:_nextBtn];
    
    //服务热线电话
    _servicePhone = [[UIButton alloc] initWithFrame:CGRectMake(20, 350, 280, 40)];
//    _servicePhone.frame = CGRectMake(20, 350, 280, 40);
    [_servicePhone setTitle:@"客户服务热线：400-000-000" forState:UIControlStateNormal];
    _servicePhone.backgroundColor = [UIColor whiteColor];
    [_servicePhone setTitleColor:title_text_color forState:UIControlStateNormal];
    [_aVeiw addSubview:_servicePhone];
    
    [self myLocalBtnClick:nil];
}

//我的位置按钮
-(void)myLocalBtnClick:(id)sender
{
    [_asyRunner runOnBackground:^id {
        NSDictionary * city = [RequestUtils getMyCity];
        return city;
    }
                      onUpdateUI:^(id obj) {
                          [Utils saveCurrCity:obj];
                          [_info setValue:[obj objectForKey:@"id"] forKey:@"user_selected_city_id"];
                          [_cityBtn setTitle:[obj objectForKey:@"name"] forState:UIControlStateNormal];
                      } inView:self.view];
}

-(void)damageReasonBtnClick:(id)sender
{
    [_asyRunner runOnBackground:^id{
        return [RequestUtils phoneDamageReason];
    } onUpdateUI:^(id obj) {
        BOOL success = [[obj objectForKey:@"success"] boolValue];
        if (success) {
            self.damageReasonArray = [obj objectForKey:@"codes"];
            [self showDamageresonSelection:_damageReasonArray];
        }
    } inView:self.view];
}

//现实损坏原因选择项
-(void)showDamageresonSelection:(NSArray*)array
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] init];
    for (int i=0; i<array.count; i++) {
        [actionSheet addButtonWithTitle:[[array objectAtIndex:i] objectForKey:@"value"]];
    }
    [actionSheet addButtonWithTitle:@"取消"];
    actionSheet.title = @"选择损坏原因";
    actionSheet.delegate = self;
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons -1;
    actionSheet.tag = 2;
    [actionSheet showInView:self.view];
    [actionSheet release];
}

-(void)selectCity:(id)sender
{
    CitySelecteViewController * citySelecteVC = [[[CitySelecteViewController alloc] init] autorelease];
    citySelecteVC.passingParameters = self;
    [self.navigationController pushViewController:citySelecteVC animated:YES];
}

-(void)completeParameters:(id)obj withTag:(NSString *)tag
{
    NSLog(@"测试:%@",obj);
    [_info setValue:[obj objectForKey:@"id"] forKey:@"user_selected_city_id"];
    [_cityBtn setTitle:[obj objectForKey:@"name"] forState:UIControlStateNormal];
}

//选择送修方式
-(void)sendWayBtnClic:(id)sender
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]   initWithTitle:@"送修方式选择"
                                                                delegate:self
                                                       cancelButtonTitle:@"取消"
                                                  destructiveButtonTitle:nil
                                                       otherButtonTitles:@"自送维修网点",@"快递上门", nil];
    actionSheet.tag = 1;
    [actionSheet showInView:self.view];
    [actionSheet release];
}


//下一步按钮点击
-(void)nextBtnClick:(id)sender
{
    //根据用户选择的送修方式进入不同的页面
    NSString * city =                   [_cityBtn titleForState:UIControlStateNormal];
    NSString * name =                   _nameTF.text;
    NSString * phoneNumber =            _phoneNumberTF.text;
    NSString * connectPhoneNumber =     _connectPhoneNumberTF.text;
    NSString * damageReason =           [_damageReasonBtn titleForState:UIControlStateNormal];
//    NSString * sendWayBtn =                [_sendWayBtn titleForState:UIControlStateNormal];
    
    if (name.length == 0) {
        Show_msg(@"提示", @"姓名不能为空！");
        return;
    }
    
    if (phoneNumber.length == 0) {
        Show_msg(@"提示", @"手机号不能为空！");
        return;
    }
    
    if (connectPhoneNumber.length == 0) {
        Show_msg(@"提示", @"联系电话不能为空！");
        return;
    }
    
    if (_damageReasonBtn.titleLabel.text.length == 0) {
        Show_msg(@"提示", @"请选择损坏原因");
        return;
    }
    
//    if (sendWayBtn.length == 0) {
//        Show_msg(@"提示", @"请选择送修方式！");
//        return;
//    }
    
    [_info setValue:city forKey:@"city"];
    [_info setValue:name forKey:@"name"];
    [_info setValue:phoneNumber forKey:@"phoneNumber"];
    [_info setValue:connectPhoneNumber forKey:@"connectPhoneNumber"];
    [_info setValue:damageReason forKey:@"damageReason"];
    
    ClaimsConfirmInfoViewController * claimsConfirmInfoVC = [[[ClaimsConfirmInfoViewController alloc] init] autorelease];
    claimsConfirmInfoVC.info = _info;
    [self.navigationController pushViewController:claimsConfirmInfoVC animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendWayItemSelected:(int)buttonIndex
{
    NSLog(@"buttonIndex:%i",buttonIndex);
    if (buttonIndex == 0) {
        [_sendWayBtn setTitle:@"自送维修网点" forState:UIControlStateNormal];
    } else if(buttonIndex == 1) {
        [_sendWayBtn setTitle:@"快递上门" forState:UIControlStateNormal];
    }
}



#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag) {
        case 1://送修方式项目被选择
            [self sendWayItemSelected:buttonIndex];
            break;
        case 2:
            if (buttonIndex == _damageReasonArray.count) {
                return;
            }
            NSDictionary * damageReason = [_damageReasonArray objectAtIndex:buttonIndex];
            [_info setObject:damageReason forKey:@"damageReason"];
            [_damageReasonBtn setTitle:[damageReason objectForKey:@"value"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}



@end

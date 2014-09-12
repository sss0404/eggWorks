//
//  SelfHelpBuyViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-4-30.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "SelfHelpBuyViewController.h"
#import "Utils.h"
#import "RequestUtils.h"
#import "AsynRuner.h"
#import "ConfirmInformationViewController.h"
#import "MobilePhoneEasyPaySuccViewController.h"


@interface SelfHelpBuyViewController ()

@end

@implementation SelfHelpBuyViewController

@synthesize name = _name;
@synthesize phoneNumber = _phoneNumber;
@synthesize IMEI = _IMEI;
@synthesize brand = _brand;
@synthesize model = _model;
@synthesize scrollView = _scrollView;
@synthesize getIMEIView = _getIMEIView;
@synthesize tableView = _tableView;
@synthesize packages = _packages;
@synthesize sendSMS = _sendSMS;
@synthesize asynRunner = _asynRunner;
@synthesize verification = _verification;


- (void)dealloc
{
    [_name release]; _name = nil;
    [_phoneNumber release]; _phoneNumber = nil;
    [_IMEI release]; _IMEI = nil;
    [_brand release]; _brand = nil;
    [_model release]; _model = nil;
    [_scrollView release]; _scrollView = nil;
    [_getIMEIView release]; _getIMEIView = nil;
    [_tableView release]; _tableView = nil;
    [_packages release]; _packages = nil;
    [_sendSMS stop];
    [_sendSMS release]; _sendSMS = nil;
    [_asynRunner release]; _asynRunner = nil;
    [_verification release]; _verification = nil;
    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"填写信息";
    self.view.backgroundColor = [UIColor whiteColor];
//    float ios7_d_height = 0;
//    if (IOS7) {
//        ios7_d_height = IOS7_HEIGHT;
//    }
    
    isSelected = NO;
    
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kScreenHeight)];
    
    [self.view addSubview:_scrollView];
//    scrollView.backgroundColor = [UIColor greenColor];
//    scrollView.showsVerticalScrollIndicator = YES;
    
    
    UILabel * titleNote = [[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, 40)] autorelease];
    titleNote.textColor = orange_color;
    titleNote.backgroundColor = [UIColor clearColor];
    titleNote.text = @"请填写申购信息";
    [_scrollView addSubview:titleNote];
    
    //橙色分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 45, 320, 2)] autorelease];
    divider.backgroundColor = orange_color;
    [_scrollView addSubview:divider];
    
    //姓名
    UILabel * nameLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 50, 60, 30)] autorelease];
    nameLabel.text = @"姓名";
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = title_text_color;
    [_scrollView addSubview:nameLabel];
    
    _name = [[UITextField alloc] initWithFrame:CGRectMake(80, 50, 220, 30)];
    _name.delegate = self;
    _name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_scrollView addSubview:_name];
    
    //分割线
    UIView * divider1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 85, 320, 1)] autorelease];
    divider1.backgroundColor = divider_color;
    [_scrollView addSubview:divider1];
    
    //手机号
    UILabel * phoneNumberLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 90, 60, 30)] autorelease];
    phoneNumberLabel.text = @"手机号";
    phoneNumberLabel.backgroundColor = [UIColor clearColor];
    phoneNumberLabel.textColor = title_text_color;
    [_scrollView addSubview:phoneNumberLabel];
    
    _phoneNumber = [[UITextField alloc] initWithFrame:CGRectMake(80, 90, 130, 30)];
    _phoneNumber.delegate = self;
    _phoneNumber.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_scrollView addSubview:_phoneNumber];
    
    //发送短信按钮
    self.sendSMS = [[[CountdownButton alloc] initWithFrame:CGRectMake(214, 90, 100, 30)] autorelease];
    [_sendSMS setTitle:@"发送手机校验码" forState:UIControlStateNormal];
    [_sendSMS setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _sendSMS.font = [UIFont systemFontOfSize:14];
    [_sendSMS addTarget:self action:@selector(sendSMSBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_sendSMS];
    
    //验证码
    UIView * divider11 = [[[UIView alloc] initWithFrame:CGRectMake(0, 125, 320, 1)] autorelease];
    divider11.backgroundColor = divider_color;
    [_scrollView addSubview:divider11];
    
    // 验证码
    UILabel * verificationLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 130, 60, 30)] autorelease];
    verificationLabel.text = @"验证码";
    verificationLabel.backgroundColor = [UIColor clearColor];
    verificationLabel.textColor = title_text_color;
    [_scrollView addSubview:verificationLabel];
    
    self.verification = [[[UITextField alloc] initWithFrame:CGRectMake(80, 130, 220, 30)] autorelease];
    _verification.delegate = self;
    _verification.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_scrollView addSubview:_verification];
    
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 165, 320, 1)] autorelease];
    divider2.backgroundColor = divider_color;
    [_scrollView addSubview:divider2];
    
    //IMEI
    UILabel * imeiLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 170, 60, 30)] autorelease];
    imeiLabel.text = @"IMEI";
    imeiLabel.backgroundColor = [UIColor clearColor];
    imeiLabel.textColor = title_text_color;
    [_scrollView addSubview:imeiLabel];
    
    _IMEI = [[[UITextField alloc] initWithFrame:CGRectMake(80, 170, 220, 30)] autorelease];
    _IMEI.delegate = self;
    _IMEI.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_scrollView addSubview:_IMEI];
    
    //分割线
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 205, 320, 1)] autorelease];
    divider3.backgroundColor = divider_color;
    [_scrollView addSubview:divider3];
    
    UIButton * getIMEILabel = [[[UIButton alloc] initWithFrame:CGRectMake(20, 210, 280, 35)] autorelease];
    getIMEILabel.tag = 10;
    [getIMEILabel setTitle:@"如何获取IMEI号?" forState:UIControlStateNormal];
    [getIMEILabel setTitleColor:[UIColor colorWithRed:.38 green:.76 blue:.98 alpha:1] forState:UIControlStateNormal];
    [getIMEILabel addTarget:self action:@selector(getImeiLabelClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:getIMEILabel];
    
    //分割线
    UIView * divider4 = [[[UIView alloc] initWithFrame:CGRectMake(0, 250, 320, 1)] autorelease];
    divider4.backgroundColor = divider_color;
    divider4.tag = 11;
    [_scrollView addSubview:divider4];
    
    
    //品牌
    UILabel * brandLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 255, 60, 30)] autorelease];
    brandLabel.textColor = title_text_color;
    brandLabel.text = @"品牌";
    brandLabel.backgroundColor = [UIColor clearColor];
    brandLabel.tag = 1;
    [_scrollView addSubview:brandLabel];
    
    _brand = [[[UITextField alloc] initWithFrame:CGRectMake(80, 255, 215, 30)] autorelease];
    _brand.delegate = self;
    _brand.tag = 2;
    _brand.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _brand.enabled = NO;
    _brand.text = @"apple";
    [_scrollView addSubview:_brand];
    
    //分割线
    UIView * divider5 = [[[UIView alloc] initWithFrame:CGRectMake(0, 290, 320, 1)] autorelease];
    divider5.backgroundColor = divider_color;
    divider5.tag = 3;
    [_scrollView addSubview:divider5];
    
    //型号
    UILabel * modelLabel = [[[UILabel alloc] initWithFrame:CGRectMake(20, 295, 60, 30)] autorelease];
    modelLabel.text = @"型号";
    modelLabel.textColor = title_text_color;
    modelLabel.backgroundColor = [UIColor clearColor];
    modelLabel.tag = 4;
    [_scrollView addSubview:modelLabel];
    
    _model = [[UITextField alloc] initWithFrame:CGRectMake(80, 295, 295, 30)];
    _model.text = [Utils deviceString];
    _model.enabled = NO;
    _model.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _model.tag = 5;
    [_scrollView addSubview:_model];
    
    //分割线
    UIView * divider6 = [[[UIView alloc] initWithFrame:CGRectMake(0, 330, 320, 1)] autorelease];
    divider6.backgroundColor = divider_color;
    divider6.tag = 6;
    [_scrollView addSubview:divider6];
    
    UILabel * packageTitleNote = [[[UILabel alloc] initWithFrame:CGRectMake(20, 335, 280, 40)] autorelease];
    packageTitleNote.textColor = orange_color;
    packageTitleNote.text = @"选择套餐（保障期一年）";
    packageTitleNote.tag = 7;
    [_scrollView addSubview:packageTitleNote];
    
    //橙色分割线
    UIView * divider_ = [[[UIView alloc] initWithFrame:CGRectMake(0, 380, 320, 2)] autorelease];
    divider_.backgroundColor = orange_color;
    divider_.tag = 8;
    [_scrollView addSubview:divider_];
    
    //告诉用户如何获取imei号码
    _getIMEIView = [[UIView alloc] initWithFrame:CGRectMake(20, 210, 280, 240)];
    _getIMEIView.hidden = YES;
    _getIMEIView.tag = 9;
    [_scrollView addSubview:_getIMEIView];
    [self addGetIMEIOfHelpeContent];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 385, 320, 200)];
    _tableView.tag = 12;
    [_scrollView addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor greenColor];
    
    //提交按钮
    UIButton * submitBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 385+_tableView.frame.size.height+10, 280, 40)] autorelease];
    submitBtn.tag = 13;
    [submitBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [submitBtn setTitle:@"确认并提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:submitBtn];
    
    //服务条款
    UIButton * termsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(90, submitBtn.frame.origin.y+submitBtn.frame.size.height+10, 140, 35)] autorelease];
    [termsBtn setTitle:@"阅读并同意服务条款" forState:UIControlStateNormal];
    [termsBtn setFont:[UIFont systemFontOfSize:14.5]];
    [termsBtn setTitleColor:[UIColor colorWithRed:.38 green:.76 blue:.98 alpha:1] forState:UIControlStateNormal];
    termsBtn.tag = 14;
    [_scrollView addSubview:termsBtn];
    
    UIButton * agreeBtn = [[[UIButton alloc] initWithFrame:CGRectMake(55, submitBtn.frame.origin.y+submitBtn.frame.size.height+16, 20, 20)] autorelease];
    [agreeBtn setBackgroundImage:[UIImage imageNamed:@"check_box_cancel"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    agreeBtn.tag = 15;
    [_scrollView addSubview:agreeBtn];
    
    
    [self setScrollViewContentSizeWithTableViewHeight:_tableView.frame.size.height];
    [self getPackagesFromServer];
}

//获取手机无忧套餐列表
-(void)getPackagesFromServer
{
    AsynRuner * asynRunner = [[AsynRuner alloc] init];
    [asynRunner runOnBackground:^{
        self.packages = [RequestUtils queryMobileServiceProducts];
        return @"";
    } onUpdateUI:^(id obj){
        [_tableView reloadData];
    } inView:self.view];
    
}

//同意服务条款按钮
-(void)agreeBtnClick:(id)sender
{
    if (isSelected) {
        isSelected = NO;
        [((UIButton*)sender) setBackgroundImage:[UIImage imageNamed:@"check_box_cancel"] forState:UIControlStateNormal];
    } else {
        isSelected = YES;
        [((UIButton*)sender) setBackgroundImage:[UIImage imageNamed:@"check_box_ok"] forState:UIControlStateNormal];
    }
}

//提交按钮
-(void)submitBtnClick:(id)sender
{
    //
    
//    MobilePhoneEasyPaySuccViewController * mobilePhoneEasePaySuccVC = [[[MobilePhoneEasyPaySuccViewController alloc] init] autorelease];
//    [self.navigationController pushViewController:mobilePhoneEasePaySuccVC animated:YES];
//    //以上代码为测试页面使用
//    return;
    
    if (_name.text.length == 0) {
        Show_msg(@"提示", @"请输入姓名");
        return;
    }
    if (![Utils verifyPhoneNumber:_phoneNumber.text]) {
        Show_msg(@"提示", @"请输入正确的手机号");
        return;
    }
    if (_IMEI.text.length == 0) {
        Show_msg(@"提示", @"请输入IMEI号");
        return;
    }
    if (currSelected == nil) {
        Show_msg(@"提示", @"请选择套餐");
        return;
    }
    if (!isSelected) {
        Show_msg(@"提示", @"请选择阅读并同意服务条款");
        return;
    }
    
    ConfirmInformationViewController * confirmInfoVC = [[[ConfirmInformationViewController alloc] init] autorelease];
    confirmInfoVC.product = currSelected;
    confirmInfoVC.name = _name.text;
    confirmInfoVC.phoneNumber = _phoneNumber.text;
    confirmInfoVC.IMEI = _IMEI.text;
    confirmInfoVC.boand = _brand.text;
    confirmInfoVC.model = _model.text;
    [self.navigationController pushViewController:confirmInfoVC animated:YES];
}

-(void)setScrollViewContentSizeWithTableViewHeight:(float)height
{
    _scrollView.contentSize=CGSizeMake(320,288+height + 180+40);
}

-(void)getImeiLabelClick:(id) sender
{
   float h =  _getIMEIView.frame.size.height - 35;
    NSLog(@"如何获取imei");
    NSArray * views = _scrollView.subviews;
    for (int i=0; i<views.count; i++) {
        UIView * view = [views objectAtIndex:i];
        
        if (view.tag != 0) {
            if (view.tag == 9) {
                view.hidden = NO;
            } else if(view.tag == 10){
                view.hidden = YES;
            } else {
                view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y + h, view.frame.size.width, view.frame.size.height);
            }
        }
    }
    _scrollView.contentSize = CGSizeMake(320,_scrollView.contentSize.height + h);
}

//
-(void) addGetIMEIOfHelpeContent
{
    UITextView * content = [[[UITextView alloc] initWithFrame:CGRectMake(0, 10, 280, 80)] autorelease];
    content.text = @"请前往本机                                   查看本\n机的IMEI号，拷贝并粘贴到上方输入框中";
    content.font = [UIFont systemFontOfSize:14];
    content.editable = NO;
    content.scrollEnabled = NO;
    [_getIMEIView addSubview:content];
    
    UITextView * settingNote = [[[UITextView alloc] initWithFrame:CGRectMake(78, 10, 160, 80)] autorelease];
    settingNote.text = @"设置>通用>关于本机";
    settingNote.editable = NO;
    settingNote.scrollEnabled = NO;
    settingNote.backgroundColor = [UIColor clearColor];
    settingNote.font = [UIFont systemFontOfSize:14];
    settingNote.textColor = [UIColor colorWithRed:.38 green:.76 blue:.98 alpha:1];
    [_getIMEIView addSubview:settingNote];
    
    UIImageView * img = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"copy_imei_note_img"]] autorelease];
    img.frame = CGRectMake(0, 60, 280, 123);
    [_getIMEIView addSubview:img];
    
    UIButton * btn = [[[UIButton alloc] initWithFrame:CGRectMake(0, 185, 280, 40)] autorelease];
    [btn setTitle:@"长按复制哦！" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:.38 green:.76 blue:.98 alpha:1] forState:UIControlStateNormal];
    [_getIMEIView addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendSMSBtnClick:(id)sender
{
    if (![Utils verifyPhoneNumber:_phoneNumber.text]) {
        Show_msg(@"提示", @"请输入正确的手机号");
        return;
    }
    int second = _sendSMS.seconds;
    if (second == 0) {
        NSLog(@"发送短信");
        [_asynRunner runOnBackground:^id{
            NSDictionary * dic = [RequestUtils sendSMSVerifyWithNumber:_phoneNumber.text];
            BOOL success = [[dic objectForKey:@"success"] boolValue];
            return success ? @"ok" : @"fail";
        } onUpdateUI:^(id obj) {
            if ([obj isEqualToString:@"ok"]) {
                [_sendSMS start];
            } else {
                Show_msg(@"提示", @"发送失败，请重试!");
            }
        } inView:self.view];
    }
}

#pragma mark - UItableView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    int count = 29;
//    tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, count *45);
//    NSArray * views = _scrollView.subviews;
//    for (int i=0; i<views.count; i++) {
//        UIView * view = [views objectAtIndex:i];
//        int tag = view.tag;
//        if (tag==13||tag==14||tag==15) {
//            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y+count*17, view.frame.size.width, view.frame.size.height);
////            _scrollView.contentSize = CGSizeMake(320,_scrollView.contentSize.height + 50);
//        }
//    }
//    _scrollView.contentSize = CGSizeMake(320,_scrollView.contentSize.height + 17*count);
    return [_packages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"UITableViewCellItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId] autorelease];
    }
    PhoneEasyProduct * product = [_packages objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",product.price, product.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.row:%i",indexPath.row);
    currSelected = [_packages objectAtIndex:indexPath.row];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"什么情况 ：%f",self.view.frame.size.height);
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

@end

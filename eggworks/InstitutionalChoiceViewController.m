//
//  InstitutionalChoiceViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-20.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "InstitutionalChoiceViewController.h"
#import "RequestUtils.h"
#import "Utils.h"

@interface InstitutionalChoiceViewController ()

@end

@implementation InstitutionalChoiceViewController

@synthesize asynRunner = _asynRunner;
@synthesize searchInputTextField = _searchInputTextField;
@synthesize bank = _bank;
@synthesize fund = _fund;
@synthesize securities = _securities;
@synthesize insurance = _insurance;
@synthesize institutionsArrayWithKey = _institutionsArrayWithKey;
@synthesize institutionsKeys = _institutionsKeys;
@synthesize institutionsTableView = _institutionsTableView;
@synthesize searchTableView = _searchTableView;
@synthesize searchArray = _searchArray;
@synthesize dataFromServer = _dataFromServer;
@synthesize isLoading = _isLoading;

static NSMutableArray * currSelectedInstitutions;//当前选择的机构

//获取用户选择的机构
+(NSArray*)getCurrSelectedInstitutional
{
    return currSelectedInstitutions;
}
- (void)dealloc
{
    [_asynRunner release]; _asynRunner = nil;
    [_searchInputTextField release]; _searchInputTextField = nil;
    [_bank release]; _bank = nil;
    [_fund release]; _fund = nil;
    [_securities release]; _securities = nil;
    [_insurance release]; _insurance = nil;
    [_institutionsArrayWithKey release]; _institutionsArrayWithKey = nil;
    [_institutionsKeys release]; _institutionsKeys = nil;
    [_institutionsTableView release]; _institutionsTableView = nil;
    [_searchTableView release]; _searchTableView = nil;
    [_searchArray release]; _searchArray = nil;
    [_dataFromServer release]; _dataFromServer = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _isLoading = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"机构选择";
    
    currSelectedInstitutions = [[NSMutableArray alloc] init];
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    self.searchArray = [[[NSMutableArray alloc] init] autorelease];
    self.institutionsArrayWithKey = [[[NSMutableDictionary alloc] init] autorelease];
    self.institutionsKeys = [[[NSMutableArray alloc] init] autorelease];
    
    _asynRunner = [[ AsynRuner alloc] init];
    
    UIImageView * inputBg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 4+ios7_d_height, 320, 44)] autorelease];
    inputBg.image = [UIImage imageNamed:@"search_input"];
    [self.view addSubview:inputBg];
    
    self.searchInputTextField = [[[UITextField alloc] initWithFrame:CGRectMake(20, 4+ios7_d_height, 240, 44)] autorelease];
    _searchInputTextField.delegate = self;
    [self.view addSubview:_searchInputTextField];
    
    UIButton * searchBtn = [[[UIButton alloc] initWithFrame:CGRectMake(270, 17+ios7_d_height, 19, 19.5)] autorelease];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_input_confi"] forState:UIControlStateNormal];
    [self.view addSubview:searchBtn];
    
    //机构筛选选项
    UIView * optionsView = [[[UIView alloc] initWithFrame:CGRectMake(0, ios7_d_height+47, 320, 60)] autorelease];
//    optionsView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:optionsView];
    
    //分割线
    UIView * divider1 = [[[UIView alloc] initWithFrame:CGRectMake(0, 60, 320, 1)] autorelease];
    divider1.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [optionsView addSubview:divider1];
    
    UIImageView * optionsViewTitleBg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)] autorelease];
    optionsViewTitleBg.image = [UIImage imageNamed:@"screening_diver"];
    [optionsView addSubview:optionsViewTitleBg];
    
    //分割线
    UIView * divider = [[[UIView alloc] initWithFrame:CGRectMake(0, 20, 320, 1)] autorelease];
    divider.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [optionsView addSubview:divider];
    
    self.bank = [[[CheckBox alloc] initWithFrame:CGRectMake(20, 35, 70, 15)] autorelease];
    _bank.title.text = @"银行";
    [_bank addTarget:self action:@selector(bankSelected:) forControlEvents:UIControlEventTouchUpInside];
    [_bank setCheck:YES];
    [optionsView addSubview:_bank];
    
    self.fund = [[[CheckBox alloc] initWithFrame:CGRectMake(90, 35, 70, 15)] autorelease];
    _fund.title.text = @"基金";
    [_fund setCheck:YES];
    [_fund addTarget:self action:@selector(fundSelected:) forControlEvents:UIControlEventTouchUpInside];
    [optionsView addSubview:_fund];
    
//    self.securities = [[[CheckBox alloc] initWithFrame:CGRectMake(160, 35, 70, 15)] autorelease];
//    _securities.title.text = @"证券";
//    [optionsView addSubview:_securities];
    
    self.insurance = [[[CheckBox alloc] initWithFrame:CGRectMake(160, 35, 70, 15)] autorelease];
    _insurance.title.text = @"保险";
    [_insurance setCheck:YES];
    [_insurance addTarget:self action:@selector(insuranceSelected:) forControlEvents:UIControlEventTouchUpInside];
    [optionsView addSubview:_insurance];
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    divider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [optionsView addSubview:divider2];
    
    UIView * tempView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, kApplicationHeight+20 - 60, 320, 60)] autorelease];
//    tempView2.backgroundColor = [UIColor blueColor];
    [self.view addSubview:tempView2];
    [tempView2 addSubview:divider2];
    
    UIButton * confgBtn = [[[UIButton alloc] initWithFrame:CGRectMake(140, 10, 151, 37.5)] autorelease];
    [confgBtn setImage:[UIImage imageNamed:@"okBtnSmall"] forState:UIControlStateNormal];
    [confgBtn addTarget:self action:@selector(confgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempView2 addSubview:confgBtn];
    
    UIButton * resultBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 101.5, 37.5)] autorelease];
    [resultBtn setImage:[UIImage imageNamed:@"result"] forState:UIControlStateNormal];
    [resultBtn addTarget:self action:@selector(resultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempView2 addSubview:resultBtn];
    
    self.institutionsTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, ios7_d_height+108, 320, kApplicationHeight+20-60-60-109)] autorelease];
    _institutionsTableView.delegate = self;
    _institutionsTableView.dataSource = self;
    _institutionsTableView.tag = 1;
    [self.view addSubview:_institutionsTableView];
    
    self.searchTableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 48+ios7_d_height, 320, kApplicationHeight+20-48)] autorelease];
    _searchTableView.hidden = YES;
    _searchTableView.dataSource = self;
    _searchTableView.delegate = self;
    _searchTableView.tag = 2;
    [self.view addSubview:_searchTableView];
    
    [self getInstitutions];
}




-(void) confgBtnClick:(id)sender
{
    NSLog(@"确认按钮被点击");
    //保存当前选中的机构 并且返回上一页
//    [Utils saveCurrSelectedInstitutional:currSelectedInstitutions];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) resultBtnClick:(id)sender
{
    NSLog(@"重置");
//    [Utils saveCurrSelectedInstitutional:nil];
    [currSelectedInstitutions removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//用户选中银行
-(void)bankSelected:(id)sender
{
    if (_isLoading) {
        [_bank setCheck:!_bank.selected];
        return;
    }
    [self getInstitutions];
    
}

//用户选中基金
-(void)fundSelected:(id)sender
{
    if (_isLoading) {
        [_bank setCheck:!_fund.selected];
        return;
    }
    [self getInstitutions];
    
}

//用户选中保险
-(void)insuranceSelected:(id)sender
{
    if (_isLoading) {
        [_bank setCheck:!_insurance.selected];
        return;
    }
    [self getInstitutions];
    
}

//获取当前用户选中的机构
-(NSArray*)getUserSelectedInstitutions
{
    //如果用户进来则默认全选中
    NSMutableArray * arrayTemp = [[[NSMutableArray alloc] init] autorelease];
    if (_bank.selected) {
        [arrayTemp addObject:@"bank"];
    }
    if (_fund.selected) {
        [arrayTemp addObject:@"fund"];
    }
    if (_insurance.selected) {
        [arrayTemp addObject:@"insurance"];
    }
    return arrayTemp;
}

//获取机构
-(void)getInstitutions
{
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    
    [_asynRunner runOnBackground:^{
        
        NSArray * institutionsArray = [self getUserSelectedInstitutions];
        //如果用户没有选中任何机构则返回
        if (institutionsArray.count == 0) {
            //清除目前的数据
            [_institutionsArrayWithKey removeAllObjects];
            [_institutionsKeys removeAllObjects];
            return @"";
        }
        
        NSDictionary * dic = [RequestUtils getInstitutionsWithInstitutions:institutionsArray];
        if ([[dic objectForKey:@"success"] boolValue]) {
            NSArray * citys = [dic objectForKey:@"parties"];
            self.dataFromServer = citys;
            //清除目前的数据
            [_institutionsArrayWithKey removeAllObjects];
            [_institutionsKeys removeAllObjects];
            //对机构进行分类
            for (int i=0; i<citys.count; i++) {
                NSDictionary * cityDic = [citys objectAtIndex:i];
                NSString * first_letter = [cityDic objectForKey:@"first_letter"];//城市的第一个字母
                if (first_letter != NULL) {
                    NSMutableArray * array = [_institutionsArrayWithKey objectForKey:first_letter];
                    if (array == nil) {
                        array = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
                        [_institutionsArrayWithKey setObject:array forKey:first_letter];
                    }
                    [array addObject:cityDic];
                }
            }
            
            //对数据进行排序
            [_institutionsKeys addObjectsFromArray:[[_institutionsArrayWithKey allKeys] sortedArrayUsingSelector:@selector(compare:)]];
        }
        return @"";
    }
                      onUpdateUI:^(id obj)
     {
         [_institutionsTableView reloadData];
         _isLoading = NO;
     } inView:self.view];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * key;
    int result = 0;
    switch (tableView.tag) {
        case 1:
            key = [_institutionsKeys objectAtIndex:section];
            result = [[_institutionsArrayWithKey objectForKey:key] count];
            break;
        case 2:
            result = _searchArray.count;
            break;
        default:
            break;
    }
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int result = 0;
    switch (tableView.tag) {
        case 1:
            result = _institutionsKeys.count;
            break;
        case 2:
            result = 1;
            break;
        default:
            break;
    }
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CountryCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    
    NSString * key;
    NSDictionary * dic;
    switch (tableView.tag) {
        case 1:
            key = [_institutionsKeys objectAtIndex:indexPath.section];
            NSArray * array = [_institutionsArrayWithKey objectForKey:key];
            NSDictionary * cityDic = [array objectAtIndex:indexPath.row];
            cell.textLabel.text = [cityDic objectForKey:@"name"];
            break;
        case 2:
            dic = [_searchArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [dic objectForKey:@"name"];
            break;
        default:
            break;
    }
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * result = nil;
    switch (tableView.tag) {
        case 1:
            result = [_institutionsKeys objectAtIndex:section];
            break;
            result = nil;
        default:
            break;
    }
    
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * key;
    switch (tableView.tag) {
        case 1:
            key = [_institutionsKeys objectAtIndex:indexPath.section];
            NSArray * array = [_institutionsArrayWithKey objectForKey:key];
            NSDictionary * cityDic = [array objectAtIndex:indexPath.row];
            [currSelectedInstitutions addObject:cityDic];
            break;
        case 2:
            [currSelectedInstitutions removeAllObjects];
            NSDictionary * dic = [_searchArray objectAtIndex:indexPath.row];
            [currSelectedInstitutions addObject:dic];
            [self.navigationController popViewControllerAnimated:YES];
            break;
        default:
            break;
    }
    
}

//为表视图添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSArray * array;
    switch (tableView.tag) {
        case 1:
            array = _institutionsKeys;
            break;
        case 2:
            array = nil;
            break;
        default:
            break;
    }
    return array;
}


//开始编辑输入框的时候，软键盘出现，执行此事件
#pragma mark - textFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [super textFieldDidBeginEditing:textField];
//    searchArray
    _searchTableView.hidden = NO;
}

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [super textFieldShouldReturn:textField];
    NSLog(@"用户输入：%@", textField.text);
    [self searchWithStr:textField.text];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [super textFieldDidEndEditing:textField];
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+50);
}

#pragma mark - 搜索
//更具关键字搜索
-(void)searchWithStr:(NSString *) str
{
    if (str.length == 0) {
        return;
    }
    
    [_asynRunner runOnBackground:^id{
        [_searchArray removeAllObjects];
        for (int i=0; i<_dataFromServer.count; i++) {
            NSDictionary * data = [_dataFromServer objectAtIndex:i];
            NSString * name = [data objectForKey:@"name"];
            NSRange foundObj = [name rangeOfString:str options:NSCaseInsensitiveSearch];
            if (foundObj.length > 0) {//表示包含
                [_searchArray addObject:data];
            }
        }
        return @"";
    } onUpdateUI:^(id obj) {
        [_searchTableView reloadData];
    } inView:self.view];
}




@end

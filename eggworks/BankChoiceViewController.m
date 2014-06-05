//
//  BankChoiceViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-29.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "BankChoiceViewController.h"
#import "RequestUtils.h"
#import "BankSelectedTableViewCell.h"

@interface BankChoiceViewController ()

@end

@implementation BankChoiceViewController

@synthesize asynRunner = _asynRunner;
@synthesize tableView = _tableView;
@synthesize isLoading = _isLoading;
@synthesize institutionsArrayWithKey = _institutionsArrayWithKey;
@synthesize institutionsKeys = _institutionsKeys;
@synthesize dataFromServer = _dataFromServer;
@synthesize bankSelected = _bankSelected;

- (void)dealloc
{
    [_asynRunner release]; _asynRunner = nil;
    [_tableView release]; _tableView = nil;
    [_institutionsArrayWithKey release]; _institutionsArrayWithKey = nil;
    [_dataFromServer release]; _dataFromServer = nil;
    [_bankSelected release]; _bankSelected = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资金账户";
    self.asynRunner = [[[AsynRuner alloc] init] autorelease];
    _isLoading = NO;
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    self.institutionsArrayWithKey = [[[NSMutableDictionary alloc] init] autorelease];
    self.institutionsKeys = [[[NSMutableArray alloc] init] autorelease];
    self.bankSelected = [[[NSMutableSet alloc] init] autorelease];
    
    UITextView * topText = [[[UITextView alloc] initWithFrame:CGRectMake(20, 10, 280, 130)] autorelease];
    topText.scrollEnabled = NO;
    topText.editable = NO;
    topText.font = [UIFont systemFontOfSize:16];
    topText.text = @"为了方便您快速购买相关的理财产品，请选择您开设有资金账户的银行：";
    [self.view addSubview:topText];
    
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(0, 80+ios7_d_height, 320, kApplicationHeight-185)] autorelease];
//    _tableView.backgroundColor = [UIColor yellowColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    //立即查看按钮
    UIButton * submitBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, kApplicationHeight - 35, 280, 40)] autorelease];
    [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = [UIColor colorWithRed:.85 green:.21 blue:.20 alpha:1];
    [self.view addSubview:submitBtn];
    
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0,  kApplicationHeight - 45, 320, 1)] autorelease];
    divider3.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [self.view addSubview:divider3];
    
    [self getInstitutions];
}

-(void)submitClick:(id)sender
{
    NSEnumerator *enumerator = [_bankSelected objectEnumerator];//获取一个迭代器
    NSMutableArray * dicArray = [[[NSMutableArray alloc] init] autorelease];
    for (NSIndexPath * indexPath in enumerator) {
        NSString * key = [_institutionsKeys objectAtIndex:indexPath.section];
        NSArray * array = [_institutionsArrayWithKey objectForKey:key];
        NSDictionary * cityDic = [array objectAtIndex:indexPath.row];
        [dicArray addObject:cityDic];
        NSLog(@"用户选中的银行:%@",[cityDic objectForKey:@"name"]);
    }
    [self.passingParameters completeParameters:dicArray withTag:self.resultCode];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取当前用户选中的机构
-(NSArray*)getUserSelectedInstitutions
{
    //如果用户进来则默认全选中
    NSMutableArray * arrayTemp = [[[NSMutableArray alloc] init] autorelease];
    [arrayTemp addObject:@"bank"];
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
         [_tableView reloadData];
         _isLoading = NO;
     }];
}

-(void)checkBoxClick:(id)sender
{
    CheckBox * checkBox = (CheckBox*)sender;
    NSIndexPath * indexPath = checkBox.indexPath;
    BOOL isContians = [_bankSelected containsObject:indexPath];
    if (isContians) {
        //如果已经存在
        [_bankSelected removeObject:indexPath];
    } else {
        [_bankSelected addObject:indexPath];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * key = [_institutionsKeys objectAtIndex:section];
    int result = [[_institutionsArrayWithKey objectForKey:key] count];
    return result;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _institutionsKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CountryCell";
    BankSelectedTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[BankSelectedTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    
    NSString * key = [_institutionsKeys objectAtIndex:indexPath.section];
    NSArray * array = [_institutionsArrayWithKey objectForKey:key];
    NSDictionary * cityDic = [array objectAtIndex:indexPath.row];
    cell.checkBox.title.text = [cityDic objectForKey:@"name"];
    cell.checkBox.indexPath = indexPath;
    [cell.checkBox addTarget:self action:@selector(checkBoxClick:) forControlEvents:UIControlEventTouchUpInside];
//    BOOL isContains = [_bankSelected containsObject:indexPath];
    [cell.checkBox setCheck:[_bankSelected containsObject:indexPath]];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * result = [_institutionsKeys objectAtIndex:section];
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    NSLog(@"dddddd");
}

//为表视图添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _institutionsKeys;
}

@end

//
//  CitySelecteViewController.m
//  eggworks
//
//  Created by 陈 海刚 on 14-5-15.
//  Copyright (c) 2014年 陈 海刚. All rights reserved.
//

#import "CitySelecteViewController.h"
#import "RequestUtils.h"
#import "Utils.h"

@interface CitySelecteViewController ()

@end

@implementation CitySelecteViewController

@synthesize cityTableVeiw = _cityTableVeiw;
@synthesize asynRunner = _asynRunner;
@synthesize citysArrayWithKey = _citysArrayWithKey;
@synthesize citiesKeys = _citiesKeys;
@synthesize lastTimeSelectedCity = _lastTimeSelectedCity;
//@synthesize citys = _citys;


- (void)dealloc
{
    [_cityTableVeiw release]; _cityTableVeiw = nil;
    [_asynRunner release]; _asynRunner = nil;
//    [_citys release]; _citys = nil;
    [_citysArrayWithKey release]; _citysArrayWithKey = nil;
    [_citiesKeys release]; _citiesKeys = nil;
    [_lastTimeSelectedCity release]; _lastTimeSelectedCity = nil;
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"所在城市";
    self.view.backgroundColor = [UIColor whiteColor];
    
    float ios7_d_height = 0;
    if (IOS7) {
        ios7_d_height = IOS7_HEIGHT;
    }
    
    _lastTimeSelectedCity = [Utils getCurrSelectedCity];
    
    self.citysArrayWithKey = [[[NSMutableDictionary alloc] init] autorelease];
    self.citiesKeys = [[[NSMutableArray alloc] init] autorelease];
    
    _asynRunner = [[AsynRuner alloc] init];
    
    //
    UIButton * label = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0+ios7_d_height, 320, 50)] autorelease];
    [label setTitle:@"您主要在哪个城市进行投资" forState:UIControlStateNormal];
    [label setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UIImageView * sigin = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 50+ios7_d_height, 320, 10)] autorelease];
    sigin.image = [UIImage imageNamed:@"screening_diver"];
    [self.view addSubview:sigin];
    
    //定位按钮
    UIView * tempView = [[[UIView alloc] initWithFrame:CGRectMake(0, 60+ios7_d_height, 320, 70)] autorelease];
    tempView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tempView];
    
    UIButton * gpsBtn = [[[UIButton alloc] initWithFrame:CGRectMake(15, 20, 275, 40)] autorelease];
    gpsBtn.backgroundColor = [UIColor redColor];
    [gpsBtn setTitle:@"定位城市" forState:UIControlStateNormal];
    [gpsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [gpsBtn addTarget:self action:@selector(gpsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempView addSubview:gpsBtn];
    
    UIView * divider3 = [[[UIView alloc] initWithFrame:CGRectMake(0, 70, 320, 1)] autorelease];
    divider3.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [tempView addSubview:divider3];
    
    //城市选择列表
    _cityTableVeiw = [[[UITableView alloc] initWithFrame:CGRectMake(0, 131+ios7_d_height, 320, kApplicationHeight+20-250) style:UITableViewStylePlain] autorelease];
    _cityTableVeiw.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _cityTableVeiw.dataSource = self;
    _cityTableVeiw.delegate = self;
    [self.view addSubview:_cityTableVeiw];
    
    UIView * tempView2 = [[[UIView alloc] initWithFrame:CGRectMake(0, kApplicationHeight+20 - 60, 320, 60)] autorelease];
    [self.view addSubview:tempView2];
    
    UIButton * confgBtn = [[[UIButton alloc] initWithFrame:CGRectMake(20, 10, 280, 40)] autorelease];
    [confgBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confgBtn setBackgroundImage:[UIImage imageNamed:orange_btn_bg_name] forState:UIControlStateNormal];
    [confgBtn addTarget:self action:@selector(confgBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempView2 addSubview:confgBtn];
    
    //分割线
    UIView * divider2 = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)] autorelease];
    divider2.backgroundColor = [UIColor colorWithRed:.83 green:.83 blue:.83 alpha:.8];
    [tempView2 addSubview:divider2];
    
    [self getCity];
}

-(void)backButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [Utils saveCurrCity:_lastTimeSelectedCity];
}

-(void)confgBtnClick:(id) sender
{
    if (currSelectedCity == nil) {
        Show_msg(@"提示", @"请选择城市");
        return;
    }
    //保存用户选择的城市
    [Utils saveCurrCity:currSelectedCity];
    NSLog(@"确定按钮被点击=%@",currSelectedCity);
    [self.passingParameters completeParameters:currSelectedCity withTag:self.resultCode];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)gpsBtnClick:(id)sender
{
    [_asynRunner runOnBackground:^
     {
         NSDictionary * dic = [RequestUtils getMyCity];
         return dic;
     }
                      onUpdateUI:^(id obj)
     {
         //添加定位城市
         [_citiesKeys insertObject:GPS atIndex:0];
         NSMutableArray * gpsCityArray = [[[NSMutableArray alloc] init] autorelease];
         [gpsCityArray addObject:obj];
         [_citysArrayWithKey setObject:gpsCityArray forKey:GPS];
         [_cityTableVeiw reloadData];
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取城市
-(void)getCity
{
    [_asynRunner runOnBackground:^{
        NSDictionary * dic = [RequestUtils getCitys];
        if ([[dic objectForKey:@"success"] boolValue]) {
            NSArray * citys = [dic objectForKey:@"cities"];
            
            //对城市进行分类
            for (int i=0; i<citys.count; i++) {
                NSDictionary * cityDic = [citys objectAtIndex:i];
                NSString * first_letter = [cityDic objectForKey:@"first_letter"];//城市的第一个字母
                if (first_letter != NULL) {
                    NSMutableArray * array = [_citysArrayWithKey objectForKey:first_letter];
                    if (array == nil) {
                        array = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
                        [_citysArrayWithKey setObject:array forKey:first_letter];
                    }
                    [array addObject:cityDic];
                    
                    //热门城市
                    BOOL hot = [[cityDic objectForKey:@"hot"] boolValue];
                    if (hot) {
                        NSMutableArray * htoCityArray = [_citysArrayWithKey objectForKey:HOT_CITY];
                        if (htoCityArray == nil) {
                            htoCityArray = [[[NSMutableArray alloc] initWithCapacity:20] autorelease];
                        }
                        [htoCityArray addObject:cityDic];
                    }
                }
            }
            
            //对数据进行排序
            [_citiesKeys addObjectsFromArray:[[_citysArrayWithKey allKeys] sortedArrayUsingSelector:@selector(compare:)]];
            BOOL iscontainHotCity = [_citiesKeys containsObject:HOT_CITY];
            if (iscontainHotCity) {
                [_citiesKeys removeObject:HOT_CITY];
                [_citiesKeys insertObject:HOT_CITY atIndex:0];
            }
        }
        return dic;
    }
                      onUpdateUI:^(id obj)
                      {
                          [_cityTableVeiw reloadData];
                          
                      }];
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+50);
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * key = [_citiesKeys objectAtIndex:section];
    return [[_citysArrayWithKey objectForKey:key] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _citiesKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CountryCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] autorelease];
    }
    NSString * key = [_citiesKeys objectAtIndex:indexPath.section];
    NSArray * array = [_citysArrayWithKey objectForKey:key];
    NSDictionary * cityDic = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = [cityDic objectForKey:@"name"];
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_citiesKeys objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * key = [_citiesKeys objectAtIndex:indexPath.section];
    NSArray * array = [_citysArrayWithKey objectForKey:key];
    NSDictionary * cityDic = [array objectAtIndex:indexPath.row];
    currSelectedCity = cityDic;
}

//为表视图添加索引
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _citiesKeys;
}

@end

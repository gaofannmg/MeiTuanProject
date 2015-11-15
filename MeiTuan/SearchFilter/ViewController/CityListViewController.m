//
//  CityListViewController.m
//  MeiTuan
//  
//  Created by GaoYong on 15/10/27.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "CityListViewController.h"
#import "CityListViewCell.h"
#import "HomeViewController.h"
@interface CityListViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *cityAry;
    NSMutableArray *keyArr;
}
@end

@implementation CityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, 64)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    outBtn.frame = CGRectMake(5,20,60, 44);
    outBtn.backgroundColor = [UIColor clearColor];
    outBtn.tintColor = RGB(45, 45, 45);
    [outBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 30)];
    [outBtn setImage:[UIImage imageNamed:@"icon_round_back"] forState:UIControlStateNormal];
    [outBtn setImage:[UIImage imageNamed:@"icon_round_back"] forState:UIControlStateHighlighted];
    [outBtn addTarget:self action:@selector(clickHomeView) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:outBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
    titleLabel.center = CGPointMake(headView.center.x, titleLabel.center.y);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"选择城市";
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textColor = RGB(45, 45, 45);
    [headView addSubview:titleLabel];
    
    UITableView *cityListTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(headView.frame), WIN_WIDTH, WIN_HIGHT -64) style:UITableViewStylePlain];
    cityListTabView.backgroundColor = [UIColor whiteColor];
    cityListTabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:cityListTabView];
    
    [cityListTabView registerClass:[CityListViewCell class] forCellReuseIdentifier:@"CityListViewCell.h"];
    cityListTabView.delegate = self;
    cityListTabView.dataSource = self;
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cityGroups" ofType:@"plist"];
    cityAry = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    keyArr =  [NSMutableArray array];
    
    for (int i = 0; i <cityAry.count; i ++)
    {
        NSDictionary *dic = cityAry[i];
        [keyArr addObject:dic[@"title"]];
    }
}
- (void) clickHomeView
{
    [self.navigationController popToRootViewControllerAnimated:YES];

}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return keyArr;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return cityAry.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *cityDic = cityAry[section];
    NSArray *sectionAry = cityDic[@"cities"];
    return sectionAry.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityDic = cityAry[indexPath.section];
    NSArray *sectionAry = cityDic[@"cities"];
    NSString *cityName = sectionAry[indexPath.row];
    
    CityListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CityListViewCell.h" forIndexPath:indexPath];
    [cell refreshCell:cityName];
    
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *cityDic = cityAry[indexPath.section];
    NSArray *sectionAry = cityDic[@"cities"];
    NSString *cityName = sectionAry[indexPath.row];
    
    [self.basicVC selectCity:cityName];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, 20)];
    titleView.backgroundColor = RGB(230, 230, 230);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0,titleView.frame.size.width, titleView.frame.size.height)];
    NSDictionary *dic = cityAry[section];
    NSString *titleStr = dic[@"title"];
    label.text = titleStr;
    label.font = [UIFont systemFontOfSize:15];
    [titleView addSubview:label];
    
    return titleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

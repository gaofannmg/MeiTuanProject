//
//  PushViewCont.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/17.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "DetailSecondCell.h"
#import "DetailThirdCell.h"
#import "DetailFourthCell.h"
#import "DetailFifthCell.h"
#import "DetailSixthCell.h"
#import "DetailSeventhCell.h"

@interface DetailViewController ()<DPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    DetailFourthCell *caucateCell;
    DetailFourthCell *caucateCell1;
    UITableView *detailTabView;
    NSDictionary *dataDict;
    NSDictionary *detaSecondDict;
    NSDictionary *detaFifthDict;
    NSDictionary *detaSixthDict;
    NSDictionary *detaFourthDict;
}
@end

@implementation DetailViewController

- (instancetype) init
{
    if (self == [super init])
    {
        
    }
    return self;
}



-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIView *titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    titleView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:titleView];
    
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    outBtn.frame = CGRectMake(5,30,60, 30);
    outBtn.backgroundColor = [UIColor whiteColor];
    [outBtn setTitle:@"返回" forState:UIControlStateNormal];
    [outBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:outBtn];

    detailTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(titleView.frame)) style:UITableViewStyleGrouped];
    [detailTabView registerClass:[DetailCell class] forCellReuseIdentifier:@"DetailCell"];
    [detailTabView registerClass:[DetailSecondCell class] forCellReuseIdentifier:@"DetailSecondCell"];
//    [detailTabView registerClass:[DetailThirdCell class] forCellReuseIdentifier:@"DetailThirdCell"];
    [detailTabView registerClass:[DetailFourthCell class] forCellReuseIdentifier:@"DetailFourthCell"];
    [detailTabView registerClass:[DetailFifthCell class] forCellReuseIdentifier:@"DetailFifthCell"];
    [detailTabView registerClass:[DetailSixthCell class] forCellReuseIdentifier:@"DetailSixthCell"];
    [detailTabView registerClass:[DetailSeventhCell class] forCellReuseIdentifier:@"DetailSeventhCell"];
    
    caucateCell = [detailTabView dequeueReusableCellWithIdentifier:@"DetailFourthCell"];
    caucateCell1 = [detailTabView dequeueReusableCellWithIdentifier:@"DetailFourthCell"];
    
    detailTabView.delegate = self;
    detailTabView.dataSource = self;
    detailTabView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:detailTabView];

    [self getDealDetailData];
    
 
}

- (void) clickView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) getDealDetailData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.dealId forKey:@"deal_id"];
    NSLog(@"发送请求的参数: %@", params.allValues);
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
    [detailTabView reloadData];
}
#pragma mark -- 发送请求回调方法
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //result 字典
    NSLog(@"%@",result);
    NSDictionary *data = result;
    NSArray *dealArray = [data objectForKey:@"deals"];
    
    if (dealArray.count > 0)
    {
        dataDict = [dealArray firstObject];
        detaSecondDict = [dealArray firstObject];
        detaFifthDict = [dealArray firstObject];
        detaSixthDict = [dealArray firstObject];
        detaFourthDict = [dealArray firstObject];
        [detailTabView reloadData];
    }
}
//失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   if(section == 5)
    {
        return 3;
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
        cell.detailVC = self;
//        NSDictionary *dic = array[indexPath.row];
        [cell refreshCell:dataDict];
        cell.userInteractionEnabled = YES;
        return cell;
    }
    else if (indexPath.section == 1) {
        DetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSecondCell" forIndexPath:indexPath];
        [cell refreshSecondCell:detaSecondDict];
        return cell;
    }
    
    else if (indexPath.section == 2) {
//        DetailThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailThirdCell" forIndexPath:indexPath];
//        [cell refreshThirdCell:nil];
//        return cell;
        DetailFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFourthCell" forIndexPath:indexPath];
        NSString *stringList = detaFourthDict[@"details"];
        NSArray *list=[stringList componentsSeparatedByString:@"\n"];
        [cell refreshFourthCell:detaFourthDict labelArray:list];
        return cell;

    }
    else if (indexPath.section ==3){
        DetailFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFourthCell" forIndexPath:indexPath];
        NSDictionary *restrictionsDic = detaFourthDict[@"restrictions"];
        NSString *listStr = restrictionsDic[@"special_tips"];
        NSArray *list=[listStr componentsSeparatedByString:@"\n"];
        [cell refreshFourthCell:detaFourthDict labelArray:list];
        return cell;
    }
    else if (indexPath.section ==4){
        DetailFifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFifthCell" forIndexPath:indexPath];
        [cell refreshFifthCell:detaFifthDict];
        return cell;
    }
    else if (indexPath.section == 5){
        DetailSixthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSixthCell" forIndexPath:indexPath];
        [cell refreshSixthCell:detaSixthDict];
        return cell;
    }
    else
    {
        DetailSeventhCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSeventhCell" forIndexPath:indexPath];
        [cell refreshThirdCell:nil];
        return cell;
    }
    return nil;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 280;
    }
    else if (indexPath.section ==1){
        return 130;
    }
    else if (indexPath.section == 2)
    {
        NSString *stringList = detaFourthDict[@"details"];
        NSArray *list=[stringList componentsSeparatedByString:@"\n"];
        CGFloat curHeight = [caucateCell refreshFourthCell:nil labelArray:list];
        return curHeight;
    }
    else if (indexPath.section == 3)
    {
        NSDictionary *restrictionsDic = detaFourthDict[@"restrictions"];
        NSString *listStr = restrictionsDic[@"special_tips"];
        NSArray *list=[listStr componentsSeparatedByString:@"\n"];
        CGFloat curHeight = [caucateCell1 refreshFourthCell:nil labelArray:list];
        return curHeight;
    }
    else if (indexPath.section ==4){
        return 30;
    }
    else if (indexPath.section == 5){
        return 30;
    }
    else if (indexPath.section == 6){
        return 40;
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4) {
        return 15;
    }
    else
    {
        return 0.1;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 0.1;
    }
    else if (section == 5){
        return 0.1;
    }
    else if (section == 6){
        return 0.1;
    }
    else{
        return 10;
    }
}

@end

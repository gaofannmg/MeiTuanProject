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
#import "DetailSixthCell.h"
#import "OtherDealsData.h"


@interface DetailViewController ()<DPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    DetailFourthCell *caucateCell;
    DetailFourthCell *caucateCell1;
    UITableView *detailTabView;
    NSDictionary *dataDict;

    NSMutableArray *otherDealsArray;
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
//    detailTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [detailTabView registerClass:[DetailCell class] forCellReuseIdentifier:@"DetailCell"];
    [detailTabView registerClass:[DetailSecondCell class] forCellReuseIdentifier:@"DetailSecondCell"];
//    [detailTabView registerClass:[DetailThirdCell class] forCellReuseIdentifier:@"DetailThirdCell"];
    [detailTabView registerClass:[DetailFourthCell class] forCellReuseIdentifier:@"DetailFourthCell"];
    [detailTabView registerClass:[DetailSixthCell class] forCellReuseIdentifier:@"DetailSixthCell"];
    
    caucateCell = [detailTabView dequeueReusableCellWithIdentifier:@"DetailFourthCell"];
    caucateCell1 = [detailTabView dequeueReusableCellWithIdentifier:@"DetailFourthCell"];
    
    detailTabView.delegate = self;
    detailTabView.dataSource = self;
    detailTabView.backgroundColor = RGB(230, 230, 230);
    
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
        otherDealsArray = [OtherDealsData getDealsData:dataDict];
        
        [detailTabView reloadData];
    }
}
//失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 4)
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
        [cell refreshSecondCell:dataDict];
        return cell;
    }
    
    else if (indexPath.section == 2) {
//        DetailThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailThirdCell" forIndexPath:indexPath];
//        [cell refreshThirdCell:nil];
//        return cell;
        DetailFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFourthCell" forIndexPath:indexPath];
        NSString *stringList = dataDict[@"details"];
        NSArray *list=[stringList componentsSeparatedByString:@"\n"];
        [cell refreshFourthCell:dataDict labelArray:list];
        return cell;

    }
    else if (indexPath.section ==3){
        DetailFourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFourthCell" forIndexPath:indexPath];
        NSDictionary *restrictionsDic = dataDict[@"restrictions"];
        NSString *listStr = restrictionsDic[@"special_tips"];
        NSArray *list=[listStr componentsSeparatedByString:@"\n"];
        [cell refreshFourthCell:dataDict labelArray:list];
        return cell;
    }
//    else if (indexPath.section ==4)
//    {
//        DetailFifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFifthCell" forIndexPath:indexPath];
//        [cell refreshFifthCell:detaFifthDict];
//        return cell;
//    }
    else if (indexPath.section == 4){
        DetailSixthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSixthCell" forIndexPath:indexPath];
        
        [cell refreshSixthCell:otherDealsArray[indexPath.row]];
        return cell;
    }
//    else
//    {
//        DetailSeventhCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSeventhCell" forIndexPath:indexPath];
//        [cell refreshThirdCell:nil];
//        return cell;
//    }
    return [UITableViewCell new];
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
        NSString *stringList = dataDict[@"details"];
        NSArray *list=[stringList componentsSeparatedByString:@"\n"];
        CGFloat curHeight = [caucateCell refreshFourthCell:nil labelArray:list];
        return curHeight;
    }
    else if (indexPath.section == 3)
    {
        NSDictionary *restrictionsDic = dataDict[@"restrictions"];
        NSString *listStr = restrictionsDic[@"special_tips"];
        NSArray *list=[listStr componentsSeparatedByString:@"\n"];
        CGFloat curHeight = [caucateCell1 refreshFourthCell:nil labelArray:list];
        return curHeight;
    }
    else if (indexPath.section ==4)
    {
        return 30;
    }
    
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 4)
    {
        return 30;
    }
    
   return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4)
    {
        return 40;
    }
    
    return 5;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 4)
    {
        UIView *temHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, 25)];
        temHeaderView.backgroundColor = [UIColor whiteColor];
       
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIN_WIDTH - 20,30)];
        NSArray *arr = dataDict[@"categories"];
        NSString *str = arr[0];
        NSString *s = [NSString stringWithFormat:@"%@的其他团购",str];
        label.text = s;
        label.font = [UIFont systemFontOfSize:15.0];
        label.backgroundColor =[UIColor whiteColor];
        [temHeaderView addSubview:label];
        return temHeaderView;
    }
    
    return nil;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 4)
    {
        UIView *temHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIN_WIDTH, 40)];
        temHeaderView.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(10, 0, WIN_WIDTH - 20, 40);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"还有7个团购" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(moreGroupPurchase) forControlEvents:UIControlEventTouchUpInside];
        [temHeaderView addSubview:btn];
         return temHeaderView;
    }
   
    
    return nil;
}
- (void)moreGroupPurchase
{
    DetailSixthCell *cell = [detailTabView dequeueReusableCellWithIdentifier:@"DetailSixthCell" forIndexPath:otherDealsArray];
 
}

@end

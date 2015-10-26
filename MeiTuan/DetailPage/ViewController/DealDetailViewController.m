//
//  PushViewCont.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/17.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DealDetailViewController.h"
#import "DetailHeaderCell.h"
#import "DealParterInfoCell.h"
#import "DetailMutipleWordsCell.h"
#import "DetailOtherDealCell.h"
#import "OtherDealsData.h"
#import "BuyWebViewController.h"

@interface DealDetailViewController ()<DPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    DetailMutipleWordsCell *caucateCell;
    DetailMutipleWordsCell *caucateCell1;
    UITableView *detailTabView;
    NSDictionary *dataDict;

    NSMutableArray *otherDealsArray;
    
    UIButton *moreCellBtn;
    BOOL isExpand; //是否展开，默认收起
    UIView *titleView;
    UIButton *titleViewBuyButton;
}

@property (nonatomic,weak) UIButton *cellBuyButton;

@end

@implementation DealDetailViewController

#pragma mark -- page life

- (instancetype) init
{
    if (self == [super init])
    {
        
    }
    return self;
}


-(void) createNaigaitionBar
{
    titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
    titleLable.center = CGPointMake(titleView.center.x, titleLable.center.y);
    titleLable.text = @"团购详情";
    titleLable.textColor = RGB(45, 45, 45);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:titleLable];
    
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    outBtn.frame = CGRectMake(5,20,60, 44);
    outBtn.backgroundColor = [UIColor whiteColor];
    [outBtn setTitle:@"返回" forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [outBtn setTitleColor:RGB(45, 45, 45) forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:outBtn];
    
    titleViewBuyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    titleViewBuyButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 100  - 5, 20 + (44 - 30)/2 , 100, 30);
    titleViewBuyButton.backgroundColor = [UIColor orangeColor];
    [titleViewBuyButton setTitle:@"立即抢购" forState:UIControlStateNormal];
    titleViewBuyButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [titleView addSubview:titleViewBuyButton];
    [titleViewBuyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    titleViewBuyButton.hidden = YES;
    
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height - 0.5, titleView.bounds.size.width, 0.5)];
    splitView.backgroundColor = RGB(175, 175, 175);
    [titleView addSubview:splitView];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];

    [self createNaigaitionBar];
    
    detailTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(titleView.frame)) style:UITableViewStyleGrouped];
//    detailTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [detailTabView registerClass:[DetailHeaderCell class] forCellReuseIdentifier:@"DetailCell"];
    [detailTabView registerClass:[DealParterInfoCell class] forCellReuseIdentifier:@"DetailSecondCell"];
//    [detailTabView registerClass:[DetailThirdCell class] forCellReuseIdentifier:@"DetailThirdCell"];
    [detailTabView registerClass:[DetailMutipleWordsCell class] forCellReuseIdentifier:@"DetailFourthCell"];
    [detailTabView registerClass:[DetailMutipleWordsCell class] forCellReuseIdentifier:@"DetailFourthCell1"];
    [detailTabView registerClass:[DetailOtherDealCell class] forCellReuseIdentifier:@"DetailSixthCell"];
    
    caucateCell = [detailTabView dequeueReusableCellWithIdentifier:@"DetailFourthCell"];
    caucateCell1 = [detailTabView dequeueReusableCellWithIdentifier:@"DetailFourthCell1"];
    
    detailTabView.delegate = self;
    detailTabView.dataSource = self;
    detailTabView.backgroundColor = RGB(230, 230, 230);
    
    [self.view addSubview:detailTabView];
    [self getDealDetailData];
}

#pragma mark -- 发送请求回调方法

- (void) getDealDetailData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.dealId forKey:@"deal_id"];
    NSLog(@"发送请求的参数: %@", params.allValues);
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
}

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

#pragma mark -- tableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 4)
    {
        if (otherDealsArray.count <= 3)
        {
            return otherDealsArray.count;
        }
        
        if (isExpand)
        {
            return otherDealsArray.count;
        }
        else
        {
            return 3;
        }
    }
    else
    {
        return 1;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        DetailHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
        self.cellBuyButton = cell.curBuyButton;
        [self.cellBuyButton addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
        cell.detailVC = self;
        [cell refreshCell:dataDict];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        DealParterInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSecondCell" forIndexPath:indexPath];
        [cell refreshSecondCell:dataDict];
        return cell;
    }
    
    else if (indexPath.section == 2)
    {
        DetailMutipleWordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFourthCell" forIndexPath:indexPath];
        NSString *stringList = dataDict[@"details"];
        NSArray *list=[stringList componentsSeparatedByString:@"\n"];
        [cell refreshFourthCell:dataDict labelArray:list];
        return cell;

    }
    else if (indexPath.section ==3){
        DetailMutipleWordsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailFourthCell1" forIndexPath:indexPath];
        NSDictionary *restrictionsDic = dataDict[@"restrictions"];
        NSString *listStr = restrictionsDic[@"special_tips"];
        NSArray *list=[listStr componentsSeparatedByString:@"\n"];
        [cell refreshFourthCell:dataDict labelArray:list];
        return cell;
    }
    else if (indexPath.section == 4){
        DetailOtherDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSixthCell" forIndexPath:indexPath];
        
        NSDictionary *temDict = otherDealsArray[indexPath.row];
        
        [cell refreshSixthCell:temDict];
        return cell;
    }
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
        moreCellBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        moreCellBtn.frame = CGRectMake(10, 0, WIN_WIDTH - 20, 40);
        moreCellBtn.backgroundColor = [UIColor whiteColor];
        
        NSString *titleString = @"";
        
        if (isExpand)
        {
            titleString = @"收起";
        }
        else
        {
            if (otherDealsArray.count > 3)
            {
                titleString = [NSString stringWithFormat:@"还有%ld个团购",otherDealsArray.count -3];
            }
            else
            {
                titleString = @"";
            }
        }
        
        [moreCellBtn setTitle:titleString forState:UIControlStateNormal];
        [moreCellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [moreCellBtn addTarget:self action:@selector(moreGroupPurchase) forControlEvents:UIControlEventTouchUpInside];
        [temHeaderView addSubview:moreCellBtn];
         return temHeaderView;
    }
   
    
    return nil;
}

#pragma mark -- scrollViewDelegate

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect newRect = [self.cellBuyButton convertRect:self.cellBuyButton.bounds toView:self.view];
    
    if (newRect.origin.y + newRect.size.height <= CGRectGetMaxY(titleView.frame))
    {
        titleViewBuyButton.hidden = NO;
        self.cellBuyButton.hidden = YES;
    }
    else
    {
        titleViewBuyButton.hidden = YES;
        self.cellBuyButton.hidden = NO;
    }
}

#pragma mark -- event
//返回
- (void) clickView
{
    [self.navigationController popViewControllerAnimated:YES];
}

//立即购买
-(void) buyButtonClick
{
    BuyWebViewController *buyWebView = [[BuyWebViewController alloc] init];
    NSArray *array = dataDict[@"businesses"];
    if (array.count > 0)
    {
        NSDictionary *dic = [array firstObject];
        buyWebView.url = dic[@"h5_url"];
        [self.navigationController pushViewController:buyWebView animated:YES];
    }
}

//更多团购
- (void)moreGroupPurchase
{
    isExpand = !isExpand;
    
    [detailTabView reloadData];
    
    if (isExpand)
    {
        [detailTabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:otherDealsArray.count - 1 inSection:4] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

@end

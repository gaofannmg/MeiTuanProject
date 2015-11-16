//
//  ViewController.m
//  MeiTuan
//
//  Created by gaofan on 15/10/10.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCollectionViewCell.h"
#import "DealDetailViewController.h"
#import "CityListViewController.h"
#import "CityListViewCell.h"
#import "SortPopView.h"
#import "SeachViewController.h"
#import "BaseFilterViewController.h"
#import "FindDealsRequestFactory.h"
#import "CatagoryFilterViewController.h"
#import "RegionFilterViewController.h"
//#import "UIScrollView+BottomRefreshControl.h"
#import "DJRefresh.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DPRequestDelegate,DJRefreshDelegate>
{
    UILabel *titleLabel;
    NSMutableArray *array;
    UICollectionView *cView;
    UIButton *cityBtn;
    UIButton *searchBtn;
    UIRefreshControl *refreshControl;
    FindDealsRequestFactory *requsetModelFactory;
    CatagoryFilterViewController *typeFilterVC;
    RegionFilterViewController *screenFilterVC;
    MBProgressHUD *HUD;
    DJRefresh *_downrefresh;
}
@end

@implementation HomeViewController

#pragma mark -- 创建UI

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    array = [NSMutableArray array];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    titleView.backgroundColor = RGB(248, 111, 93);
    [self.view addSubview:titleView];
    
    cityBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cityBtn.frame = CGRectMake(WIN_WIDTH - 85, 20 , 80, 40);
    [cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    cityBtn.tintColor = [UIColor whiteColor];
    [cityBtn setImage:[UIImage imageNamed:@"cityBtn"] forState:UIControlStateNormal];
    cityBtn.adjustsImageWhenHighlighted = NO;
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cityBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    cityBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 3);
    cityBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0);
    cityBtn.backgroundColor = [UIColor clearColor];
    [cityBtn addTarget:self action:@selector(cityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cityBtn];
    
    searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(20, 25, WIN_WIDTH - 30 - cityBtn.frame.size.width, 34);
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = searchBtn.frame.size.height/2;
    searchBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    searchBtn.layer.borderWidth = 0.5;
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchBtn setTitleColor:RGB(200, 200 ,200) forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:searchBtn];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, searchBtn.frame.size.height /2 - 8, 16, 16)];
    searchImageView.backgroundColor = [UIColor whiteColor];
    searchImageView.image = [UIImage imageNamed:@"icon_search"];
    [searchBtn addSubview:searchImageView];
    
    CGFloat span = 2;
    CGFloat cellWidth = (self.view.bounds.size.width - 3 * span)/ 2;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(cellWidth , 243);
    layout.minimumInteritemSpacing = span;
    layout.minimumLineSpacing = span;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(span, span, span, span);
    
    cView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - titleView.frame.size.height - 40) collectionViewLayout:layout];
    cView.backgroundColor = RGB(230, 230, 230);
    [self.view addSubview:cView];
    cView.delegate = self;
    cView.dataSource = self;
    [cView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"MTCollectionViewCell"];
    
    //加载更多控件
    _downrefresh = [[DJRefresh alloc] initWithScrollView:cView delegate:self];
    _downrefresh.bottomEnabled=YES;
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,WIN_HIGHT - 40,WIN_WIDTH,40)];
    barView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:barView];
    
    //下拉刷新
    refreshControl = [[UIRefreshControl alloc] init];
    [cView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(pullDownRefresh) forControlEvents:UIControlEventValueChanged];
    
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, barView.frame.size.width, 0.5)];
    topLine.backgroundColor = RGB(230, 230, 230);
    [barView addSubview:topLine];
    
    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    typeButton.frame = CGRectMake(0, 0, barView.frame.size.width/3, barView.frame.size.height);
    [typeButton setTitle:@"分类" forState:UIControlStateNormal];
    typeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [typeButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    typeButton.backgroundColor = [UIColor clearColor];
    [typeButton addTarget:self action:@selector(typeFilterClick) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:typeButton];
    
    UIView *lineOneView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(typeButton.frame)+2, 10, 0.5, barView.frame.size.height - 20)];
    lineOneView.backgroundColor = [UIColor grayColor];
    [barView addSubview:lineOneView];
    
    UIButton *screeningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    screeningButton.frame = CGRectMake(CGRectGetMaxX(typeButton.frame),0,typeButton.frame.size.width, typeButton.frame.size.height);
    [screeningButton setTitle:@"区域" forState:UIControlStateNormal];
    screeningButton.backgroundColor =[UIColor clearColor];
    screeningButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [screeningButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [screeningButton addTarget:self action:@selector(screenFilterClick) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:screeningButton];
    
    UIView *lineTwoView = [[UIView alloc] init];
    lineTwoView.frame = CGRectMake(CGRectGetMaxX(screeningButton.frame)+2, 10, 0.5, barView.frame.size.height - 20);
    lineTwoView.backgroundColor = [UIColor grayColor];
    [barView addSubview:lineTwoView];
    
    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sortButton.frame = CGRectMake(CGRectGetMaxX(screeningButton.frame),0,typeButton.frame.size.width, screeningButton.frame.size.height);
    [sortButton setTitle:@"排序" forState:UIControlStateNormal];
    sortButton.backgroundColor =[UIColor clearColor];
    sortButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sortButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
    [sortButton addTarget:self action:@selector(sortViewClick) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:sortButton];
    
    requsetModelFactory = [[FindDealsRequestFactory alloc] initWithCity:cityBtn.titleLabel.text];

    [self getHttpData];
}

#pragma mark -- 加载更多回调

- (void)refresh:(DJRefresh *)refresh didEngageRefreshDirection:(DJRefreshDirection)direction
{
    [self loadMoreDeals];
}

//加载更多订单数据
- (void)loadMoreDeals
{
    requsetModelFactory.pageIndex ++;
    
    [self getHttpData];
}

-(void) showLoaing
{
    if (!HUD)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"正在加载...";
        HUD.labelFont = [UIFont systemFontOfSize:14];
        [self.view addSubview:HUD];
    }
    
    if (requsetModelFactory.pageIndex == 1)
    {
        [HUD show:YES];
    }
}

-(void) hideLoaing
{
    [HUD hide:YES];
}

//下拉刷新
-(void) pullDownRefresh
{
    requsetModelFactory.pageIndex = 1;
    
    [self getHttpData];
}

#pragma mark -- 获取数据
/**
 *  首页默认搜索,定位成功走附近排序，否则走默认排序
 */
- (void) getHttpData
{
    NSMutableDictionary *params = [requsetModelFactory getDefaultSearchDict];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    [self showLoaing];
    
//    CLLocationCoordinate2D curLocation = [LocationMgr shareInstance].curLocation;
//    if (curLocation.latitude > 0 && curLocation.longitude > 0)
//    {
//        //定位成功，用经纬度和半径搜索
//        NSMutableDictionary *params = [requsetModelFactory getsortLatitude:curLocation.latitude longitude:curLocation.longitude radius:1000];
//        DPAPI *api = [[DPAPI alloc] init];
//        [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
//    }
//    else
//    {
//        NSMutableDictionary *params = [requsetModelFactory getDefaultSearchDict];
//        DPAPI *api = [[DPAPI alloc] init];
//        [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
//    }
}

/**
 *  关键词搜索
 *
 *  @param keyWord 关键词
 */
- (void) getHttpDataBySearchKeyWords:(NSString *) keyWord
{
    NSMutableDictionary *params = [requsetModelFactory getKeyWordsDict:keyWord];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    [self showLoaing];
}

/**
 *  城市搜索
 *
 *  @param cityName 城市名
 */
- (void) getHttpDataByCityName:(NSString *) cityName
{
    NSMutableDictionary *params = [requsetModelFactory getCityDict:cityName];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    [self showLoaing];
}

/**
 *  区域搜索
 *
 *  @param regionName 区域名
 */
- (void) getHttpByRegionName:(NSString *) regionName
{
    NSMutableDictionary *params = [requsetModelFactory getRegionDict:regionName];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    [self showLoaing];
}

/**
 *  分类搜索
 *
 *  @param catagoryName 分类名
 */
- (void) getHttpByCatagoryName:(NSString *) catagoryName
{
    NSMutableDictionary *params = [requsetModelFactory getCategoryDict:catagoryName];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    [self showLoaing];
}

/**
 *  附近搜索
 *
 *  @param radius 半径值
 */
- (void) getNearbyHttpData:(int) radius
{
    CLLocationCoordinate2D curLocation = [LocationMgr shareInstance].curLocation;
    if (curLocation.latitude > 0 && curLocation.longitude > 0)
    {
        //定位成功，用经纬度和半径搜索
        requsetModelFactory.region = nil; //附近搜索，置空区域
        NSMutableDictionary *params = [requsetModelFactory getsortLatitude:curLocation.latitude longitude:curLocation.longitude radius:radius];
        DPAPI *api = [[DPAPI alloc] init];
        [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
        
        [self showLoaing];
    }
    else
    {
        //弹出定位失败提示
    }
}

#pragma mark -- 发送请求回调方法
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //result 字典
    NSLog(@"%@",result);
    
    [self hideLoaing];
    
    NSArray *dataArray = [result objectForKey:@"deals"];
    
    if (![dataArray isKindOfClass:[NSArray class]])
    {
        return;
    }
    
    if(requsetModelFactory.pageIndex == 1)
    {
        [array removeAllObjects];
    }
    
    if(dataArray.count == 0 || dataArray.count < requsetModelFactory.pageSize)
    {
        _downrefresh.bottomEnabled = NO;
    }
    else
    {
        _downrefresh.bottomEnabled = YES;
    }
    
    [array addObjectsFromArray:dataArray];
    [cView reloadData];
    
    //结束刷新动画
    [_downrefresh finishRefreshing];
    
    [refreshControl endRefreshing];
}
//失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    //结束刷新动画
    [_downrefresh finishRefreshing];
    
    [refreshControl endRefreshing];
    
    [self hideLoaing];
    
    MBProgressHUD *errorHUD = [[MBProgressHUD alloc] initWithView:self.view];
    errorHUD.mode = MBProgressHUDModeText;
    errorHUD.labelText = @"网络不给力";
    errorHUD.labelFont = [UIFont systemFontOfSize:12];
    [self.view addSubview:errorHUD];
    [errorHUD show:YES];
    [errorHUD hide:YES afterDelay:1];
}

#pragma mark --UICollectionViewDelegate

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return array.count;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *dic = array[indexPath.row];
    [cell refreshCell:dic];
    cell.userInteractionEnabled = YES;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DealDetailViewController *detailView = [[DealDetailViewController alloc] init];
    NSDictionary *dic = array[indexPath.row];
    detailView.dealId = [dic objectForKey:@"deal_id"];
    detailView.listVC = self;
    [self.navigationController pushViewController:detailView animated:YES];
}

#pragma mark -- 点击事件

/**
 *  点击城市
 */
- (void)cityButtonClick
{
    CityListViewController *cityListVC = [[CityListViewController alloc] init];
    cityListVC.basicVC = self;
    [self.navigationController pushViewController:cityListVC animated:YES];
}


/**
 *  点击搜索
 */
-(void) searchClick
{
    SeachViewController *searchVC = [[SeachViewController alloc] init];
    searchVC.homeVC = self;
    
    if (![searchBtn.titleLabel.text isEqual:@"搜索"])
    {
        searchVC.seachString = searchBtn.titleLabel.text;
    }
    
    [self.navigationController pushViewController:searchVC animated:NO];
}

/**
 *  分类
 */
- (void) typeFilterClick
{
    if (!typeFilterVC)
    {
        typeFilterVC = [[CatagoryFilterViewController alloc] init];
    }
    
    typeFilterVC.homeVC = self;
    typeFilterVC.cityName = cityBtn.titleLabel.text;
    [self presentViewController:typeFilterVC animated:YES completion:nil];
}

/**
 *  区域
 */
- (void) screenFilterClick
{
    if (!screenFilterVC)
    {
        screenFilterVC = [[RegionFilterViewController alloc] init];
    }
    
    screenFilterVC.homeVC = self;
    screenFilterVC.cityName = cityBtn.titleLabel.text;

    [self presentViewController:screenFilterVC animated:YES completion:nil];
}

/**
 *  点击排序
 */
- (void) sortViewClick
{
    UIView *backView = [self.view viewWithTag:333];
    
    if (!backView)
    {
        backView = [[UIView alloc] initWithFrame:self.view.bounds];
        backView.backgroundColor = [UIColor blackColor];
        backView.tag = 333;
        backView.alpha = 0;
        [self.view addSubview:backView];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeViewClick)];
        [backView addGestureRecognizer:tapGes];
        
    }
    
    SortPopView *sortPopView = [self.view viewWithTag:555];
    
    if (!sortPopView)
    {
        sortPopView = [[SortPopView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44 *7)];
        sortPopView.tag = 555;
        sortPopView.basicVC = self;
        [self.view addSubview:sortPopView];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.alpha = 0.5;
        sortPopView.frame = CGRectMake(sortPopView.frame.origin.x, self.view.frame.size.height - 44 *7, sortPopView.frame.size.width, sortPopView.frame.size.height);
    }];
}



/**
 *  移除排序
 */
- (void) removeViewClick
{
    UIView *backView = [self.view viewWithTag:333];
    SortPopView *sortPopView = [self.view viewWithTag:555];
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.alpha = 0;
        sortPopView.frame = CGRectMake(sortPopView.frame.origin.x, self.view.frame.size.height, sortPopView.frame.size.width, sortPopView.frame.size.height);
    }];
}

/**
 *  重置分页
 */
-(void) resetPageInfo
{
    requsetModelFactory.pageIndex = 1;
    [cView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark -- 回调事件
/**
 *  选择城市回调
 *
 *  @param cityName 城市名
 */
- (void) selectCity:(NSString *) cityName
{
    if (![cityBtn.titleLabel.text isEqual:cityName])
    {
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setTitleColor:RGB(200, 200 ,200) forState:UIControlStateNormal];
    }
    else
    {
        return;
    }
    
    [self resetPageInfo];
    [cityBtn setTitle:cityName forState:UIControlStateNormal];
    [self getHttpDataByCityName:cityName];
}

/**
 *  搜索回调
 *
 *  @param keyWord 关键词
 */
-(void) searchWithKeyWord:(NSString *) keyWord
{
    if (![keyWord isEqual:@"搜索"])
    {
        [searchBtn setTitleColor:RGB(100, 100 ,100) forState:UIControlStateNormal];
    }
    else
    {
        [searchBtn setTitleColor:RGB(200, 200 ,200) forState:UIControlStateNormal];
    }
    
    if (keyWord.length > 0)
    {
        [searchBtn setTitle:keyWord forState:UIControlStateNormal];
    }
    else
    {
        [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [searchBtn setTitleColor:RGB(200, 200 ,200) forState:UIControlStateNormal];
    }
    
    [self resetPageInfo];
    
    [self getHttpDataBySearchKeyWords:keyWord];
}

/**
 *  排序回调
 *
 *  @param sortTxt 排序名
 */
-(void) sortWithText:(NSString *) sortTxt
{
    [self resetPageInfo];
    requsetModelFactory.latitude = 0;
    requsetModelFactory.longitude = 0;
    //结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先
    int sortNumber = 1;
    if ([sortTxt  isEqual: @"默认排序"])
    {
        sortNumber = 1;
    }
    else if ([sortTxt isEqual:@"价格最低"])
    {
        sortNumber = 2;
    }
    else if ([sortTxt isEqual:@"价格最高"])
    {
        sortNumber = 3;
    }
    else if ([sortTxt isEqual:@"人气最高"])
    {
        sortNumber = 4;
    }
    else if ([sortTxt isEqual:@"最新发布"])
    {
        sortNumber = 5;
    }
    else if ([sortTxt isEqual:@"即将结束"])
    {
        sortNumber = 6;
    }
    else if ([sortTxt isEqual:@"离我最近"])
    {
        sortNumber = 7;
        
        requsetModelFactory.latitude = [LocationMgr shareInstance].curLocation.latitude;
        requsetModelFactory.longitude = [LocationMgr shareInstance].curLocation.longitude;
    }
    NSNumber *number = [NSNumber numberWithInt:sortNumber];
    NSMutableDictionary *params = [requsetModelFactory getSortTxt:number];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
    
    [self removeViewClick];
}

/**
 *  选择区域
 *
 *  @param regionString 区域名
 */
- (void) selectRegion:(NSString *) regionString
{
    [self resetPageInfo];
    [self getHttpByRegionName:regionString];
    
}

/**
 *  选择分类
 *
 *  @param catagoryNameString 分类名
 */
- (void) selectCatagoryByName:(NSString *) catagoryNameString
{
    [self resetPageInfo];
    [self getHttpByCatagoryName:catagoryNameString];
}

#pragma mark -- 内存警告

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

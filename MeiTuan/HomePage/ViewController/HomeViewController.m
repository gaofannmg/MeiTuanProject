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

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DPRequestDelegate>
{
    UILabel *titleLabel;
    NSArray *array;
    UICollectionView *cView;
    UIButton *cityBtn;
    UIButton *searchBtn;
    FindDealsRequestFactory *requsetModelFactory;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    titleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:titleView];
    
    cityBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cityBtn.frame = CGRectMake(WIN_WIDTH - 80, 20 , 60, 40);
    [cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    cityBtn.backgroundColor = [UIColor whiteColor];
    [cityBtn addTarget:self action:@selector(cityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cityBtn];
    
    searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(20, 25, WIN_WIDTH - 20 - 10 - cityBtn.frame.size.width - 20, 34);
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
    
    CGFloat span = 5;
    CGFloat cellWidth = (self.view.bounds.size.width - 3 * span)/ 2;
    CGFloat cellHeight = cellWidth;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(cellWidth , cellHeight +70);
    layout.minimumInteritemSpacing = span;
    layout.minimumLineSpacing = span;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(span, span, span, span);
    
    cView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - titleView.frame.size.height) collectionViewLayout:layout];
    cView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cView];
    cView.delegate = self;
    cView.dataSource = self;
    [cView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"MTCollectionViewCell"];
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,WIN_HIGHT - 50,WIN_WIDTH,50)];
    barView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barView];

    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    typeButton.frame = CGRectMake(7, 0, barView.frame.size.width/3, barView.frame.size.height-5);
    [typeButton setTitle:@"分类" forState:UIControlStateNormal];
    typeButton.backgroundColor = [UIColor grayColor];
    typeButton.alpha = 0.8;
    [typeButton addTarget:self action:@selector(typeFilterClick) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:typeButton];
    
    UIButton *screeningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    screeningButton.frame = CGRectMake(CGRectGetMaxX(typeButton.frame),0,typeButton.frame.size.width, typeButton.frame.size.height);
    [screeningButton setTitle:@"区域" forState:UIControlStateNormal];
    screeningButton.backgroundColor =[UIColor grayColor];
    screeningButton.alpha = 0.8;
    [screeningButton addTarget:self action:@selector(screenFilterClick) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:screeningButton];
    
    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sortButton.frame = CGRectMake(CGRectGetMaxX(screeningButton.frame),0,typeButton.frame.size.width -14, screeningButton.frame.size.height);
    [sortButton setTitle:@"排序" forState:UIControlStateNormal];
    sortButton.backgroundColor =[UIColor grayColor];
    sortButton.alpha = 0.8;
    [sortButton addTarget:self action:@selector(sortViewClick) forControlEvents:UIControlEventTouchUpInside];
    [barView addSubview:sortButton];
    
    requsetModelFactory = [[FindDealsRequestFactory alloc] initWithCity:cityBtn.titleLabel.text];

    [self getHttpData];
}

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
    
    [self getHttpDataBySearchKeyWords:keyWord];
}

- (void) getHttpData
{
    NSMutableDictionary *params = [requsetModelFactory getDefaultSearchDict];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void) getHttpDataBySearchKeyWords:(NSString *) keyWord
{
    NSMutableDictionary *params = [requsetModelFactory getKeyWordsDict:keyWord];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void) getHttpDataByCityName:(NSString *) cityName
{
    NSMutableDictionary *params = [requsetModelFactory getCityDict:cityName];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void) getHttpByRegionName:(NSString *) regionName
{
    NSMutableDictionary *params = [requsetModelFactory getRegionDict:regionName];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

- (void) getHttpByCatagoryName:(NSString *) catagoryName
{
    NSMutableDictionary *params = [requsetModelFactory getCategoryDict:catagoryName];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
}

#pragma mark -- 发送请求回调方法
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //result 字典
    NSLog(@"%@",result);
    array = [result objectForKey:@"deals"];
    [cView reloadData];
}
//失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
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
- (void)changeBtnColor:(UIColor *) color
{
    cityBtn.backgroundColor = color;
}

- (void)cityButtonClick
{
    CityListViewController *cityListVC = [[CityListViewController alloc] init];
    cityListVC.basicVC = self;
    [self.navigationController pushViewController:cityListVC animated:YES];
}

- (void) selectCity:(NSString *) cityName
{
    [cityBtn setTitle:cityName forState:UIControlStateNormal];
    [self getHttpDataByCityName:cityName];
}

- (void) selectRegion:(NSString *) regionString
{
    [self getHttpByRegionName:regionString];
}

- (void) selectCatagoryByName:(NSString *) catagoryNameString
{
    [self getHttpByCatagoryName:catagoryNameString];
}

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

-(void) sortWithText:(NSString *) sortTxt
{
    //排序 to do
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
    }
    NSNumber *number = [NSNumber numberWithInt:sortNumber];
    NSMutableDictionary *params = [requsetModelFactory getSortTxt:number];
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
   
    [self removeViewClick];
}

- (void) removeViewClick
{
    UIView *backView = [self.view viewWithTag:333];
    SortPopView *sortPopView = [self.view viewWithTag:555];
    
    [UIView animateWithDuration:0.3 animations:^{
        backView.alpha = 0;
        sortPopView.frame = CGRectMake(sortPopView.frame.origin.x, self.view.frame.size.height, sortPopView.frame.size.width, sortPopView.frame.size.height);
    }];
}

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

- (void) typeFilterClick
{
    CatagoryFilterViewController *typeFilterVC = [[CatagoryFilterViewController alloc] init];
    typeFilterVC.homeVC = self;
    [self presentViewController:typeFilterVC animated:YES completion:nil];
}
- (void) screenFilterClick
{
    RegionFilterViewController *screenFilterVC = [[RegionFilterViewController alloc] init];
    screenFilterVC.homeVC = self;
    screenFilterVC.cityName = cityBtn.titleLabel.text;
    [self presentViewController:screenFilterVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

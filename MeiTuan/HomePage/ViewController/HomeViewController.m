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
#import "FilterViewController.h"

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,DPRequestDelegate>
{
    UILabel *titleLabel;
    NSArray *array;
    UICollectionView *cView;
    UIButton *cityBtn;
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
    cityBtn.frame = CGRectMake(10, 20 , 50, 40);
    [cityBtn setTitle:@"北京" forState:UIControlStateNormal];
    cityBtn.backgroundColor = [UIColor whiteColor];
    [cityBtn addTarget:self action:@selector(cityButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:cityBtn];
    
    CGFloat searchBarHeight = 34;
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat seachBtnPointX = CGRectGetMaxX(cityBtn.frame) + 10;
    searchBtn.frame = CGRectMake(seachBtnPointX, 20 + (44 - searchBarHeight)/2, WIN_WIDTH - seachBtnPointX - 15, searchBarHeight);
    searchBtn.backgroundColor = [UIColor whiteColor];
    searchBtn.layer.masksToBounds = YES;
    searchBtn.layer.cornerRadius = searchBarHeight/2;
    searchBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    searchBtn.layer.borderWidth = 0.5;
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
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
    
    [self getHttpData];
}

- (void) getHttpData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"公寓式酒店" forKey:@"category"];
    [params setObject:[NSNumber numberWithInt:1] forKey:@"page"];
    [params setObject:@"北京" forKey:@"city"];
    //    NSLog(@"发送请求的参数: %@", params.allValues);
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
    [self.navigationController pushViewController:searchVC animated:NO];
}

- (void) typeFilterClick
{
    FilterViewController *typeFilterVC = [[FilterViewController alloc] init];
    typeFilterVC.str =@"分类";
    [self presentViewController:typeFilterVC animated:YES completion:nil];
}
- (void) screenFilterClick
{
    FilterViewController *screenFilterVC = [[FilterViewController alloc] init];
    screenFilterVC.str = @"区域";
    [self presentViewController:screenFilterVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

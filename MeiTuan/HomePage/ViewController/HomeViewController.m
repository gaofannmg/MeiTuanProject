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
    cityBtn.frame = CGRectMake(10, 20 , 80, 40);
    [cityBtn setTitle:@"城市" forState:UIControlStateNormal];
    cityBtn.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:cityBtn];
    
    UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cityBtn.frame) + 5, cityBtn.frame.origin.y, 200, cityBtn.frame.size.height)];
    searchView.backgroundColor = [UIColor whiteColor];
    searchView.layer.masksToBounds = YES;
    searchView.layer.cornerRadius = 20.0;
    searchView.layer.borderColor = [[UIColor clearColor] CGColor];
    searchView.layer.borderWidth = 0.5;
    [titleView addSubview:searchView];
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 25, 25)];
    searchImageView.backgroundColor = [UIColor whiteColor];
    searchImageView.image = [UIImage imageNamed:@"icon_search"];
    [searchView addSubview:searchImageView];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    searchBtn.frame = CGRectMake(CGRectGetMaxX(searchImageView.frame) + 10, searchImageView.frame.origin.y, 100, 30);
    searchBtn.backgroundColor = [UIColor clearColor];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [searchView addSubview:searchBtn];
    
    UIButton *wapBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    wapBtn.frame = CGRectMake(CGRectGetMaxX(searchView.frame) + 5, cityBtn.frame.origin.y, 50, cityBtn.frame.size.height);
    wapBtn.backgroundColor = [UIColor whiteColor];
    [titleView addSubview:wapBtn];
    
    CGFloat span = 5;
    CGFloat cellWidth = (self.view.bounds.size.width - 3 * span)/ 2;
    CGFloat cellHeight = cellWidth;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(cellWidth , cellHeight +50);
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
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0,[UIScreen mainScreen].bounds.size.height - 50, self.view.frame.size.width,50)];
    barView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barView];

    UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    typeButton.frame = CGRectMake(7, 0, barView.frame.size.width/3, barView.frame.size.height-5);
    [typeButton setTitle:@"区域" forState:UIControlStateNormal];
    typeButton.backgroundColor = [UIColor grayColor];
    typeButton.alpha = 0.8;
    [barView addSubview:typeButton];
    
    UIButton *screeningButton = [UIButton buttonWithType:UIButtonTypeCustom];
    screeningButton.frame = CGRectMake(CGRectGetMaxX(typeButton.frame),0,typeButton.frame.size.width, typeButton.frame.size.height);
    [screeningButton setTitle:@"筛选" forState:UIControlStateNormal];
    screeningButton.backgroundColor =[UIColor grayColor];
    screeningButton.alpha = 0.8;
    [barView addSubview:screeningButton];
    
    UIButton *sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sortButton.frame = CGRectMake(CGRectGetMaxX(screeningButton.frame),0,typeButton.frame.size.width -14, screeningButton.frame.size.height);
    [sortButton setTitle:@"排序" forState:UIControlStateNormal];
    sortButton.backgroundColor =[UIColor grayColor];
    sortButton.alpha = 0.8;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

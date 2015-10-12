//
//  ViewController.m
//  MeiTuan
//
//  Created by gaofan on 15/10/10.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "ViewController.h"
#import "MTCollectionViewCell.h"
#import "DPSDK/DPAPI.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UILabel *titleLabel;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    titleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:titleView];
    
    UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeSystem];
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
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 5, 30, 30)];
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
    
    UIButton *screeningBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    screeningBtn.frame = CGRectMake(self.view.frame.size.width - 100,self.view.frame.size.height - 150, 60, 60);
    screeningBtn.backgroundColor = [UIColor greenColor];
    screeningBtn.layer.masksToBounds = YES;
    screeningBtn.layer.cornerRadius = 30.0;
    screeningBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    screeningBtn.layer.borderWidth = 0.5;
    [screeningBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [self.view addSubview:screeningBtn];
    
    UIButton *sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sortBtn.frame = CGRectMake(screeningBtn.frame.origin.x, CGRectGetMaxY(screeningBtn.frame) + 10, screeningBtn.frame.size.width, screeningBtn.frame.size.height);
    sortBtn.backgroundColor = [UIColor greenColor];
    sortBtn.layer.masksToBounds = YES;
    sortBtn.layer.cornerRadius = 30.0;
    sortBtn.layer.borderColor = [[UIColor clearColor] CGColor];
    sortBtn.layer.borderWidth = 0.5;
    [sortBtn setTitle:@"排序" forState:UIControlStateNormal];
    [self.view addSubview:sortBtn];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 150);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *cView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - titleView.frame.size.height) collectionViewLayout:layout];
    cView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:cView];
    cView.delegate = self;
    cView.dataSource = self;
    cView.alpha = 0.4;
    [cView registerClass:[MTCollectionViewCell class] forCellWithReuseIdentifier:@"MTCollectionViewCell"];
}

//- (void)sendRequestToServer {
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    
//    [params setObject:@"公寓式酒店" forKey:@"category"];
//    [params setObject:[NSNumber numberWithInt:1] forKey:@"page"];
//    [params setObject:@"北京" forKey:@"city"];
//    
//    NSLog(@"发送请求的参数: %@", params.allValues);
//    
//    DPAPI *api = [[DPAPI alloc] init];
//    [api requestWithURL:@"v1/deal/find_deals" params:params delegate:self];
//}
//#pragma mark -- 发送请求回调方法
////成功
//- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
//{
//    //result 字典
//}
//
////失败
//- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
//{
//    
//}
//
/////
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     MTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MTCollectionViewCell" forIndexPath:indexPath];
    
    
    [cell refreshCell:@"haha" detailsLabelText:@"haha" presentPriceLabelText:@"haha" originalPriceLabelText:@"haha" soldLabelText:@"haha" imageViewName:nil];
    cell.backgroundColor = [UIColor blackColor];

    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

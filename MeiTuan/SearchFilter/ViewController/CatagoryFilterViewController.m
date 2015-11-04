//
//  CatagoryFilterViewController.m
//  MeiTuan
//
//  Created by GaoYong on 15/11/2.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "CatagoryFilterViewController.h"

@interface CatagoryFilterViewController ()<DPRequestDelegate>

@end

@implementation CatagoryFilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
    titleLable.text = @"分类";
    rightArrayKeyString = @"subcategories";
    leftTitleKey = @"category_name";
    [self requestHttpData];
}

-(void) requestHttpData
{
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/metadata/get_categories_with_deals" params:nil delegate:self];
}

#pragma mark -- 发送请求回调方法
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //result 字典
    NSLog(@"%@",result);
    
    NSArray *dataArray = [result objectForKey:@"categories"];
    
    if (![dataArray isKindOfClass:[NSArray class]] || dataArray.count < 1)
    {
        return;
    }
    
    leftArray = [NSMutableArray array];
    [leftArray addObjectsFromArray:dataArray];
    
    NSDictionary *dict = @{@"category_name":@"全部分类"};
    
    [leftArray insertObject:dict atIndex:0];
    
    if (leftArray.count > 0)
    {
        NSDictionary *leftDataDict = [leftArray firstObject];
        
        rightArray = leftDataDict[@"subcategories"];
    }
    
    [leftTabView reloadData];
    [rightTabVIew reloadData];
}
//失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    
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

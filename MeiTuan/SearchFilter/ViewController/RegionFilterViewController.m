//
//  RegionFilterViewController.m
//  MeiTuan
//
//  Created by GaoYong on 15/11/2.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "RegionFilterViewController.h"
#import "HomeViewController.h"

@interface RegionFilterViewController ()
{
    BOOL isFirstViewWillAppear;
}
@end

@implementation RegionFilterViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    titleLable.text = @"区域";
    rightArrayKeyString = @"subregions";
    leftTitleKey = @"name";
    
    isFirstViewWillAppear = YES;
}

- (void) viewWillAppear:(BOOL)animated
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    NSArray *dataArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    for (int i = 0; i< dataArray.count;  i++)
    {
        NSDictionary *regionDic = dataArray[i];
        if ([regionDic[leftTitleKey] isEqual:self.cityName])
        {
            leftArray = [regionDic objectForKey:@"regions"];
            break;
        }
    }
    
    if (leftArray.count > 0)
    {
        NSDictionary *leftDataDict = [leftArray firstObject];
        
        rightArray = leftDataDict[rightArrayKeyString];
        
    }
    
    //定位成功
    if ([LocationMgr shareInstance].curLocation.latitude > 0 && [LocationMgr shareInstance].curLocation.longitude > 0)
    {
        if ([[LocationMgr shareInstance].curCityName isEqual:self.cityName])
        {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"附近" forKey:@"name"];
            
            NSArray *subCattegoriesArr = @[@"500m",@"1000m",@"1500m",@"2000m",@"3000m"];
            
            dic[rightArrayKeyString] = subCattegoriesArr;
            
            [leftArray insertObject:dic atIndex:0];
        }
    }
    
    //第一次创建执行，选中全部
    if (isFirstViewWillAppear)
    {
        isFirstViewWillAppear = NO;
        for (int i = 0;i< leftArray.count;i++)
        {
            NSDictionary *leftDict = [leftArray objectAtIndex:i];
            NSString *leftTitle = [leftDict objectForKey:@"name"];
            
            if ([leftTitle isEqual:@"全部"])
            {
                leftSelectUIIndex = i;
                leftSelectIndex = i;
                break;
            }
        }
    }
    
    [super viewWillAppear:animated];
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

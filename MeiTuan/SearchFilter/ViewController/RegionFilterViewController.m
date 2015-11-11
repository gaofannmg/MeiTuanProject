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
    
}
@end

@implementation RegionFilterViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    titleLable.text = @"区域";
    rightArrayKeyString = @"subregions";
    leftTitleKey = @"name";
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
    
    // Do any additional setup after loading the view.
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObject:@"附近" forKey:@"name"];
    
    NSArray *subCattegoriesArr = @[@"500m",@"1000m",@"1500m",@"2000m",@"3000m"];
    
    dic[rightArrayKeyString] = subCattegoriesArr;
    
    [leftArray insertObject:dic atIndex:0];
    
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

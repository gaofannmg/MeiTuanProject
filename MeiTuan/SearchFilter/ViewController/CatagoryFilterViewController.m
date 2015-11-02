//
//  CatagoryFilterViewController.m
//  MeiTuan
//
//  Created by GaoYong on 15/11/2.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "CatagoryFilterViewController.h"

@interface CatagoryFilterViewController ()

@end

@implementation CatagoryFilterViewController

- (void)viewDidLoad
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"categories" ofType:@"plist"];
    leftArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    if (leftArray.count > 0)
    {
        NSDictionary *leftDataDict = [leftArray firstObject];
        
        rightArray = leftDataDict[@"subcategories"];
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.]
    titleLable.text = @"分类";
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

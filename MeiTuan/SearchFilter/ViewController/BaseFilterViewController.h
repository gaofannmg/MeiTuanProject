//
//  FilterViewController.h
//  MeiTuan
//
//  Created by GaoYong on 15/10/31.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface BaseFilterViewController : UIViewController

{
    UILabel *titleLable;
    NSMutableArray *leftArray;
    NSMutableArray *rightArray;
    UITableView *leftTabView;
    UITableView *rightTabVIew;
    NSString *rightArrayKeyString;
    NSString *leftTitleKey;
}
@property (nonatomic,weak) HomeViewController *homeVC;


@end

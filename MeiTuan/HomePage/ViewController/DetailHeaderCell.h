//
//  DetailCell.h
//  MeiTuan
//  详情页头cell:大图，限时抢购。。。
//  Created by GaoYong on 15/10/18.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DealDetailViewController.h"

@interface DetailHeaderCell : UITableViewCell

@property (nonatomic,weak) DealDetailViewController *detailVC;

@property (nonatomic,weak) UIButton *curBuyButton;

- (void) refreshCell:(NSDictionary *) dic;

@end

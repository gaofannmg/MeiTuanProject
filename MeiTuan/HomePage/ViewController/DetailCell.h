//
//  DetailCell.h
//  MeiTuan
//
//  Created by GaoYong on 15/10/18.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface DetailCell : UITableViewCell

@property (nonatomic,weak) DetailViewController *detailVC;

@property (nonatomic,weak) UIButton *curBuyButton;

- (void) refreshCell:(NSDictionary *) dic;

@end

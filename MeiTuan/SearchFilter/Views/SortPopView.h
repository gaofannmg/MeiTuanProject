//
//  SortPopView.h
//  MeiTuan
//
//  Created by GaoYong on 15/10/29.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface SortPopView : UIView

@property (nonatomic,weak) HomeViewController *basicVC;

-(void) showZuijinItem:(BOOL) isShow;

-(void) selectFirstRow;

@end

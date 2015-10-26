//
//  PushViewCont.h
//  MeiTuan
//  团购详情页
//  Created by GaoYong on 15/10/17.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface DealDetailViewController : UIViewController
@property (nonatomic,copy) NSString *dealId;

@property (nonatomic,weak) HomeViewController *listVC;

- (void) clickView;

@end

//
//  PushViewCont.h
//  MeiTuan
//
//  Created by GaoYong on 15/10/17.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface DetailViewController : UIViewController
@property (nonatomic,copy) NSString *dealId;

@property (nonatomic,weak) ViewController *listVC;

- (void) clickView;

@end

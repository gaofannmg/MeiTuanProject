//
//  HomeViewController.h
//  MeiTuan
//  首页
//  Created by gaofan on 15/10/10.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

- (void)changeBtnColor:(UIColor *) color;
- (void) selectCity:(NSString *) cityName;
-(void) sortWithText:(NSString *) sortTxt;
-(void) searchWithKeyWord:(NSString *) keyWord;
@end


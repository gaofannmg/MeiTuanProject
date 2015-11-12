//
//  HomeViewController.h
//  MeiTuan
//  首页
//  Created by gaofan on 15/10/10.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

- (void) selectCity:(NSString *) cityName;
- (void) sortWithText:(NSString *) sortTxt;
- (void) searchWithKeyWord:(NSString *) keyWord;
- (void) selectRegion:(NSString *) regionString;
- (void) selectCatagoryByName:(NSString *) catagoryNameString;
- (void) getHttpData;
- (void) getNearbyHttpData:(int) radius;
@end


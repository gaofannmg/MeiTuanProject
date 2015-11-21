//
//  LocationMgr.h
//  MeiTuan
//
//  Created by GaoYong on 15/11/5.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationMgr : NSObject

@property (nonatomic) CLLocationCoordinate2D curLocation;

@property (nonatomic,copy) NSString *curCityName;
@property (nonatomic,copy) NSString *locationInfoName;

+(LocationMgr *) shareInstance;

@end

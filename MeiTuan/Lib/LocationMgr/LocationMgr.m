//
//  LocationMgr.m
//  MeiTuan
//
//  Created by GaoYong on 15/11/5.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "LocationMgr.h"

static LocationMgr *locationMgr = nil;

@interface LocationMgr ()<CLLocationManagerDelegate>
{
    CLLocationManager *mgr;
}
@end

@implementation LocationMgr

+(LocationMgr *) shareInstance
{
    if (locationMgr == nil)
    {
       locationMgr = [[LocationMgr alloc] init];
    }
    return locationMgr;
}

-(CLLocationCoordinate2D) curLocation
{
    mgr.desiredAccuracy = kCLLocationAccuracyBest;
    //设置定位频率(发送请求的次数)
    mgr.distanceFilter = kCLDistanceFilterNone;
    //开始定位
    [mgr startUpdatingLocation];
    
    return _curLocation;
}

-(instancetype) init
{
    if (self = [super init])
    {
        mgr = [[CLLocationManager alloc] init];
        //设置代理
        mgr.delegate = self;
        //判定iOS版本
        if ([[UIDevice currentDevice].systemVersion doubleValue] > 8.0) {
            //下面的两个方法对应不用的key(Info.plist)
            //征求用户的同意(在前台和后台定位)
            //        [self.mgr requestAlwaysAuthorization];
            //征求用户的同意(只在前台/使用期间定位)
            [mgr requestWhenInUseAuthorization];
        } else {
            //iOS<8.0
            [mgr startUpdatingLocation];
        }
    }
    
    return self;
}

#pragma mark --- CLLocationDelegate
//监控到用户的点击弹出框的动作(允许/不允许)
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    switch (status) {
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            //设置定位的精度/准确性
            //最高的定位准确度
            mgr.desiredAccuracy = kCLLocationAccuracyBest;
            //设置定位频率(发送请求的次数)
            mgr.distanceFilter = kCLDistanceFilterNone;
            //开始定位
            [mgr startUpdatingLocation];
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"用户不允许定位 ");
            break;
            
        default:
            break;
    }
    
}

//定位到用户的位置的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    NSLog(@"location is %f; %f", location.coordinate.latitude, location.coordinate.longitude);
    
    self.curLocation =  location.coordinate;
    
    //手动停止定位的操作
    [mgr stopUpdatingLocation];
}

@end

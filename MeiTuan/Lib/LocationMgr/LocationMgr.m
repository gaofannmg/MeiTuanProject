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

//-(CLLocationCoordinate2D) curLocation
//{
//    mgr.desiredAccuracy = kCLLocationAccuracyBest;
//    //设置定位频率(发送请求的次数)
//    mgr.distanceFilter = kCLDistanceFilterNone;
//    //开始定位
//    [mgr startUpdatingLocation];
//    
//    return _curLocation;
//}

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
    
    CLLocationCoordinate2D newCoordinate = [self updateLocationByBaidu:location.coordinate];
    
    double curLat = ceil(self.curLocation.latitude * 100)/100;
    double curLng = ceil(self.curLocation.latitude * 100)/100;
    
    double newLat = ceil(newCoordinate.latitude * 100)/100;
    double newLng = ceil(newCoordinate.latitude * 100)/100;
    
    if (curLat == newLat || curLng == newLng)
    {
        return;
    }
    
    self.curLocation =  newCoordinate;
    
    //经纬度CLLocation
    CLLocation *cl_location = [[CLLocation alloc] initWithLatitude:self.curLocation.latitude longitude:self.curLocation.longitude];
    
    //对应经纬度的详细信息(addressDictionary)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
       
        //创建CLGeocoder对象
        CLGeocoder *geocoder = [CLGeocoder new];
        [geocoder reverseGeocodeLocation:cl_location completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error == nil) {
                for (CLPlacemark *placemark in placemarks) {
                    NSLog(@"longitude:%f; latitude:%f; addressDictionary:%@", placemark.location.coordinate.longitude, placemark.location.coordinate.latitude, placemark.addressDictionary);
                    locationMgr.curCityName = [placemark.addressDictionary objectForKey:@"City"];
                    locationMgr.curCityName = [self filterCityName:locationMgr.curCityName];
                    locationMgr.locationInfoName = [placemark.addressDictionary objectForKey:@"Name"];
                    locationMgr.locationInfoName = [locationMgr.locationInfoName stringByReplacingOccurrencesOfString:@"中国" withString:@""];
                    
                }
            }
        }];
        
    });
    
    //手动停止定位的操作
    [mgr stopUpdatingLocation];
}

/* 去掉“县、市” */
-(NSString *)filterCityName:(NSString *)cityName{
    NSString *tmpCity = cityName;
    if ([[NSPredicate predicateWithFormat:@"SELF MATCHES '[\u4e00-\u9fa5]{1,50}'"] evaluateWithObject:cityName]) {
        // 中文去掉“市”、“县”等标志
        tmpCity = [cityName substringToIndex:[cityName length]-1];
    }
    return tmpCity;
}

#pragma mark - 纠偏算法

double transformLat(double x, double y) {
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

static double transformLon(double x, double y) {
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 *sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

//gps纠偏算法
-(CLLocationCoordinate2D)updateLocationByBaidu:(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D mNewLocation;    //火星坐标
    double lon = coordinate.longitude;
    double lat = coordinate.latitude;
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    if(lon>72.004 && lon<137.8347 && lat>0.8293 && lat<55.8271){
        double dLat = transformLat(lon - 105.0, lat - 35.0);
        double dLon = transformLon(lon - 105.0, lat - 35.0);
        double radLat = lat / 180.0 * M_PI;
        double magic = sin(radLat);
        magic = 1 - ee * magic * magic;
        double sqrtMagic = sqrt(magic);
        dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
        dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
        double mgLat = lat + dLat;
        double mgLon = lon + dLon;
        mNewLocation = CLLocationCoordinate2DMake(mgLat, mgLon);
    }else{
        mNewLocation = coordinate;
    }
    return mNewLocation;
}


@end

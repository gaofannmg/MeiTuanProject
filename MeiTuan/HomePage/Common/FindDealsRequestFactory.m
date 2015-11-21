//
//  FindDealsRequestFactory.m
//  MeiTuan
//  搜索点评请求工厂类
//  Created by GaoYong on 15/11/1.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "FindDealsRequestFactory.h"

@interface FindDealsRequestFactory ()
{
    
}
@end

@implementation FindDealsRequestFactory

-(instancetype) initWithCity:(NSString *) cityName
{
    if (self = [super init])
    {
        self.city = cityName;
    }
    
    return self;
}

//默认搜索
-(NSMutableDictionary *) getDefaultSearchDict
{
    if (!STRVALID(self.city))
    {
        self.city = @"北京";
    }
    
    NSMutableDictionary *dict = [self convertToDictFromModel];
    
    return dict;
}

//关键词搜索
-(NSMutableDictionary *) getKeyWordsDict:(NSString *) keyWords
{
    self.keyword = keyWords;
    self.radius = 0;
    self.category = nil;
    self.region = nil;
    
    NSMutableDictionary *dict = [self convertToDictFromModel];
    
    return dict;
}
//城市搜索
- (NSMutableDictionary *) getCityDict: (NSString *) cityName
{
    self.city = cityName;
    self.radius = 0;
    self.category = nil;
    self.region = nil;
    self.keyword = nil;
    self.sort = 1;
    self.latitude = 0;
    self.longitude = 0;
    
    NSMutableDictionary *dict = [self convertToDictFromModel];
    
    return dict;
}
//排序
- (NSMutableDictionary *) getSortTxt: (NSNumber *) sortTxt
{
    self.sort = sortTxt.intValue ;
   
    NSMutableDictionary *dict = [self convertToDictFromModel];
    
    return dict;
}
//附近搜索
- (NSMutableDictionary *) getsortLatitude:(double)latitude longitude:(double)longitude radius:(int)radius
{
    self.latitude = latitude;
    self.longitude = longitude;
    self.radius = radius;
    NSMutableDictionary *dict = [self convertToDictFromModel];
    return dict;
}

- (NSMutableDictionary *) getCategoryDict:(NSString *)category
{
    if ([category isEqual:@"全部分类"])
    {
        self.category = nil;
    }
    else
    {
        self.category = category;
    }
    
    NSMutableDictionary *dict = [self convertToDictFromModel];
    
    return dict;
}

- (NSMutableDictionary *) getRegionDict:(NSString *)region
{
    if ([region isEqual:@"全部"])
    {
        self.region = nil;
    }
    else
    {
        self.region = region;
    }
    
    self.radius = 0;
    
    if (self.sort != 7)
    {
        self.latitude = 0;
        self.longitude = 0;
    }
    
    NSMutableDictionary *dict = [self convertToDictFromModel];
    
    return dict;
}


-(NSMutableDictionary *) convertToDictFromModel
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    if (STRVALID(self.city))
    {
        [params setObject:self.city forKey:@"city"];
    }
    else
    {
        self.city = @"北京";
        [params setObject:self.city forKey:@"city"];
    }
    
    if (STRVALID(self.category))
    {
        [params setObject:self.category forKey:@"category"];
    }
    
    if (STRVALID(self.keyword))
    {
        [params setObject:self.keyword forKey:@"keyword"];
    }
    
    if (STRVALID(self.region))
    {
        [params setObject:self.region forKey:@"region"];
    }
    
    if (self.sort > 0)
    {
        [params setObject:@(self.sort) forKey:@"sort"];
    }
    else
    {
        self.sort = 1;
        [params setObject:@(self.sort) forKey:@"sort"];
    }
    
    if (self.pageIndex > 0)
    {
        [params setObject:@(self.pageIndex) forKey:@"page"];
    }
    else
    {
        self.pageIndex = 1;
        [params setObject:@(self.pageIndex) forKey:@"page"];
    }
    
    if (self.pageSize > 0)
    {
        [params setObject:@(self.pageSize) forKey:@"limit"];
    }
    else
    {
        self.pageSize = 20;
        [params setObject:@(self.pageSize) forKey:@"limit"];
    }
    
    if (self.latitude > 0 && self.longitude > 0)
    {
        [params setObject:@(self.latitude) forKey:@"latitude"];
        [params setObject:@(self.longitude) forKey:@"longitude"];
    }
    
    if (self.radius > 0)
    {
        [params setObject:@(self.radius) forKey:@"radius"];
    }
    
    return params;
}

@end

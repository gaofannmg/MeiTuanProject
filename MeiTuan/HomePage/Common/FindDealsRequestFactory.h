//
//  FindDealsRequestFactory.h
//  MeiTuan
//
//  Created by GaoYong on 15/11/1.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindDealsRequestFactory : NSObject

@property (nonatomic,copy) NSString *region; //包含团购信息的城市区域名
@property (nonatomic,copy) NSString *city;//城市
@property (nonatomic,copy) NSString *category; //支持多个category合并查询，多个category用逗号分割。
@property (nonatomic,copy) NSString *keyword; //关键词，搜索范围包括商户名、商品名、地址等
@property (nonatomic) int sort;//结果排序，1:默认，2:价格低优先，3:价格高优先，4:购买人数多优先，5:最新发布优先，6:即将结束优先，7:离经纬度坐标距离近优先
@property (nonatomic) int pageSize;//每页返回的团单结果条目数上限
@property (nonatomic) int pageIndex;//页码 从1开始
@property (nonatomic) CGFloat latitude;//纬度坐标，须与经度坐标同时传入
@property (nonatomic) CGFloat longitude;//经度坐标
@property (nonatomic) int radius;//半径

-(instancetype) initWithCity:(NSString *) cityName;

-(NSMutableDictionary *) getDefaultSearchDict;

//关键词搜索
-(NSMutableDictionary *) getKeyWordsDict:(NSString *) keyWords;

- (NSMutableDictionary *) getCityDict:(NSString *) cityName;

- (NSMutableDictionary *) getSortTxt:(NSNumber *)sortTxt;

- (NSMutableDictionary *) getCategoryDict:(NSString *)category;

- (NSMutableDictionary *) getRegionDict:(NSString *)region;

@end

//
//  OtherDealsData.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/25.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "OtherDealsData.h"

@implementation OtherDealsData

+(NSMutableArray *) getDealsData:(NSDictionary *) basicData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++)
    {
        NSMutableDictionary *temDict = [NSMutableDictionary dictionary];
        [temDict setObject:[basicData objectForKey:@"current_price"] forKey:@"current_price"];
        [temDict setObject:[basicData objectForKey:@"list_price"] forKey:@"list_price"];
        [temDict setObject:[basicData objectForKey:@"title"] forKey:@"title"];
        
        [dataArray addObject:temDict];
    }
    
    return dataArray;
}


@end

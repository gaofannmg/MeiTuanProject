//
//  CommonMethod.m
//  MeiTuan
//
//  Created by gaofan on 15/10/25.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "CommonMethod.h"

@implementation CommonMethod

+ (BOOL)checkStringValid:(NSString *)string
{
    if(!string) return NO;
    if(![string isKindOfClass:[NSString class]]) return NO;
    if([string compare:@""] == NSOrderedSame) return NO;
    if([string compare:@"(null)"] == NSOrderedSame) return NO;
    
    return YES;
}

@end

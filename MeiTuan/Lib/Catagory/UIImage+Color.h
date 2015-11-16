//
//  UIImage+Color.h
//  TestNewIOS7
//
//  Created by Radar on 13-8-31.
//  Copyright (c) 2013年  . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorImage)

+ (UIImage*)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)imageWithColor:(UIColor *)color;

@end

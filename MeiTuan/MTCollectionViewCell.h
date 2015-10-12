//
//  MTCollectionViewCell.h
//  MeiTuan
//
//  Created by gaofan on 15/10/11.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTCollectionViewCell : UICollectionViewCell

-(void) refreshCell:(NSString *) nameLabelText detailsLabelText:(NSString *) detailsLabelText presentPriceLabelText:(NSString *) presentPriceLabelText originalPriceLabelText:(NSString *) originalPriceLabelText soldLabelText:(NSString *) soldLabelText imageViewName:(NSString *) imagname;

@end

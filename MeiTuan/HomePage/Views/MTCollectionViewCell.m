//
//  MTCollectionViewCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/11.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "MTCollectionViewCell.h"

@interface MTCollectionViewCell ()
{
    UILabel *nameLabel;
    UILabel *detailsLabel;//详情
    UILabel *presentPriceLabel;//现价
    UILabel *originalPriceLabel;//原价
    UILabel *soldLabel;//售出
}
@end

@implementation MTCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        nameLabel = [[UILabel alloc] init];
        detailsLabel = [[UILabel alloc] init];
        presentPriceLabel = [[UILabel alloc] init];
        originalPriceLabel = [[UILabel alloc] init];
        soldLabel = [[UILabel alloc] init];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void) refreshCell:(NSDictionary *) dic
{
    NSString *titleStr = dic[@"city"];
    NSString *detailsLabelStr = dic[@"description"];
    double presentPriceLabelStr = [dic[@"current_price"] doubleValue];
    double originalPriceLabelStr = [dic[@"list_price"] doubleValue];
    long soldLabelStr = [dic[@"purchase_count"] longValue];
    NSString *imageUrlStr = dic[@"image_url"];

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(2, 2, self.contentView.frame.size.width -4, 90);
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    [self.contentView addSubview:imageView];
   
    nameLabel.frame = CGRectMake(2,CGRectGetMaxY(imageView.frame) +2, imageView.frame.size.width -2, 20);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = titleStr;
    [self.contentView addSubview:nameLabel];
   
    detailsLabel.frame = CGRectMake(2, CGRectGetMaxY(nameLabel.frame) +2, imageView.frame.size.width -2, 40);
    detailsLabel.backgroundColor = [UIColor clearColor];
    detailsLabel.text = detailsLabelStr;
    detailsLabel.font = [UIFont fontWithName:nil size:10];
    detailsLabel.numberOfLines = 0;
    [self.contentView addSubview:detailsLabel];
    
    presentPriceLabel.frame = CGRectMake(2, CGRectGetMaxY(detailsLabel.frame) +1, 50, 20);
    presentPriceLabel.backgroundColor = [UIColor clearColor];
    NSNumber *presentNumber = [NSNumber numberWithDouble:presentPriceLabelStr];
    NSString *presentString = [presentNumber stringValue];
    NSString *presentStr = [NSString stringWithFormat:@"￥%@",presentString];
    presentPriceLabel.text = presentStr;
    presentPriceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:presentPriceLabel];
   
    originalPriceLabel.frame = CGRectMake(CGRectGetMaxX(presentPriceLabel.frame) +10, CGRectGetMaxY(detailsLabel.frame) +1,50, 20);
    originalPriceLabel.backgroundColor = [UIColor clearColor];
    originalPriceLabel.font = [UIFont fontWithName:nil size:11];
    NSNumber *originalNumber = [NSNumber numberWithDouble:originalPriceLabelStr];
    NSString *originalString = [originalNumber stringValue];
    NSString *originaStr = [NSString stringWithFormat:@"￥%@",originalString];
    originalPriceLabel.text = originaStr;
    originalPriceLabel.textColor = RGB(85, 85, 85);
    [self.contentView addSubview:originalPriceLabel];
   
    soldLabel.frame = CGRectMake(CGRectGetMaxX(originalPriceLabel.frame) +5, CGRectGetMaxY(detailsLabel.frame) +1, 55, 20);
    soldLabel.backgroundColor = [UIColor clearColor];
    soldLabel.font = [UIFont fontWithName:nil size:11];
    NSNumber *soldNumber = [NSNumber numberWithDouble:soldLabelStr];
    NSString *soldString = [soldNumber stringValue];
    NSString *soldStr = [NSString stringWithFormat:@"已售出%@",soldString];
    soldLabel.text = soldStr;
    [self.contentView addSubview:soldLabel];
}
@end

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
    NSURL *url = [NSURL URLWithString:imageUrlStr];
    NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedAlways error:nil];
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(2, 2, self.contentView.frame.size.width -4, 65);
    imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:imageView];
   
    nameLabel.frame = CGRectMake(2,CGRectGetMaxY(imageView.frame) +2, imageView.frame.size.width -2, 20);
    nameLabel.backgroundColor = [UIColor redColor];
    nameLabel.text = titleStr;
    [self.contentView addSubview:nameLabel];
   
    detailsLabel.frame = CGRectMake(2, CGRectGetMaxY(nameLabel.frame) +2, imageView.frame.size.width -2, 30);
    detailsLabel.backgroundColor = [UIColor redColor];
    detailsLabel.text = detailsLabelStr;
    [self.contentView addSubview:detailsLabel];
    
    presentPriceLabel.frame = CGRectMake(2, CGRectGetMaxY(detailsLabel.frame) +5, 50, 20);
    presentPriceLabel.backgroundColor = [UIColor redColor];
    NSNumber *presentNumber = [NSNumber numberWithDouble:presentPriceLabelStr];
    NSString *presentString = [presentNumber stringValue];
    presentPriceLabel.text = presentString;
    [self.contentView addSubview:presentPriceLabel];
   
    originalPriceLabel.frame = CGRectMake(CGRectGetMaxX(presentPriceLabel.frame) +10, CGRectGetMaxY(detailsLabel.frame) +5,30, 20);
    originalPriceLabel.backgroundColor = [UIColor redColor];
    NSNumber *originalNumber = [NSNumber numberWithDouble:originalPriceLabelStr];
    NSString *originalString = [originalNumber stringValue];
    originalPriceLabel.text = originalString;
    [self.contentView addSubview:originalPriceLabel];
   
    soldLabel.frame = CGRectMake(CGRectGetMaxX(originalPriceLabel.frame) +5, CGRectGetMaxY(detailsLabel.frame) +5, 50, 20);
    soldLabel.backgroundColor = [UIColor redColor];
    NSNumber *soldNumber = [NSNumber numberWithDouble:soldLabelStr];
    NSString *soldString = [soldNumber stringValue];
    soldLabel.text = soldString;
    [self.contentView addSubview:soldLabel];
}
@end

//
//  HomeCollectionViewCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/11.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()
{
    UILabel *nameLabel;
    UILabel *detailsLabel;//详情
    UILabel *presentPriceLabel;//现价
    UILabel *originalPriceLabel;//原价
    UILabel *soldLabel;//售出
    UIImageView *imageView;
}
@end

@implementation HomeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        nameLabel = [[UILabel alloc] init];
        detailsLabel = [[UILabel alloc] init];
        presentPriceLabel = [[UILabel alloc] init];
        originalPriceLabel = [[UILabel alloc] init];
        soldLabel = [[UILabel alloc] init];
        imageView = [[UIImageView alloc] init];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void) refreshCell:(NSDictionary *) dic
{
    NSString *titleStr = dic[@"title"];
    NSString *detailsLabelStr = dic[@"description"];
    double presentPriceLabelStr = [dic[@"current_price"] doubleValue];
    double originalPriceLabelStr = [dic[@"list_price"] doubleValue];
    long soldLabelStr = [dic[@"purchase_count"] longValue];
    NSString *imageUrlStr = dic[@"image_url"];

    imageView.frame = CGRectMake(1, 2, self.contentView.frame.size.width -2, 120);
    [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]];
    [self.contentView addSubview:imageView];
   
    nameLabel.frame = CGRectMake(1,CGRectGetMaxY(imageView.frame) +1, self.contentView.frame.size.width, 20);
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = titleStr;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:nameLabel];
   
    detailsLabel.frame = CGRectMake(1, CGRectGetMaxY(nameLabel.frame) +2,self.contentView.frame.size.width, 50);
    detailsLabel.backgroundColor = [UIColor clearColor];
    detailsLabel.text = detailsLabelStr;
    detailsLabel.font = [UIFont systemFontOfSize:10];
    detailsLabel.numberOfLines = 0;
    [self.contentView addSubview:detailsLabel];
    
    presentPriceLabel.frame = CGRectMake(1, CGRectGetMaxY(detailsLabel.frame) +5, 55, 20);
    presentPriceLabel.backgroundColor = [UIColor clearColor];
    NSNumber *presentNumber = [NSNumber numberWithDouble:presentPriceLabelStr];
    NSString *presentString = [presentNumber stringValue];
    NSString *presentStr = [NSString stringWithFormat:@"￥%@",presentString];
    presentPriceLabel.text = presentStr;
    presentPriceLabel.font = [UIFont systemFontOfSize:12];
    presentPriceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:presentPriceLabel];
   
    soldLabel.frame = CGRectMake(self.contentView.frame.size.width - 71, CGRectGetMaxY(detailsLabel.frame) +5,70, 20);
    soldLabel.backgroundColor = [UIColor clearColor];
    soldLabel.font = [UIFont systemFontOfSize:11];
    NSNumber *soldNumber = [NSNumber numberWithDouble:soldLabelStr];
    NSString *soldString = [soldNumber stringValue];
    NSString *soldStr = [NSString stringWithFormat:@"已售出%@",soldString];
    soldLabel.text = soldStr;
    soldLabel.font = [UIFont systemFontOfSize:10];
    soldLabel.textColor = RGB(85, 85, 85);
    [self.contentView addSubview:soldLabel];
    
    originalPriceLabel.frame = CGRectMake(CGRectGetMaxX(presentPriceLabel.frame) +1, CGRectGetMaxY(detailsLabel.frame) +5,self.contentView.frame.size.width -1 - presentPriceLabel.frame.size.width -1- soldLabel.frame.size.width, 20);
    originalPriceLabel.backgroundColor = [UIColor clearColor];
    originalPriceLabel.font = [UIFont systemFontOfSize:11];
    NSNumber *originalNumber = [NSNumber numberWithDouble:originalPriceLabelStr];
    NSString *originalString = [originalNumber stringValue];
    NSString *originaStr = [NSString stringWithFormat:@"￥%@",originalString];
    originalPriceLabel.text = originaStr;
    originalPriceLabel.font = [UIFont systemFontOfSize:10];
    originalPriceLabel.textColor = RGB(85, 85, 85);
    [self.contentView addSubview:originalPriceLabel];
}
@end

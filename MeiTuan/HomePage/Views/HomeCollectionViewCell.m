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
    detailsLabel.numberOfLines = 4;
    [self.contentView addSubview:detailsLabel];
    
    [detailsLabel sizeToFit];
    
    NSNumber *soldNumber = [NSNumber numberWithDouble:soldLabelStr];
    NSString *soldString = [soldNumber stringValue];
    NSString *soldStr = [NSString stringWithFormat:@"已售出%@",soldString];
    soldLabel.text = soldStr;
    [soldLabel sizeToFit];
    soldLabel.frame = CGRectMake(1, self.contentView.frame.size.height - soldLabel.frame.size.height - 3,self.contentView.frame.size.width, soldLabel.frame.size.height);
    soldLabel.backgroundColor = [UIColor clearColor];
    soldLabel.font = [UIFont systemFontOfSize:13];
    
    
    soldLabel.textColor = RGB(85, 85, 85);
    [self.contentView addSubview:soldLabel];
    
    presentPriceLabel.frame = CGRectMake(1, CGRectGetMinY(soldLabel.frame) - 3 - 20,self.contentView.frame.size.width/2 - 1, 20);
    presentPriceLabel.backgroundColor = [UIColor clearColor];
    NSString *presentStr = [NSString stringWithFormat:@"￥%0.1f",presentPriceLabelStr];
    presentPriceLabel.text = presentStr;
    presentPriceLabel.font = [UIFont systemFontOfSize:15];
    presentPriceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:presentPriceLabel];
    
    [presentPriceLabel sizeToFit];
    
    originalPriceLabel.frame = CGRectMake(CGRectGetMaxX(presentPriceLabel.frame)+10, presentPriceLabel.frame.origin.y , presentPriceLabel.frame.size.width, 20);
    originalPriceLabel.backgroundColor = [UIColor clearColor];
    originalPriceLabel.font = [UIFont systemFontOfSize:13];
    NSNumber *originalNumber = [NSNumber numberWithDouble:originalPriceLabelStr];
    NSString *originalString = [originalNumber stringValue];
    NSString *originaStr = [NSString stringWithFormat:@"￥%@",originalString];
    originalPriceLabel.text = originaStr;
    originalPriceLabel.textColor = RGB(85, 85, 85);
    [self.contentView addSubview:originalPriceLabel];
    
    [originalPriceLabel sizeToFit];
    
    originalPriceLabel.center = CGPointMake(originalPriceLabel.center.x, presentPriceLabel.center.y);
}
@end

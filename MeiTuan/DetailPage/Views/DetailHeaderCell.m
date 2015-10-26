//
//  DetailCell.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/18.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailHeaderCell.h"


@interface DetailHeaderCell ()
{
    UIImageView *titleImageView;
    UIButton *outBtn;
    UILabel *originalpriceLabel;
    UILabel *presentpriceLabel;
    UIButton *buyBtn;
    UILabel *label1;
    UILabel *label2;
    UIView *lineView;
    UIView *presentCutView;
}

@end

@implementation DetailHeaderCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
       
        titleImageView = [[UIImageView alloc] init];
        outBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        originalpriceLabel = [[UILabel alloc] init];
        presentpriceLabel = [[UILabel alloc] init];
        buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.curBuyButton = buyBtn;
        [buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        label1 = [[UILabel alloc] init];
        label2 = [[UILabel alloc] init];
        lineView = [[UIView alloc] init];//分割线
        presentCutView = [[UIView alloc] init];//现价切线
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(void) buyBtnClick
{
    [self.detailVC.listVC changeBtnColor:[UIColor redColor]];
}

- (void) refreshCell:(NSDictionary *) dic
{
    if (!dic)
    {
        return;
    }

    titleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    NSString *urlStr = [dic objectForKey:@"image_url"];
    [titleImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    titleImageView.contentMode = UIViewContentModeScaleAspectFill;
    titleImageView.backgroundColor = [UIColor redColor];
    titleImageView.clipsToBounds = YES;
    [self.contentView addSubview:titleImageView];
    
    originalpriceLabel.frame = CGRectMake(10,CGRectGetMaxY(titleImageView.frame)+5, 60, 30);
    originalpriceLabel.backgroundColor = [UIColor clearColor];
    NSNumber *opNumber = [dic objectForKey:@"current_price"];
    NSString *opStr = [NSString stringWithFormat:@"¥%@",opNumber];
    originalpriceLabel.text = opStr;
    originalpriceLabel.font =[UIFont systemFontOfSize:15.0];
    originalpriceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:originalpriceLabel];
    
    presentpriceLabel.frame = CGRectMake(CGRectGetMaxX(originalpriceLabel.frame) +5,originalpriceLabel.frame.origin.y,50, 30);
    presentpriceLabel.backgroundColor = [UIColor clearColor];
    NSNumber *prNumber = [dic objectForKey:@"list_price"];
    NSString *prStr = [NSString stringWithFormat:@"¥%@",prNumber];
    presentpriceLabel.text = prStr;
    presentpriceLabel.font =[UIFont systemFontOfSize:12.0];
    presentpriceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:presentpriceLabel];
    
    presentCutView.frame = CGRectMake(presentpriceLabel.frame.origin.x - 5, presentpriceLabel.center.y, presentpriceLabel.frame.size.width, 1);
    presentCutView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:presentCutView];
    
    buyBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 105, presentpriceLabel.frame.origin.y, 100, 30);
    buyBtn.backgroundColor = [UIColor orangeColor];
    [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:buyBtn];
    
    lineView.frame = CGRectMake(0, CGRectGetMaxY(originalpriceLabel.frame) +5, [UIScreen mainScreen].bounds.size.width, 0.5);
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];//分割线
    
    label1.frame = CGRectMake(10,CGRectGetMaxY(presentpriceLabel.frame) +10, 100, 30);
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"限时可退";
    label1.font = [UIFont systemFontOfSize:12.0];
    label1.textColor = [UIColor grayColor];
    [self.contentView addSubview:label1];
    
    label2.frame = CGRectMake(buyBtn.frame.origin.x, label1.frame.origin.y, 100, 30);
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"过期自动退";
    label2.font = [UIFont systemFontOfSize:12.0];
    label2.textColor = [UIColor grayColor];
    [self.contentView addSubview:label2];
    
    NSDictionary *restrictionDic = [dic objectForKey:@"restrictions"];
    
    BOOL isRefundable = [[restrictionDic objectForKey:@"is_refundable"] boolValue];
    if (isRefundable)
    {
        label1.hidden = NO;
    }
    else
    {
        label1.hidden = YES;
    }
    
    BOOL isReservationRequired = [[restrictionDic objectForKey:@"is_reservation_required"] boolValue];
    if (isReservationRequired)
    {
        label2.hidden = NO;
    }
    else
    {
        label2.hidden = YES;
    }
}



@end

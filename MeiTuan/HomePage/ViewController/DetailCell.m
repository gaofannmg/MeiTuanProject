//
//  DetailCell.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/18.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailCell.h"
#import "DetailViewController.h"

@interface DetailCell ()
{
    UIImageView *titleImageView;
    UIButton *outBtn;
    UILabel *originalpriceLabel;
    UILabel *presentpriceLabel;
    UIButton *buyBtn;
    UILabel *label1;
    UILabel *label2;
    UIView *lineView;
}
@end

@implementation DetailCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        titleImageView = [[UIImageView alloc] init];
        outBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        originalpriceLabel = [[UILabel alloc] init];
        presentpriceLabel = [[UILabel alloc] init];
        buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        label1 = [[UILabel alloc] init];
        label2 = [[UILabel alloc] init];
        lineView = [[UIView alloc] init];//分割线
    }
    return self;
}

- (void) refreshCell:(NSDictionary *) dic
{
    titleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    titleImageView.image = [UIImage imageNamed:@""];
    titleImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:titleImageView];
    
    outBtn.frame = CGRectMake(0, 0, 60, 30);
    outBtn.backgroundColor = [UIColor blackColor];
    outBtn.alpha = 0.5;
    [outBtn setTitle:@"返回" forState:UIControlStateNormal];
    outBtn.userInteractionEnabled = YES;
    [outBtn addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:outBtn];
    
    originalpriceLabel.frame = CGRectMake(0,CGRectGetMaxY(titleImageView.frame), 100, 30);
    originalpriceLabel.backgroundColor = [UIColor greenColor];
    originalpriceLabel.text = @"原价";
    [self.contentView addSubview:originalpriceLabel];
    
    presentpriceLabel.frame = CGRectMake(CGRectGetMaxX(originalpriceLabel.frame) +5,CGRectGetMaxY(titleImageView.frame), 100, 30);
    presentpriceLabel.backgroundColor = [UIColor greenColor];
    presentpriceLabel.text = @"现价";
    [self.contentView addSubview:presentpriceLabel];
    
    buyBtn.frame = CGRectMake(CGRectGetMaxX(presentpriceLabel.frame) + 50, CGRectGetMaxY(titleImageView.frame), 100, 30);
    buyBtn.backgroundColor = [UIColor greenColor];
    [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [self.contentView addSubview:buyBtn];
    
    lineView.frame = CGRectMake(0, CGRectGetMaxY(originalpriceLabel.frame) +10, [UIScreen mainScreen].bounds.size.width, 0.5);
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];//分割线
    
    label1.frame = CGRectMake(0,CGRectGetMaxY(originalpriceLabel.frame) +20, 100, 30);
    label1.backgroundColor = [UIColor greenColor];
    label1.text = @"限时可退";
    [self.contentView addSubview:label1];
    
    label2.frame = CGRectMake(buyBtn.frame.origin.x, label1.frame.origin.y, 100, 30);
    label2.backgroundColor = [UIColor greenColor];
    label2.text = @"过期自动退";
    [self.contentView addSubview:label2];
}


@end

//
//  DetailCell.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/18.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailCell.h"

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
    UIView *presentCutView;
}

@property (nonatomic,weak) DetailViewController *baseVC;

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
        presentCutView = [[UIView alloc] init];//现价切线
    }
    return self;
}

- (void) refreshCell:(NSDictionary *) dic baseVCNew:(DetailViewController *) baseVCNew
{
    self.baseVC = baseVCNew;
    
    titleImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    titleImageView.image = [UIImage imageNamed:@""];
    titleImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:titleImageView];
    
    outBtn.frame = CGRectMake(0, 0, 60, 30);
    outBtn.backgroundColor = [UIColor blackColor];
    outBtn.alpha = 0.5;
    [outBtn setTitle:@"返回" forState:UIControlStateNormal];
    outBtn.userInteractionEnabled = YES;
    [outBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:outBtn];
    
    originalpriceLabel.frame = CGRectMake(0,CGRectGetMaxY(titleImageView.frame)+5, 60, 30);
    originalpriceLabel.backgroundColor = [UIColor clearColor];
    originalpriceLabel.text = @"现价";
    originalpriceLabel.font =[UIFont fontWithName:nil size:15.0];
    originalpriceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:originalpriceLabel];
    
    presentpriceLabel.frame = CGRectMake(CGRectGetMaxX(originalpriceLabel.frame) +5,originalpriceLabel.frame.origin.y,60, 30);
    presentpriceLabel.backgroundColor = [UIColor clearColor];
    presentpriceLabel.text = @"原价";
    presentpriceLabel.font =[UIFont fontWithName:nil size:12.0];
    presentpriceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:presentpriceLabel];
    
    presentCutView.frame = CGRectMake(presentpriceLabel.frame.origin.x, presentpriceLabel.center.y, presentpriceLabel.frame.size.width, 1);
    presentCutView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:presentCutView];
    
    buyBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 105, presentpriceLabel.frame.origin.y, 100, 30);
    buyBtn.backgroundColor = [UIColor orangeColor];
    [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    buyBtn.titleLabel.font = [UIFont fontWithName:nil size:15.0];
    [self.contentView addSubview:buyBtn];
    
    lineView.frame = CGRectMake(0, CGRectGetMaxY(originalpriceLabel.frame) +5, [UIScreen mainScreen].bounds.size.width, 0.5);
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];//分割线
    
    label1.frame = CGRectMake(0,CGRectGetMaxY(presentpriceLabel.frame) +10, 100, 30);
    label1.backgroundColor = [UIColor clearColor];
    label1.text = @"限时可退";
    label1.font = [UIFont fontWithName: nil size:12.0];
    label1.textColor = [UIColor grayColor];
    [self.contentView addSubview:label1];
    
    label2.frame = CGRectMake(buyBtn.frame.origin.x, label1.frame.origin.y, 100, 30);
    label2.backgroundColor = [UIColor clearColor];
    label2.text = @"过期自动退";
    label2.font = [UIFont fontWithName: nil size:12.0];
    label2.textColor = [UIColor grayColor];
    [self.contentView addSubview:label2];
}
- (void) click
{
    [self.baseVC clickView];
}

@end

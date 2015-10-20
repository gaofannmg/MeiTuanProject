//
//  DetailThirdCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/19.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailThirdCell.h"

@interface DetailThirdCell ()
{
    UILabel *titleLabel;
    UILabel *nameLabel;
    UILabel *numberLabel;
    UILabel *priceLabel;
    UILabel *nameSubLabel;//名称下标题
    UILabel *numberSubLabel;//数量下标题
    UILabel *priceSubLabel;//价格下标题
    UILabel *totalLabel;//总价
    UILabel *totalSubLabel;//总价值 400元
    UILabel *groupBuyLabel;//团购
    UILabel *groupBuySubLabel;//团购价 218元
    UIButton *mornBtn;//更多
    UIView *cutView;//分割线
    UIView *cutNumberView;//数量下分割线
    UIView *cutPriceView;//单价下分割线
    UIView *cutNameView;//名称下分割线一
    UIView *cutNameSecondView;//
    UIView *cutMoreBtnView;//更多上分割线
}

@end

@implementation DetailThirdCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        titleLabel = [[UILabel alloc] init];
        nameLabel = [[UILabel alloc] init];
        numberLabel = [[UILabel alloc] init];
        priceLabel = [[UILabel alloc] init];
        nameSubLabel = [[UILabel alloc] init];
        numberSubLabel = [[UILabel alloc] init];
        priceSubLabel = [[UILabel alloc] init];
        totalLabel = [[UILabel alloc] init];
        totalSubLabel = [[UILabel alloc] init];
        groupBuyLabel = [[UILabel alloc] init];
        groupBuySubLabel =[[UILabel alloc] init];
        mornBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cutView = [[UIView alloc] init];
        cutNumberView = [[UIView alloc] init];
        cutPriceView = [[UIView alloc] init];
        cutNameView = [[UIView alloc] init];
        cutNameSecondView = [[UIView alloc] init];
        cutMoreBtnView = [[UIView alloc] init];
        
    }
    return self;
}

- (void) refreshThirdCell:(NSDictionary *)dic
{
    titleLabel.frame = CGRectMake(0, 0, 100, 30);
    titleLabel.text = @"团购详情";
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont fontWithName:nil size:12.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:titleLabel];
    cutView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+5, [UIScreen mainScreen].bounds.size.width, 0.5);
    cutView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutView];
    nameLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) +20, 100, 30);
    nameLabel.text = @"名称";
    nameLabel.textColor = [UIColor grayColor];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.font = [UIFont fontWithName:nil size:12.0];
    [self.contentView addSubview:nameLabel];
    cutNameView.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+5, [UIScreen mainScreen].bounds.size.width, 0.5);
    cutNameView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutNameView];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) +100, nameLabel.frame.origin.y, 50, 30);
    numberLabel.text = @"数量";
    numberLabel.textColor = [UIColor grayColor];
    numberLabel.backgroundColor = [UIColor clearColor];
    numberLabel.font = [UIFont fontWithName:nil size:12.0];
    [self.contentView addSubview:numberLabel];
    priceLabel.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame) +50, numberLabel.frame.origin.y, 50, 30);
    priceLabel.text = @"单价";
    priceLabel.textColor =[UIColor grayColor];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.font = [UIFont fontWithName:nil size:12.0];
    [self.contentView addSubview:priceLabel];
    nameSubLabel.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame) +21, 100, 30);
    nameSubLabel.text = @"豪华主题房";
    nameSubLabel.font =[UIFont fontWithName:nil size:15.0];
    nameSubLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:nameSubLabel];
    cutNameSecondView.frame = CGRectMake(0, CGRectGetMaxY(nameSubLabel.frame)+5, [UIScreen mainScreen].bounds.size.width, 0.5);
    cutNameSecondView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutNameSecondView];
    numberSubLabel.frame = CGRectMake(numberLabel.frame.origin.x,nameSubLabel.frame.origin.y, 50, 30);
    numberSubLabel.backgroundColor = [UIColor clearColor];
    numberSubLabel.text = @"4小时";
    numberSubLabel.font =[UIFont fontWithName:nil size:15.0];
    [self.contentView addSubview:numberSubLabel];
    priceSubLabel.frame = CGRectMake(priceLabel.frame.origin.x,numberSubLabel.frame.origin.y, 50, 30);
    priceSubLabel.backgroundColor = [UIColor clearColor];
    priceSubLabel.text = @"400元";
    priceSubLabel.font = [UIFont fontWithName:nil size:15.0];
    [self.contentView addSubview:priceSubLabel];
    totalLabel.frame = CGRectMake(numberSubLabel.frame.origin.x, CGRectGetMaxY(numberSubLabel.frame) +10, 50, 30);
    totalLabel.backgroundColor = [UIColor clearColor];
    totalLabel.text = @"总价值";
    totalLabel.textColor =[UIColor grayColor];
    totalLabel.font = [UIFont fontWithName:nil size:12.0];
    [self.contentView addSubview:totalLabel];
    cutNumberView.frame = CGRectMake(totalLabel.frame.origin.x,totalLabel.center.y, totalLabel.frame.size.width, 1);
    cutNumberView.backgroundColor =[UIColor grayColor];
    [self.contentView addSubview:cutNumberView];
    totalSubLabel.frame = CGRectMake(priceLabel.frame.origin.x, CGRectGetMaxY(priceSubLabel.frame) +10,30, 30);
    totalSubLabel.backgroundColor = [UIColor clearColor];
    totalSubLabel.text =@"400";
    totalSubLabel.textColor =[UIColor grayColor];
    totalSubLabel.font = [UIFont fontWithName:nil size:12.0];
    [self.contentView addSubview:totalSubLabel];
    cutPriceView.frame = CGRectMake(totalSubLabel.frame.origin.x, totalSubLabel.center.y, totalSubLabel.frame.size.width, 1);
    cutPriceView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutPriceView];

    groupBuyLabel.frame = CGRectMake(totalLabel.frame.origin.x, CGRectGetMaxY(totalLabel.frame) +5, 50, 20);
    groupBuyLabel.backgroundColor = [UIColor clearColor];
    groupBuyLabel.text = @"团购价";
    groupBuyLabel.textColor =[UIColor redColor];
    groupBuyLabel.font =[UIFont fontWithName:nil size:15.0];
    [self.contentView addSubview:groupBuyLabel];
    groupBuySubLabel.frame = CGRectMake(priceLabel.frame.origin.x,groupBuyLabel.frame.origin.y, 50, 20);
    groupBuySubLabel.backgroundColor = [UIColor clearColor];
    groupBuySubLabel.text = @"218";
    groupBuySubLabel.font = [UIFont fontWithName:nil size:15.0];
    groupBuySubLabel.textColor =[UIColor redColor];
    [self.contentView addSubview:groupBuySubLabel];
    cutMoreBtnView.frame = CGRectMake(0,CGRectGetMaxY(groupBuyLabel.frame)+5, [UIScreen mainScreen].bounds.size.width, 0.5);
    cutMoreBtnView.backgroundColor =[UIColor grayColor];
    [self.contentView addSubview:cutMoreBtnView];
    mornBtn.frame = CGRectMake(0, CGRectGetMaxY(groupBuySubLabel.frame)+10, [UIScreen mainScreen].bounds.size.width, 30);
    [mornBtn setTitle:@"更多图文详情" forState:UIControlStateNormal];
    [mornBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    mornBtn.titleLabel.font =[UIFont fontWithName:nil size:15.0];
    mornBtn.backgroundColor =[UIColor clearColor];
    [mornBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.contentView addSubview:mornBtn];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

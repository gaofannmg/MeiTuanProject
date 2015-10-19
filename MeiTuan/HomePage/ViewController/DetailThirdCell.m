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
        
    }
    return self;
}

- (void) refreshThirdCell:(NSDictionary *)dic
{
    titleLabel.frame = CGRectMake(0, 0, 100, 30);
    titleLabel.text = @"团购详情";
    titleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:titleLabel];
    nameLabel.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) +50, 100, 30);
    nameLabel.text = @"名称";
    nameLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:nameLabel];
    numberLabel.frame = CGRectMake(CGRectGetMaxX(nameLabel.frame) +100, nameLabel.frame.origin.y, 50, 30);
    numberLabel.text = @"数量";
    numberLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:numberLabel];
    priceLabel.frame = CGRectMake(CGRectGetMaxX(numberLabel.frame) +50, numberLabel.frame.origin.y, 50, 30);
    priceLabel.text = @"单价";
    priceLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:priceLabel];
    nameSubLabel.frame = CGRectMake(0, CGRectGetMaxY(nameLabel.frame) +21, 100, 30);
    nameSubLabel.text = @"豪华主题房";
    nameSubLabel.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:nameSubLabel];
    numberSubLabel.frame = CGRectMake(numberLabel.frame.origin.x,nameSubLabel.frame.origin.y, 50, 30);
    numberSubLabel.backgroundColor = [UIColor blueColor];
    numberSubLabel.text = @"4小时";
    [self.contentView addSubview:numberSubLabel];
    priceSubLabel.frame = CGRectMake(priceLabel.frame.origin.x,numberSubLabel.frame.origin.y, 50, 30);
    priceSubLabel.backgroundColor = [UIColor blueColor];
    priceSubLabel.text = @"400元";
    [self.contentView addSubview:priceSubLabel];
    totalLabel.frame = CGRectMake(numberSubLabel.frame.origin.x, CGRectGetMaxY(numberSubLabel.frame) +10, 50, 30);
    totalLabel.backgroundColor = [UIColor blueColor];
    totalLabel.text = @"总价值";
    [self.contentView addSubview:totalLabel];
    totalSubLabel.frame = CGRectMake(priceLabel.frame.origin.x, CGRectGetMaxY(priceSubLabel.frame) +10,50, 30);
    totalSubLabel.backgroundColor = [UIColor grayColor];
    totalSubLabel.text =@"400";
    [self.contentView addSubview:totalSubLabel];
    groupBuyLabel.frame = CGRectMake(totalLabel.frame.origin.x, CGRectGetMaxY(totalLabel.frame) +10, 50, 30);
    groupBuyLabel.backgroundColor = [UIColor redColor];
    groupBuyLabel.text = @"团购价";
    [self.contentView addSubview:groupBuyLabel];
    groupBuySubLabel.frame = CGRectMake(priceLabel.frame.origin.x, CGRectGetMaxY(totalSubLabel.frame)+10, 50, 30);
    groupBuySubLabel.backgroundColor = [UIColor grayColor];
    groupBuySubLabel.text = @"218";
    [self.contentView addSubview:groupBuySubLabel];
    mornBtn.frame = CGRectMake(0, CGRectGetMaxY(groupBuySubLabel.frame)+10, [UIScreen mainScreen].bounds.size.width, 30);
    [mornBtn setTitle:@"更多图文详情" forState:UIControlStateNormal];
    mornBtn.backgroundColor =[UIColor grayColor];
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

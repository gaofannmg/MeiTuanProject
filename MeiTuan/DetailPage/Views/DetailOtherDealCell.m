//
//  DetailSixthCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/21.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailOtherDealCell.h"

@interface DetailOtherDealCell ()
{
    UILabel *originalLabel;//原价
    UILabel *currentLabel;//现价
    UILabel *titleLabel;
    UIView *cutView;//价格划线
}
@end

@implementation DetailOtherDealCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        originalLabel = [[UILabel alloc] init];
        currentLabel = [[UILabel alloc] init];
        titleLabel = [[UILabel alloc] init];
        cutView = [[UIView alloc] init];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) refreshSixthCell:(NSDictionary *)dic
{
    currentLabel.frame = CGRectMake(10, 0, 60, 30);
    NSNumber *currentNumber = dic[@"current_price"];
    NSString *curStr = [NSString stringWithFormat:@"%@",currentNumber];
    currentLabel.text = curStr;
    currentLabel.textColor = [UIColor redColor];
    currentLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:currentLabel];
    [currentLabel sizeToFit];
    currentLabel.center = CGPointMake(currentLabel.center.x, self.contentView.center.y);
    
    originalLabel.frame = CGRectMake(CGRectGetMaxX(currentLabel.frame) +10, 0, 30, 30);
   NSNumber *originaNumber = dic[@"list_price"];
    NSString *oriStr = [NSString stringWithFormat:@"%@",originaNumber];
    originalLabel.text = oriStr;
    originalLabel.textColor = [UIColor grayColor];
    originalLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:originalLabel];
    [originalLabel sizeToFit];
    originalLabel.center = CGPointMake(originalLabel.center.x, currentLabel.center.y);
    
    cutView.frame = CGRectMake(originalLabel.frame.origin.x - 5, originalLabel.center.y, originalLabel.frame.size.width, 1);
    cutView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutView];
    
    titleLabel.frame = CGRectMake(CGRectGetMaxX(originalLabel.frame) +10, 0,245, 30);
    titleLabel.backgroundColor = [UIColor whiteColor];
    NSString *titleStr = dic[@"title"];
    titleLabel.text = titleStr;
    titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:titleLabel];
    [titleLabel sizeToFit];
    titleLabel.center = CGPointMake(titleLabel.center.x, originalLabel.center.y);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DetailSecondCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/19.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailSecondCell.h"

@interface DetailSecondCell ()
{
    UILabel *userLabel;
    UILabel *titleLabel;
    UIImageView *assessImageView;
    UIImageView *phoneImageView;
    UILabel *addressLabel;
    UIView *cutView; //分割线
    UIView *cutSecondView;
}
@end

@implementation DetailSecondCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        userLabel  = [[UILabel alloc] init];
        titleLabel = [[UILabel alloc] init];
        assessImageView = [[UIImageView alloc] init];
        phoneImageView = [[UIImageView alloc] init];
        addressLabel = [[UILabel alloc] init];
        cutView = [[UIView alloc] init];
        cutSecondView = [[UIView alloc] init];
    }
    return self;
}

- (void) refreshSecondCell:(NSDictionary *)dic
{
    userLabel.frame = CGRectMake(10, 0,WIN_WIDTH, 30);
    userLabel.backgroundColor = [UIColor clearColor];
    NSArray *businArray = dic[@"businesses"];
    NSDictionary *businessesDic = [businArray firstObject];
    NSNumber *idNumber = [businessesDic objectForKey:@"id"];
    NSString *userLabelStr = [NSString stringWithFormat:@"适用商户%@",idNumber];
    userLabel.text = userLabelStr;
    userLabel.font = [UIFont systemFontOfSize:12.0];
    userLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:userLabel];
    
    cutView.frame = CGRectMake(0, CGRectGetMaxY(userLabel.frame) +5, [UIScreen mainScreen].bounds.size.width, 0.5);
    cutView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutView];
   
    titleLabel.frame = CGRectMake(10, CGRectGetMaxY(userLabel.frame)+ 10, 300, 20);
    titleLabel.backgroundColor = [UIColor clearColor];
    NSString *titleStr = [businessesDic objectForKey:@"name"];
    titleLabel.text = titleStr;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    
    assessImageView.frame = CGRectMake(10, CGRectGetMaxY(titleLabel.frame) +10,70,15);
    assessImageView.backgroundColor = [UIColor greenColor];
    assessImageView.image = [UIImage imageNamed:@"star"];
    [self.contentView addSubview:assessImageView];
    
    phoneImageView.frame = CGRectMake([UIScreen mainScreen].bounds.size.width -35,titleLabel.frame.origin.y +10, 25, 25);
    phoneImageView.backgroundColor = [UIColor grayColor];
    phoneImageView.image = [UIImage imageNamed:@"phone"];
    [self.contentView addSubview:phoneImageView];
   
    cutSecondView.frame = CGRectMake(0, CGRectGetMaxY(assessImageView.frame) +5, [UIScreen mainScreen].bounds.size.width, 0.5);
    cutSecondView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:cutSecondView];
   
    addressLabel.frame = CGRectMake(10, CGRectGetMaxY(assessImageView.frame) +10, [UIScreen mainScreen].bounds.size.width, 30);
    addressLabel.backgroundColor = [UIColor clearColor];
    NSString *addressStr = [businessesDic objectForKey:@"address"];
    addressLabel.text = addressStr;
    addressLabel.textColor = [UIColor blackColor];
    addressLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:addressLabel];
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

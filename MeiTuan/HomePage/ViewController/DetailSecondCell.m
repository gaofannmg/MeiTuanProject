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
    UILabel *addressLabel;
}
@end

@implementation DetailSecondCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        userLabel  = [[UILabel alloc] init];
        titleLabel = [[UILabel alloc] init];
        assessImageView = [[UIImageView alloc] init];
        addressLabel = [[UILabel alloc] init];
    }
    return self;
}

- (void) refreshSecondCell:(NSDictionary *)dic
{
    userLabel.frame = CGRectMake(0, 0, 100, 30);
    userLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:userLabel];
    titleLabel.frame = CGRectMake(0, CGRectGetMaxY(userLabel.frame)+ 10, 200, 30);
    titleLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:titleLabel];
    assessImageView.frame = CGRectMake(0, CGRectGetMaxY(titleLabel.frame) +10, [UIScreen mainScreen].bounds.size.width,30);
    assessImageView.backgroundColor = [UIColor greenColor];
    assessImageView.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:assessImageView];
    addressLabel.frame = CGRectMake(0, CGRectGetMaxY(assessImageView.frame) +10, [UIScreen mainScreen].bounds.size.width, 30);
    addressLabel.backgroundColor = [UIColor greenColor];
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

//
//  DetailFifthCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/21.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailFifthCell.h"

@interface DetailFifthCell ()

{
    UILabel *label;
}
@end

@implementation DetailFifthCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        label = [[UILabel alloc] init];
    }
    return self;
}

- (void) refreshThirdCell:(NSDictionary *)dic
{
    label.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
    label.text = @"诗语原创主题公园的其他团购";
    label.font = [UIFont fontWithName:nil size:15];
    label.backgroundColor =[UIColor whiteColor];
    [self.contentView addSubview:label];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

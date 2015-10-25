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

- (void) refreshFifthCell:(NSDictionary *)dic
{
    label.frame = CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width, 30);
    NSArray *arr = dic[@"categories"];
    NSString *str = arr[0];
    NSString *s = [NSString stringWithFormat:@"%@的其他团购",str];
    label.text = s;
    label.font = [UIFont systemFontOfSize:15.0];
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

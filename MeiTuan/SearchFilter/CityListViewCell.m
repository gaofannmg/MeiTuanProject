//
//  CityListViewCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/27.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "CityListViewCell.h"

@implementation CityListViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void) refreshCell:(NSDictionary *) dic
{
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

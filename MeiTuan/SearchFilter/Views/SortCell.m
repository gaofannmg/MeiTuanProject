//
//  SortCell.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/29.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "SortCell.h"

@interface SortCell ()

@end

@implementation SortCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void) refreshCell:(NSString *)sortName
{
    self.textLabel.text = sortName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

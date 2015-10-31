//
//  LeftFilterCell.m
//  MeiTuan
//  左边筛选Cell
//  Created by GaoYong on 15/10/31.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "LeftFilterCell.h"

@interface LeftFilterCell ()
{
    UILabel *cellLabel;
    UIView *dotView;
}
@end

@implementation LeftFilterCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        cellLabel = [[UILabel alloc] init];
        cellLabel.backgroundColor = [UIColor clearColor];
        cellLabel.font = [UIFont systemFontOfSize:15];
        cellLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:cellLabel];
        
        dotView = [[UIView alloc] init];
        dotView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:dotView];
    }
    return self;
}

- (void) refreshCell:(NSString *) text isSelect:(BOOL) isSelect
{
    cellLabel.text = text;
    [cellLabel sizeToFit];
    cellLabel.center = CGPointMake(WIN_WIDTH * 0.28 / 2, 44/2);
    
    dotView.frame = CGRectMake(CGRectGetMinX(cellLabel.frame) - 10, cellLabel.center.y - 2.5, 5, 5);
    dotView.layer.cornerRadius = 2.5;
    dotView.layer.masksToBounds = YES;
    
    if (isSelect)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        dotView.hidden = NO;
    }
    else
    {
        self.contentView.backgroundColor = RGB(231, 231, 231);
        dotView.hidden = YES;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DetailSeventhCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/21.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailSeventhCell.h"

@interface DetailSeventhCell ()
{
    UIButton *btn;
}
@end

@implementation DetailSeventhCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        btn = [UIButton buttonWithType:UIButtonTypeSystem];
    }
    return self;
}
- (void) refreshThirdCell:(NSDictionary *)dic
{
    btn.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"还有7个团购" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(moreGroupPurchase) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:btn];
    
}

- (void)moreGroupPurchase
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

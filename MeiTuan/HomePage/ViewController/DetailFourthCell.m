//
//  DetailFourthCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/21.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailFourthCell.h"
#define winwidth [UIApplication sharedApplication].keyWindow.bounds.size.width
#define winheight [UIApplication sharedApplication].keyWindow.bounds.size.height

@interface DetailFourthCell ()
{
    
}
@end
@implementation DetailFourthCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) refreshThirdCell:(NSDictionary *)dic labelArray:(NSArray *) labelArray
{
    UILabel *lastLabel = nil;
    for (int a = 0; a < labelArray.count; a ++)
    {
        UILabel *requireLabel = (UILabel *)[self.contentView viewWithTag:100001 + a];
        
        if (!requireLabel)
        {
            requireLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, a *40,winwidth, 40)];
            requireLabel.backgroundColor = [UIColor whiteColor];
            requireLabel.text = labelArray[a];
            requireLabel.numberOfLines = 0;
            requireLabel.tag = 100001 + a;
            requireLabel.frame = CGRectMake(10,40,winwidth - 20,10);
            requireLabel.font = [UIFont fontWithName:nil size:12];
            requireLabel.textColor = [UIColor grayColor];
            [self.contentView addSubview:requireLabel];
        }
        
        NSDictionary *attDict = @{NSFontAttributeName:requireLabel.font};
        CGRect rect = [requireLabel.text boundingRectWithSize:CGSizeMake(requireLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDict context:NULL];

        if (!lastLabel)
        {
            requireLabel.frame = CGRectMake(0, 0 ,winwidth, rect.size.height);
        }
        else
        {
            requireLabel.frame = CGRectMake(0, CGRectGetMaxY(lastLabel.frame) + 1,winwidth, rect.size.height);
        }
        
        lastLabel = requireLabel;
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

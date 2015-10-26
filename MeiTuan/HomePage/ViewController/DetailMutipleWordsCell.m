//
//  DetailFourthCell.m
//  MeiTuan
//
//  Created by gaofan on 15/10/21.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailMutipleWordsCell.h"

@interface DetailMutipleWordsCell ()
{
    
}
@end
@implementation DetailMutipleWordsCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (CGFloat) refreshFourthCell:(NSDictionary *)dic labelArray:(NSArray *) labelArrayData
{
    NSMutableArray *labelArray = [NSMutableArray array];
    for (int i = 0; i < labelArrayData.count; i++)
    {
        NSString *titleTxt = labelArrayData[i];
        
        titleTxt = [titleTxt stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if (!STRVALID(titleTxt))
        {
            continue;
        }
        
        [labelArray addObject:titleTxt];
    }
    
    UILabel *lastLabel = nil;
    for (int a = 0; a < labelArray.count; a ++)
    {
        UILabel *requireLabel = (UILabel *)[self.contentView viewWithTag:100001 + a];
        
        if (!requireLabel)
        {
            requireLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0 , WIN_WIDTH - 20, 10)];
            requireLabel.backgroundColor = [UIColor whiteColor];
            requireLabel.text = labelArray[a];
            requireLabel.numberOfLines = 0;
            requireLabel.tag = 100001 + a;
            requireLabel.font = [UIFont systemFontOfSize:14];
            requireLabel.textColor = [UIColor grayColor];
            [self.contentView addSubview:requireLabel];
        }
        
        NSDictionary *attDict = @{NSFontAttributeName:requireLabel.font};
        CGRect rect = [requireLabel.text boundingRectWithSize:CGSizeMake(requireLabel.bounds.size.width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDict context:NULL];

        if (!lastLabel)
        {
            requireLabel.frame = CGRectMake(10, 10 ,requireLabel.frame.size.width, rect.size.height);
        }
        else
        {
            requireLabel.frame = CGRectMake(10, CGRectGetMaxY(lastLabel.frame),requireLabel.frame.size.width, rect.size.height);
        }
        
        lastLabel = requireLabel;
    }
    
    return CGRectGetMaxY(lastLabel.frame) + 10;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

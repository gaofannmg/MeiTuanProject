//
//  SortPopView.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/29.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "SortPopView.h"
#import "SortCell.h"

@interface SortPopView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *contentView;
    NSMutableArray *dataArray;
    NSString *specialItem;
    
    CGFloat noItemHeight;
    CGFloat basicItemHeight;
}
@end

@implementation SortPopView

- (instancetype) initWithFrame:(CGRect)frame
{
    basicItemHeight = frame.size.height;
    noItemHeight = frame.size.height - 44;
    if (self = [super initWithFrame:frame])
    {
        dataArray = [NSMutableArray array];
        [dataArray addObject:@"默认排序"];
        [dataArray addObject:@"价格最低"];
        [dataArray addObject:@"价格最高"];
        [dataArray addObject:@"人气最高"];
        [dataArray addObject:@"最新发布"];
        [dataArray addObject:@"即将结束"];
        
        specialItem = @"离我最近";
        [dataArray addObject:specialItem];
        
        [self makeUI];
    }
    
    return self;
}

-(void) makeUI
{
    contentView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView registerClass:[SortCell class] forCellReuseIdentifier:@"SortCell"];
    contentView.delegate = self;
    contentView.dataSource = self;
    
    [self addSubview:contentView];
    
    [contentView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SortCell *cell = [contentView dequeueReusableCellWithIdentifier:@"SortCell" forIndexPath:indexPath];
    NSString *sortName = dataArray[indexPath.row];
    [cell refreshCell:sortName];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sortName = dataArray[indexPath.row];
    
    [self.basicVC sortWithText:sortName];
}

-(void) showZuijinItem:(BOOL) isShow
{
    if (isShow)
    {
        if (![dataArray containsObject:specialItem])
        {
            [dataArray addObject:specialItem];
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, basicItemHeight);
    }
    else
    {
        if ([dataArray containsObject:specialItem])
        {
            [dataArray removeObject:specialItem];
        }
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, noItemHeight);
    }
    
    
    NSIndexPath *ipath = [contentView indexPathForSelectedRow];
    [contentView reloadData];
    [contentView selectRowAtIndexPath:ipath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

-(void) selectFirstRow
{
    [contentView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

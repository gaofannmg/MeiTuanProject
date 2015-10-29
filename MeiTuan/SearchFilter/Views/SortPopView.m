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
}
@end

@implementation SortPopView

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        dataArray = [NSMutableArray array];
        [dataArray addObject:@"默认排序"];
        [dataArray addObject:@"价格最低"];
        [dataArray addObject:@"价格最高"];
        [dataArray addObject:@"人气最高"];
        [dataArray addObject:@"最新发布"];
        [dataArray addObject:@"即将结束"];
        [dataArray addObject:@"离我最近"];
        
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

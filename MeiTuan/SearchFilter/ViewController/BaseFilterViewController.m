//
//  FilterViewController.m
//  MeiTuan
//  分类与区域基类
//  Created by GaoYong on 15/10/31.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "BaseFilterViewController.h"
#import "LeftFilterCell.h"
#import "CatagoryFilterViewController.h"

@interface BaseFilterViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *titleView;
    NSInteger leftSelectIndex;
    NSInteger rightSelectIndex;
}
@end

@implementation BaseFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    rightSelectIndex = -1;
    
    rightArrayKeyString = @"subcategories";
    
    [self createNaigaitionBar];
    
    [self createUI];
}

-(void) createNaigaitionBar
{
    titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
    titleLable.center = CGPointMake(titleView.center.x, titleLable.center.y);
    titleLable.textColor = RGB(45, 45, 45);
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:titleLable];
    
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    outBtn.frame = CGRectMake(5,20,60, 44);
    outBtn.backgroundColor = [UIColor whiteColor];
    [outBtn setTitle:@"返回" forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [outBtn setTitleColor:RGB(45, 45, 45) forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:outBtn];
    
    UIView *splitView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.frame.size.height - 0.5, titleView.bounds.size.width, 0.5)];
    splitView.backgroundColor = RGB(175, 175, 175);
    [titleView addSubview:splitView];
}

- (void) createUI
{
    leftTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), self.view.frame.size.width * 0.28, self.view.frame.size.height - titleView.frame.size.height) style:UITableViewStylePlain];
    leftTabView.backgroundColor = [UIColor grayColor];
    leftTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:leftTabView];
    
    rightTabVIew = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftTabView.frame), CGRectGetMaxY(titleView.frame), self.view.frame.size.width - leftTabView.frame.size.width,self.view.frame.size.height - titleView.frame.size.height) style:UITableViewStylePlain];
    rightTabVIew.backgroundColor = [UIColor greenColor];
    [self.view addSubview:rightTabVIew];
    
    [leftTabView registerClass:[LeftFilterCell class] forCellReuseIdentifier:@"leftCell"];
    [rightTabVIew registerClass:[UITableViewCell class] forCellReuseIdentifier:@"rightCell"];
    
    leftTabView.dataSource = self;
    leftTabView.delegate = self;
   
    rightTabVIew.dataSource = self;
    rightTabVIew.delegate = self;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == leftTabView)
    {
        return leftArray.count;
    }
    else
    {
        return rightArray.count;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == leftTabView)
    {
        LeftFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        NSDictionary *dict = leftArray[indexPath.row];
        NSString *titleName = dict[@"name"];
        if (indexPath.row == leftSelectIndex)
        {
            [cell refreshCell:titleName isSelect:YES];
        }
        else
        {
            [cell refreshCell:titleName isSelect:NO];
        }
        
        return cell;
    }
    else
    {
        NSString *rightTitle = rightArray[indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        cell.textLabel.text = rightTitle;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == rightSelectIndex)
        {
            cell.textLabel.textColor = [UIColor redColor];
        }
        else
        {
            cell.textLabel.textColor = RGB(45, 45, 45);
        }
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == leftTabView)
    {
        leftSelectIndex = indexPath.row;
        [leftTabView reloadData];
        //刷新右边数据
        NSDictionary *leftDataDict =leftArray[indexPath.row];
        rightArray = leftDataDict[rightArrayKeyString];
        
        [rightTabVIew reloadData];
    }
    else
    {
        rightSelectIndex = indexPath.row;
        [rightTabVIew reloadData];
    }
}

//返回
- (void) clickView
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

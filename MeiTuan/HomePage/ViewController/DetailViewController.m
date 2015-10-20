//
//  PushViewCont.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/17.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "DetailSecondCell.h"
#import "DetailThirdCell.h"

@interface DetailViewController ()<DPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSArray *array;
}
@end

@implementation DetailViewController

- (instancetype) init
{
    if (self == [super init])
    {
        
    }
    return self;
}



-(void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor whiteColor];

    UITableView *detailTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    [detailTabView registerClass:[DetailCell class] forCellReuseIdentifier:@"DetailCell"];
    [detailTabView registerClass:[DetailSecondCell class] forCellReuseIdentifier:@"DetailSecondCell"];
    [detailTabView registerClass:[DetailThirdCell class] forCellReuseIdentifier:@"DetailThirdCell.h"];
    
    detailTabView.delegate = self;
    detailTabView.dataSource = self;
    detailTabView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:detailTabView];
    
    [self getDealDetailData];
}

- (void) clickView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) getDealDetailData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"2-8005555" forKey:@"deal_id"];
    NSLog(@"发送请求的参数: %@", params.allValues);
    DPAPI *api = [[DPAPI alloc] init];
    [api requestWithURL:@"v1/deal/get_single_deal" params:params delegate:self];
}
#pragma mark -- 发送请求回调方法
//成功
- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //result 字典
    NSLog(@"%@",result);

}
//失败
- (void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0) {
        return 1;
    }
    else if(section ==1)
    {
        return 1;
    }
    else if(section ==2)
    {
        return 1;
    }
    else if(section ==3)
    {
        return 4;
    }
    else if(section == 4)
    {
        return 1;
    }
    else
    {
        return 3;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
//        NSDictionary *dic = array[indexPath.row];
        [cell refreshCell:nil baseVCNew:self];
        cell.userInteractionEnabled = YES;
        return cell;
    }
    else if (indexPath.section == 1) {
        DetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailSecondCell" forIndexPath:indexPath];
        [cell refreshSecondCell:nil];
        return cell;
    }
    
    else if (indexPath.section == 2) {
        DetailThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailThirdCell.h" forIndexPath:indexPath];
        [cell refreshThirdCell:nil];
        return cell;
    }
    return nil;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 280;
    }
    else if (indexPath.section ==1){
        return 160;
    }
    else if (indexPath.section == 2){
        return 250;
    }
    return 0;
}




@end

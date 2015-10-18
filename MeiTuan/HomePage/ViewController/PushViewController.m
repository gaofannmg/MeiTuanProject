//
//  PushViewCont.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/17.
//  Copyright (c) 2015年 gaofan. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()<DPRequestDelegate>

@end

@implementation PushViewController

- (instancetype) init
{
    if (self == [super init])
    {
        
    }
    return self;
}

- (void) clickView
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    titleImageView.image = [UIImage imageNamed:@""];
    titleImageView.backgroundColor = [UIColor redColor];
    [view addSubview:titleImageView];
    
    UIButton *outBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    outBtn.backgroundColor = [UIColor blackColor];
    outBtn.frame = CGRectMake(0, 15, 60, 30);
    outBtn.alpha = 0.5;
    [outBtn setTitle:@"返回" forState:UIControlStateNormal];
    outBtn.userInteractionEnabled = YES;
    [outBtn addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:outBtn];
    
    UILabel *originalpriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(titleImageView.frame) +5, 100, 50)];
    originalpriceLabel.backgroundColor = [UIColor greenColor];
    originalpriceLabel.text = @"原价";
    [view addSubview:originalpriceLabel];
    
    UILabel *presentpriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(originalpriceLabel.frame) +5,CGRectGetMaxY(titleImageView.frame) +5, 100, 50)];
    presentpriceLabel.backgroundColor = [UIColor greenColor];
    presentpriceLabel.text = @"现价";
    [view addSubview:presentpriceLabel];
    
    UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    buyBtn.frame = CGRectMake(CGRectGetMaxX(presentpriceLabel.frame) + 50, CGRectGetMaxY(titleImageView.frame) +5, 100, 50);
    buyBtn.backgroundColor = [UIColor greenColor];
    [buyBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    [view addSubview:buyBtn];
    
    UILabel *detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(originalpriceLabel.frame) +5, [UIScreen mainScreen].bounds.size.width, 300)];
    detailsLabel.backgroundColor = [UIColor greenColor];
    detailsLabel.text = @"商品详情介绍 \n 111111111112312312312312321312321312312312312312312 \n \n \n \n \n \n \n \n \n ";
    detailsLabel.numberOfLines = 0;
    [view addSubview:detailsLabel];
    
    [self getDealDetailData];
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


@end

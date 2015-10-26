//
//  BuyWebViewController.m
//  MeiTuan
//
//  Created by GaoYong on 15/10/26.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "BuyWebViewController.h"

@interface BuyWebViewController ()<UIScrollViewDelegate,UIWebViewDelegate>
{
    UIView *titleView;
}
@end

@implementation BuyWebViewController

- (instancetype) init
{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    titleView = [[UIView alloc] init];
    titleView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    titleView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleView];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 44)];
    titleLable.center = CGPointMake(titleView.center.x, titleLable.center.y);
    titleLable.text = @"商户详情";
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
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame) - 44, WIN_WIDTH, WIN_HIGHT - (CGRectGetMaxY(titleView.frame) - 44))];
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView loadRequest:request];
    [self.view insertSubview:webView belowSubview:titleView];
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)clickView
{
    [self.navigationController popViewControllerAnimated:YES];
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

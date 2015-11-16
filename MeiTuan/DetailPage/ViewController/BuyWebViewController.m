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
    
    self.view.backgroundColor = RGB(240, 240, 240);
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 20, WIN_WIDTH, WIN_HIGHT - 20)];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    webView.delegate = self;
    webView.scrollView.bounces = NO;
    [webView loadRequest:request];
    [self.view addSubview:webView];
    
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    outBtn.frame = CGRectMake(WIN_WIDTH - 50,22,40, 40);
    outBtn.layer.cornerRadius = outBtn.frame.size.width/2.0;
    outBtn.backgroundColor = RGB(230, 230, 230);
    [outBtn setTitle:@"关闭" forState:UIControlStateNormal];
    outBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [outBtn setTitleColor:RGB(45, 45, 45) forState:UIControlStateNormal];
    [outBtn addTarget:self action:@selector(clickView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:outBtn];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)clickView
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

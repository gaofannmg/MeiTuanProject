//
//  SeachViewController.m
//  MeiTuan
//  搜索VC
//  Created by GaoYong on 15/10/30.
//  Copyright © 2015年 gaofan. All rights reserved.
//

#import "SeachViewController.h"

@interface SeachViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *textField;
}
@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *seachTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    seachTitleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:seachTitleView];
    
//    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeSystem];
//    backBut.backgroundColor = [UIColor whiteColor];
//    backBut.frame = CGRectMake(10, 20, 80, 40);
//    [backBut setTitle:@"返回" forState:UIControlStateNormal];
//    [backBut addTarget:self action:@selector(clickHomeView) forControlEvents:UIControlEventTouchUpInside];
//    [seachTitleView addSubview:backBut];
    
    UIButton *removeBut = [UIButton buttonWithType:UIButtonTypeSystem];
    removeBut.backgroundColor = [UIColor whiteColor];
    removeBut.frame = CGRectMake(self.view.frame.size.width - 90, 20, 80, 40);
    [removeBut setTitle:@"返回" forState:UIControlStateNormal];
    [removeBut addTarget:self action:@selector(clickHomeView) forControlEvents:UIControlEventTouchUpInside];
    [seachTitleView addSubview:removeBut];

    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(90, 20,170, 40)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 20.0;
    textField.layer.borderColor = [[UIColor clearColor] CGColor];
    textField.layer.borderWidth = 0.5;
    textField.placeholder = @"请输入搜索内容";
    textField.textAlignment = UITextAlignmentCenter;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    [seachTitleView addSubview:textField];
    
    UITableView *seachTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(seachTitleView.frame), self.view.frame.size.width, self.view.frame.size.height - seachTitleView.frame.size.height) style:UITableViewStylePlain];
    seachTabView.delegate = self;
    seachTabView.dataSource = self;
    seachTabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seachTabView];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[[UITableViewCell alloc] init];
  
    return  cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [textField resignFirstResponder];
}

- (void) clickHomeView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) clearText
{
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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

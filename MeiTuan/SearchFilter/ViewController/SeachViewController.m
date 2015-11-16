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
    UITextField *searchTextField;
    UITableView *seachTabView;
    
}
@end

@implementation SeachViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *seachTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    seachTitleView.backgroundColor = RGB(248, 111, 93);
    [self.view addSubview:seachTitleView];
  
    UIButton *removeBut = [UIButton buttonWithType:UIButtonTypeSystem];
    removeBut.backgroundColor = [UIColor clearColor];
    [removeBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    removeBut.frame = CGRectMake(WIN_WIDTH - 60, 20, 60, 40);
    [removeBut setTitle:@"取消" forState:UIControlStateNormal];
//    removeBut.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [removeBut addTarget:self action:@selector(clickHomeView) forControlEvents:UIControlEventTouchUpInside];
    [seachTitleView addSubview:removeBut];
    
    UIView *searchBar = [[UIView alloc] initWithFrame:CGRectMake(20, 25, WIN_WIDTH - 10 - removeBut.frame.size.width  - 10, 34)];
    searchBar.layer.masksToBounds = YES;
    searchBar.layer.cornerRadius = 17.0;
    searchBar.backgroundColor = [UIColor whiteColor];
    [seachTitleView addSubview:searchBar];
    
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 0, searchBar.bounds.size.width - 30, searchBar.bounds.size.height)];
    searchTextField.backgroundColor = [UIColor whiteColor];
    searchTextField.placeholder = @"请输入搜索内容";
    searchTextField.textAlignment = NSTextAlignmentLeft;
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.textColor = RGB(100, 100, 100);
    searchTextField.clearButtonMode = UITextFieldViewModeAlways;
    searchTextField.delegate = self;
    searchTextField.clipsToBounds = YES;
    searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    searchTextField.returnKeyType = UIReturnKeySearch;
    [searchTextField addTarget:self  action:@selector(valueChanged:)  forControlEvents:UIControlEventAllEditingEvents];
    [searchBar addSubview:searchTextField];
    
    if(self.seachString.length > 0)
    {
        searchTextField.text = self.seachString;
    }
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, searchBar.frame.size.height/2 - 8, 16, 16)];
    searchImageView.backgroundColor = [UIColor whiteColor];
    searchImageView.image = [UIImage imageNamed:@"icon_search"];
    [searchBar addSubview:searchImageView];
    
    seachTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(seachTitleView.frame), self.view.frame.size.width, self.view.frame.size.height - seachTitleView.frame.size.height) style:UITableViewStylePlain];
    seachTabView.delegate = self;
    seachTabView.dataSource = self;
    seachTabView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:seachTabView];
    seachTabView.hidden = YES;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.view addGestureRecognizer:tapGes];
    
    [searchTextField becomeFirstResponder];
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
//    [searchTextField resignFirstResponder];
    [self.view endEditing:YES];
}

- (void) clickHomeView
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void) endEditing
{
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchTextField resignFirstResponder];
    
    //1.把搜索词传回首页 请求网络 刷新数据
    [self.homeVC searchWithKeyWord:textField.text];
    
    //2.这个页面推出
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    return YES;
}

-(void) valueChanged:(UITextField *) textControl
{
    if (textControl.text.length > 0)
    {
        seachTabView.hidden = NO;
    }
    else
    {
        seachTabView.hidden = YES;
    }
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

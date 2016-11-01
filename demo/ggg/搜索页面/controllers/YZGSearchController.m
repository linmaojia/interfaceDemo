//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGSearchController.h"
#import "JKTextField.h"
#import "YZGProductListlViewVC.h"
@interface YZGSearchController ()<UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, strong) JKTextField *searchBar;    /**< 搜索栏 */
@property (nonatomic, strong) UITableView *tableView;    /**< 历史搜索 */
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) NSMutableArray *historyArray;    /**< 历史搜索记录 */
@property (nonatomic, strong) NSString *searchString;

@end

@implementation YZGSearchController

#pragma mark ************** 懒加载控件
- (JKTextField *)searchBar {
    if (!_searchBar) {
        _searchBar = [[JKTextField alloc] init];
        _searchBar.delegate = self;
        _searchBar.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchBar.backgroundColor = [UIColor whiteColor];
        _searchBar.frame = CGRectMake(0, 0, AUTO_MATE_WIDTH(200), 35);
        _searchBar.placeholder = @"搜索易掌管商品/品牌";
        _searchBar.font = [UIFont systemFontOfSize:14];
        _searchBar.leftViewPadding = 5;
        _searchBar.centerViewPadding = 8;
        _searchBar.layer.cornerRadius = 4;
        _searchBar.tintColor = [UIColor lightGrayColor];
        _searchBar.returnKeyType = UIReturnKeySearch;
        
        UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        searchImage.image = [UIImage imageNamed:@"nav_-search"];
        
        _searchBar.leftView = searchImage;
        _searchBar.backgroundColor = [UIColor colorWithHexColorString:@"EAEAEA"];
        _searchBar.leftViewMode = UITextFieldViewModeAlways;
    }
    return _searchBar;
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headView;
        _tableView.tableFooterView = self.footView;

    }
    return _tableView;
}
- (UIView *)footView
{
    if (!_footView)
    {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _footView.backgroundColor = [UIColor whiteColor];
        UIButton *_deleBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 40, SCREEN_WIDTH - 40, 40)];
        [_deleBtn setTitle:@"清空历史搜索" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _deleBtn.titleLabel.font = systemFont(14);//标题文字大小
        _deleBtn.layer.borderWidth = 0.5;
        _deleBtn.layer.borderColor = RGB(227, 229, 230).CGColor;
        _deleBtn.layer.cornerRadius = 3;
        _deleBtn.layer.masksToBounds = YES;
        [_deleBtn addTarget:self action:@selector(deleBtnClick) forControlEvents:UIControlEventTouchDown];
        [_footView addSubview:_deleBtn];
    }
    return _footView;
}
- (UIView *)headView
{
    if (!_headView)
    {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _headView.layer.borderWidth = 0.5;
        _headView.layer.borderColor = RGB(227, 229, 230).CGColor;
        _headView.backgroundColor = [UIColor whiteColor];
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 40)];
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"历史搜索";
        [_headView addSubview:lab];
    }
    return _headView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getData];
    
    [_searchBar becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_searchBar resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    

}
- (void)getData
{
   self.historyArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"HistorySearch"]];
   [self.tableView reloadData];
}
- (void)rightBarButtonItemClicked
{
    if (self.searchBar.text.length > 0)
    {
        [self.historyArray insertObject:self.searchBar.text atIndex:0];
        if (self.historyArray.count > 10)
        {
            
            for (int i = 0; i < self.historyArray.count - 10; ++i)// 最多保存10条历史记录
            {
                [self.historyArray removeLastObject];
            }
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:@"HistorySearch"];
        
        self.searchString = self.searchBar.text;
        
        self.searchBar.text = @"";
        
        
        [self puchProductListVC];
        
        

    }
    else
    {
         [SVProgressHUD showErrorWithStatus:@"搜索内容不能为空"];
    }
}
#pragma mark ************** 跳转到商品列表页面
- (void)puchProductListVC
{
    YZGProductListlViewVC *showProductVC;
    for (UIViewController *viewVC in self.navigationController.viewControllers)
    {
        if ([viewVC isKindOfClass:[YZGProductListlViewVC class]])
        {
            showProductVC = (YZGProductListlViewVC *)viewVC;
            showProductVC.searchDic = @{@"key":@"input",@"value":self.searchString};
            [self.navigationController popToViewController:showProductVC animated:YES];
            return;
        }
    }
    showProductVC = [[YZGProductListlViewVC alloc] init];
    
    showProductVC.searchDic = @{@"key":@"input",@"value":self.searchString};
    
    [self.navigationController pushViewController:showProductVC animated:YES];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    
    // 导航栏中间搜索框
    self.navigationItem.titleView = self.searchBar;
    //导航栏右边button
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.view.backgroundColor = RGB(235, 235, 241);
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
 
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)deleBtnClick
{
    [self.historyArray removeAllObjects];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:@"HistorySearch"];
    
    [self.tableView reloadData];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self.view addSubview:self.tableView];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
}
#pragma mark ************** 导航栏搜索按钮
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    cell.textLabel.text = self.historyArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.historyArray[indexPath.row];
    
    [self.historyArray insertObject:text atIndex:0];
 
    self.searchString = text;
    
    [self puchProductListVC];
    
}
#pragma mark ************** 点击return 隐藏键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    [self rightBarButtonItemClicked];
    
    return YES;
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end

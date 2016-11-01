//
//  RefundCloseVC.m
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGChooseExpressController.h"
#import "YZGChooseExpressCell.h"
#import "YZGAddExpressController.h"
#import "SVHTTPClient+ExpressLists.h"
#import "YZGExpressModel.h"
#import "YZGEditExpressVC.h"
@interface YZGChooseExpressController ()<UITableViewDelegate, UITableViewDataSource >
{
    
}
@property (nonatomic, strong) NSMutableArray *dataArray;    /**< 数据数组 */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableFootView;

@property (nonatomic, strong) UIButton *chooseButton;   /**< 确定选择 */
@end

@implementation YZGChooseExpressController
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIButton *)chooseButton
{
    
    if(!_chooseButton)
    {
        _chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _chooseButton.titleLabel.font = boldSystemFont(14);
        [_chooseButton setTitle:@"管理物流公司信息" forState:UIControlStateNormal];
        [_chooseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _chooseButton.backgroundColor = mainColor;
        _chooseButton.layer.cornerRadius = 3;
        [_chooseButton addTarget:self action:@selector(chooseButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _chooseButton;
    
}
- (UIView *)tableFootView {
    
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,60)];
        _tableFootView.backgroundColor = RGB(244, 244, 244);
        
        _tableFootView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(footViewClick:)];
        [_tableFootView addGestureRecognizer:tap];
        
        UILabel *titleLab= [[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH,50)];
        titleLab.font = [UIFont systemFontOfSize:16];
        titleLab.text = @"  添加物流公司";
        titleLab.backgroundColor = [UIColor whiteColor];
        titleLab.layer.borderWidth = 0.5;
        titleLab.layer.borderColor = RGB(227, 229, 230).CGColor;
        [_tableFootView addSubview:titleLab];
        
        UIImageView *bracketImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 30, 25, 20,20)];
        bracketImg.image = [UIImage imageNamed:@"right_back"];
        [_tableFootView addSubview:bracketImg];
        
    }
    return _tableFootView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = RGB(244, 244, 244);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[YZGChooseExpressCell class] forCellReuseIdentifier:@"ChooseExpressCell"];
        //分割线不留空白
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
        _tableView.tableFooterView = self.tableFootView;
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self requsetData];//请求数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubViewsForChooseExpress];
    [self addConstraintsForChooseExpress];
    
}
#pragma mark ************** 网络请求数据
- (void)requsetData
{
    
    ESWeakSelf;
    [SVHTTPClient getExpressListsWithTarget:self CallBack:^(NSArray *expressLists) {
        [__weakSelf.dataArray removeAllObjects];
        
        [__weakSelf.dataArray addObjectsFromArray:expressLists];
        [__weakSelf.tableView reloadData];
    }];
    
}
#pragma mark ************** 添加物流点击
-(void)footViewClick:(UITapGestureRecognizer *)sender
{
    YZGAddExpressController *VC = [[YZGAddExpressController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 选择点击
- (void)chooseButtonClick
{
    
    YZGEditExpressVC *VC = [[YZGEditExpressVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}
#pragma mark ************** 自定义方法
- (void)setNav{
    self.title = @"选择物流公司";
    self.view.backgroundColor = RGB(244, 244, 244);
    
    
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
- (void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YZGChooseExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseExpressCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    //判断选中的地址id是否相等
    if([cell.model.logisticsId isEqualToString:self.chooseExpressModel.logisticsId])
    {
        
        cell.isShowGou = YES;
        
    }
    else
    {
        cell.isShowGou = NO;
    }
    return cell;
}

#pragma mark ************** 分割线左边不留空白
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
#pragma mark ************** 选择物流公司
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YZGExpressModel * model = self.dataArray[indexPath.row];
    self.chooseExpressModel = model;
    //[self.tableView reloadData];
    
    //选好的物流地址回调
    if(self.chooseExpress)
    {
        self.chooseExpress(self.chooseExpressModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark ************** 添加视图
- (void)addSubViewsForChooseExpress
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chooseButton];
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForChooseExpress {
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-60));
        
    }];
    [_chooseButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.view).offset(-10);
    }];
    
}



@end

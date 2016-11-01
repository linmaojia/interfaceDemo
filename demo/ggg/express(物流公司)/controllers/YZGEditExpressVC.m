//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGEditExpressVC.h"
#import "YZGAddressModel.h"
#import "YZGAddExpressController.h"
#import "SVHTTPClient+ExpressLists.h"
#import "YZGEditExpressCell.h"
#import "YZGAlertView.h"
#import "YZGAddExpressController.h"
@interface YZGEditExpressVC ()<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataArray;    /**< 数据数组 */
@property (nonatomic, strong) UIButton *addAdderssBtn;      /**< 添加地址按钮 */
@property (nonatomic, strong) UITableView *tableView;       /**< 显示地址TableView */
@property(nonatomic, strong) UILabel *titleLab;   /** 提示 */
@property(nonatomic, strong) UIView *titleView;   /** 提示View */

@end

@implementation YZGEditExpressVC

#pragma mark - 懒加载控件
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UIView *)titleView {
    
    if (!_titleView) {
        _titleView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _titleView.backgroundColor = RGB(247, 247, 247);
        _titleView.hidden = YES;
        [_titleView addSubview:self.titleLab];
    }
    return _titleView;
}
- (UILabel *)titleLab {
    
    if (!_titleLab) {
        _titleLab= [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 50)];
        _titleLab.font = [UIFont systemFontOfSize:12];
        _titleLab.numberOfLines = 0;
        NSString *tagText = @"重要提示：卖家会尽可能满足您指定物流公司的要求，因工厂所在区域各不相同，请下单后与工厂客服确认物流公司。";
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:tagText];
        [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:[tagText rangeOfString:@"重要提示："]];
        _titleLab.attributedText = attrString;
        
    }
    return _titleLab;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGB(247, 247, 247);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YZGEditExpressCell class] forCellReuseIdentifier:@"YZGEditExpressCell"];
        _tableView.tableFooterView = self.titleView;
    }
    return _tableView;
}


- (UIButton *)addAdderssBtn
{
    if(!_addAdderssBtn)
    {
        _addAdderssBtn = [[UIButton alloc]init];
        _addAdderssBtn.titleLabel.font = boldSystemFont(14);
        [_addAdderssBtn setTitle:@"+新曾物流公司" forState:0];
        [_addAdderssBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addAdderssBtn.backgroundColor = mainColor;
        _addAdderssBtn.layer.cornerRadius = 2;
        [_addAdderssBtn addTarget:self action:@selector(addAdderssBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addAdderssBtn;
    
}

#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self requsetData];//请求数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubViewsForEditExpress];
    
    [self addConstraintsForEditExpress];
}

#pragma mark - 自定义方法
- (void)setNav
{
    self.title = @"物流公司管理";
    self.view.backgroundColor = RGB(247, 247, 247);
    
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 网络请求数据
- (void)requsetData
{
    
    ESWeakSelf;
    [SVHTTPClient getExpressListsWithTarget:self CallBack:^(NSArray *adderssLists) {
        
        [__weakSelf.dataArray removeAllObjects];
        
        [__weakSelf.dataArray addObjectsFromArray:adderssLists];
        [__weakSelf.tableView reloadData];
        
        if(adderssLists.count == 0)
        {
            self.titleView.hidden = YES;
        }
        else
        {
            self.titleView.hidden = NO;
        }
    }];
    
}
#pragma mark ************** 添加地址点击方法
- (void)addAdderssBtnClick
{
    YZGAddExpressController *VC = [[YZGAddExpressController alloc]init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 按钮点击回调
- (void)adderssBtnAction:(NSString *)text NSIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    if([text isEqualToString:@"编辑"])
    {
        YZGAddExpressController *vc = [[YZGAddExpressController alloc]init];
        vc.model = self.dataArray[indexPath.section];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([text isEqualToString:@"删除"])
    {
        
        YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定删除改物流公司信息吗"];
        alert.alertNoBlock = ^(){};
        
        alert.alertYesBlock = ^(){
            
            [__weakSelf deleAdderss:indexPath];
        };
    }
    else if([text isEqualToString:@"设为默认"])
    {
        [__weakSelf setDefaultAdderss:indexPath];
        
    }
    
}
#pragma mark ************** 设置默认地址
- (void)setDefaultAdderss:(NSIndexPath *)indexPath
{
    
    ESWeakSelf;
    YZGExpressModel * addressModel = self.dataArray[indexPath.section];
    [SVHTTPClient setDefaultExpressWithAddrId:addressModel.logisticsId  CallBack:^(BOOL defaultReceivingAddressState) {
        if (defaultReceivingAddressState) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [__weakSelf requsetData];//请求数据
                
            });
            
        }
    }];
}
#pragma mark ************** 删除地址
- (void)deleAdderss:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    YZGExpressModel * model = __weakSelf.dataArray[indexPath.section];
    [SVHTTPClient deleteExpressWithAddrId:model.logisticsId CallBack:^(BOOL state) {
        if (state) {
            
            [__weakSelf.dataArray removeObjectAtIndex:indexPath.section];// 删除对应的model
            
            [__weakSelf.tableView reloadData]; // 重新加载tableview
            
            if(__weakSelf.dataArray.count == 0)
            {
                self.titleView.hidden = YES;
            }
            else
            {
                self.titleView.hidden = NO;
            }
        }
    }];
    
}


#pragma mark - tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ESWeakSelf;
    
    YZGEditExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGEditExpressCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.section];
    //按钮点击回调
    cell.AdderssBtnClick = ^(NSString *text,NSIndexPath *index){
        [__weakSelf adderssBtnAction:text NSIndexPath:index];
    };
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//分区尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark ************** 添加视图
- (void)addSubViewsForEditExpress
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addAdderssBtn];
    
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForEditExpress
{
    
    [_addAdderssBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-10);
        make.height.equalTo(@(40));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH));
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.bottom.equalTo(_addAdderssBtn.top).offset(-5);
    }];
}

@end

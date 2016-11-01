//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGUserAddressSettingVC.h"
#import "YZGUserAddressAddVC.h"
#import "YZGUserAdderssSettingCell.h"
#import "YZGAddressModel.h"
#import "SVHTTPClient+AdderssLists.h"
#import "YZGAlertView.h"
#import "SVHTTPClient+DeleteReceivingAddress.h"
#import "SVHTTPClient+DefaultReceivingAddress.h"
@interface YZGUserAddressSettingVC ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;    /**< 数据数组 */
@property (nonatomic, strong) UIButton *addAdderssBtn;      /**< 添加地址按钮 */

@end

@implementation YZGUserAddressSettingVC

#pragma mark - 懒加载控件
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = RGB(247, 247, 247);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YZGUserAdderssSettingCell class] forCellReuseIdentifier:@"YZGUserAdderssSettingCell"];
    }
    return _tableView;
}


- (UIButton *)addAdderssBtn
{
    if(!_addAdderssBtn)
    {
        _addAdderssBtn = [[UIButton alloc]init];
        _addAdderssBtn.titleLabel.font = boldSystemFont(14);
        [_addAdderssBtn setTitle:@"+新建地址" forState:0];
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
    
    [self addSubviewsForAddressSetting];
    
    [self addConstraintsForAddressSetting];
}
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
#pragma mark - 自定义方法
- (void)setNav{
    self.title = @"收货地址管理";
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
    
    
    if(self.isChooseAdderss)
    {
        self.title = @"选择收货地址";
    }
  
}
- (void)backAction{
    
    if(self.isShopCar)//从购物车进来（没有默认地址情况进来）
    {
        BOOL hasDefault = NO;
        //判断有没有默认地址
        for (YZGAddressModel *model in self.dataArray)
        {
            if([model.isDefault isEqualToString:@"1"])
            {
                hasDefault = YES;
            }
        }
        
        //有默认地址
        if(hasDefault)
        {
            if(self.refreshView)
            {
                self.refreshView();//刷新上个控制器
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
        else
        {
            [self alert];
        }

    }
    else
    {
      [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
   
}
#pragma mark ************** 提醒框
-(void)alert {
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"你没有设置默认地址" message:@"请点击添加" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark ************** 网络请求数据
- (void)requsetData
{
    
     ESWeakSelf;
    [SVHTTPClient getAdderssListsWithTarget:self CallBack:^(NSArray *adderssLists) {
        
        [__weakSelf.dataArray removeAllObjects];
        
        [__weakSelf.dataArray addObjectsFromArray:adderssLists];
        [__weakSelf.tableView reloadData];
    }];
    
}
#pragma mark ************** 添加地址点击方法
- (void)addAdderssBtnClick
{
    YZGUserAddressAddVC *informationSettiingVc = [[YZGUserAddressAddVC alloc]init];
    [self.navigationController pushViewController:informationSettiingVc animated:YES];
}
#pragma mark ************** 按钮点击回调
- (void)adderssBtnAction:(NSString *)text NSIndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    if([text isEqualToString:@"编辑"])
    {
       YZGUserAddressAddVC *informationSettiingVc = [[YZGUserAddressAddVC alloc]init];
       informationSettiingVc.model = self.dataArray[indexPath.section];
       [self.navigationController pushViewController:informationSettiingVc animated:YES];
    }
    else if([text isEqualToString:@"删除"])
    {
        YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定删除收货地址吗"];
        alert.alertNoBlock = ^(){};
        alert.alertYesBlock = ^(){
            
            [__weakSelf deleAdderss:indexPath];
        };
    }
    else if([text isEqualToString:@"设为默认"])
    {
   
        [self setDefaultAdderss:indexPath];
    }
 
}
#pragma mark ************** 设置默认地址
- (void)setDefaultAdderss:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    YZGAddressModel * addressModel = self.dataArray[indexPath.section];
    [SVHTTPClient setDefaultReceivingAddressWithAddrId:addressModel.deliverId  CallBack:^(BOOL defaultReceivingAddressState) {
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
    YZGAddressModel * model = self.dataArray[indexPath.section];
    [SVHTTPClient deleteReceivingAddressWithAddrId:model.deliverId CallBack:^(BOOL deleteReceivingAddressState) {
        if (deleteReceivingAddressState) {
            
            [__weakSelf.dataArray removeObjectAtIndex:indexPath.section];// 删除对应的model

            [__weakSelf.tableView reloadData];  // 重新加载tableview
        }
    }];

}


#pragma mark ************** tableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
      return 145;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ESWeakSelf;
    YZGUserAdderssSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGUserAdderssSettingCell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.isChooseAdderss = self.isChooseAdderss;
    cell.model = self.dataArray[indexPath.section];
    
    //按钮点击回调
    cell.AdderssBtnClick = ^(NSString *text,NSIndexPath *index){
        [__weakSelf adderssBtnAction:text NSIndexPath:indexPath];
    };
    
    //判断选中的地址id是否相等
    if([cell.model.deliverId isEqualToString:self.chooseAddress.deliverId])
    {
        cell.isShowColourPicture = YES;
    }
    else
    {
         cell.isShowColourPicture = NO;
    }
    
    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断是从购物车进来
    if(self.isChooseAdderss)
    {
        if(self.adderssModel)
        {
            //把选择的地址模型传递回去
            self.adderssModel(self.dataArray[indexPath.section]);
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
 
    
}
#pragma mark ************** 分区尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
#pragma mark ************** 分区头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForAddressSetting
{
    [self.view addSubview:self.addAdderssBtn];
    [self.view addSubview:self.tableView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForAddressSetting
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

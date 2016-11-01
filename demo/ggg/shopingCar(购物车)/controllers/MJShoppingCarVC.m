//
//  MyShoppingCarController.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJShoppingCarVC.h"
#import "MJShoppingCarCell.h"
#import "MJShoppingCarModel.h"
#import "MJShoppingCarHeaderView.h"
#import "MJShoppingCarBottomView.h"

#import "SVHTTPClient+ShoppingCarList.h"
#import "SVHTTPClient+ShoppingCarDelete.h"
#import "SVHTTPClient+ShoppingCarAddCollect.h"
#import "SVHTTPClient+ShoppingCarDeleArray.h"
#import "YZGConfirmOrderVC.h"
#import "YZGAlertView.h"
#import "SVHTTPClient+ShoppingCarCountChange.h"
//#import "YZGTabBarControllerConfig.h"
//#import "YZGProductDetailViewController.h"
#import "SVHTTPClient+ShoppingCarCount.h"
#import "YZGRemarksView.h"
#import "SVHTTPClient+ShoppingCarRemark.h"
#import "ViewController.h"
#import "YZGShoppingCarManager.h"
@interface MJShoppingCarVC ()<UITableViewDelegate, UITableViewDataSource, CellDelegate, SectionHeaderViewDelegate, BottomViewDelegate>
{
    BOOL isEdit;  /**< 是否编辑状态*/
    UIBarButtonItem * editItem;
}
@property (nonatomic, strong) UITableView *tableView;    /**< RootTableView */
@property (nonatomic, strong) MJShoppingCarBottomView *bottomView;    /**< 视图下方的View */
@property (nonatomic, strong) NSMutableArray *dataArray;    /**< 数据数组 */
@property (nonatomic, assign) BOOL isShowEditBtn;    /**< 是否显示编辑按钮 */
@property (nonatomic, strong) YZGShoppingCarManager *manager;   /**< 判断点击某个状态 */

@end

@implementation MJShoppingCarVC

#pragma mark ************** 懒加载控件
- (YZGShoppingCarManager *)manager {
    if (!_manager) {
        _manager = [[YZGShoppingCarManager alloc]init];
    }
    return _manager;
}
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB(250, 250, 250);
        [_tableView registerClass:[MJShoppingCarCell class] forCellReuseIdentifier:@"MJShoppingCarCell"];
        [_tableView registerClass:[MJShoppingCarHeaderView class] forHeaderFooterViewReuseIdentifier:@"MJShoppingCarHeaderView"];
    }
    return _tableView;
}
- (MJShoppingCarBottomView *)bottomView {
    
    if (!_bottomView) {
        ESWeakSelf;
        _bottomView = [[MJShoppingCarBottomView alloc] init];
        _bottomView.delegate = self;
        _bottomView.hidden = YES;
        _bottomView.deleClickBlock = ^(NSString *title){
             [__weakSelf editWithdeleClickAction:title];
        };
    }
    return _bottomView;
}

#pragma mark ************** 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
   [super viewWillAppear:animated];
    
   [self requestData];//请求数据
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViewsForShoppingCar];
    
    [self addConstraintsForShoppingCar];
    
    [self setNav];//设置导航栏
}

#pragma mark ************** 设置导航栏
- (void)setNav {
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"采购单";
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithHexColorString:@"333333"], nil, nil] forKeys:[NSArray arrayWithObjects:NSForegroundColorAttributeName, nil, nil]];
    self.navigationController.navigationBar.titleTextAttributes = dic;
    

    if(self.isShowBack)
    {
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
   
}
#pragma mark ************** 设置编辑按钮
- (void)setIsShowEditBtn:(BOOL)isShowEditBtn
{
    //导航栏右边button
    if(isShowEditBtn)
    {
        editItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemClicked:)];
        self.navigationItem.rightBarButtonItem = editItem;
    }
    else
    {
        editItem.title = @"";
    }
}
#pragma mark ************** 更换编辑按钮文字
- (void)rightBarButtonItemClicked:(id *)sender {
    isEdit = !isEdit;
    
    if (isEdit)
    {
        
        [editItem setTitle:@"完成"];
    }
    else
    {
        [editItem setTitle:@"编辑"];
        
    }
    self.bottomView.isEdit = isEdit;
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 请求数据
- (void)requestData
{
    ESWeakSelf;
    [SVHTTPClient getShoppingCarListWithTarget:self CallBack:^(NSArray *shoppingCarListArray) {
        if(shoppingCarListArray.count == 0)
        {
            __weakSelf.isShowEditBtn = NO;//隐藏编辑按钮
        }
        else
        {
            
            __weakSelf.bottomView.hidden = NO;//显示底部
            
            __weakSelf.isShowEditBtn = YES;//显示编辑按钮
            
            [__weakSelf.dataArray removeAllObjects];
            
            [__weakSelf.dataArray addObjectsFromArray:shoppingCarListArray];
            
            [__weakSelf.tableView reloadData];
            
            __weakSelf.manager.dataArray = __weakSelf.dataArray;
           
        }

    }];
    
}
#pragma mark ************** 移入收藏，删除点击事件
- (void)editWithdeleClickAction:(NSString *)text{
    if([text isEqualToString:@"删除"])
    {
        NSLog(@"----%@",text);
        [self shoppingDeleWithArray];
    }
    else if([text isEqualToString:@"移入收藏"])
    {
        NSLog(@"----%@",text);
        [self shoppingCollectWithArray];//移入收藏方法
    }
}
#pragma mark ************** 删除购物车（数组）
- (void)shoppingDeleWithArray{

    NSMutableArray *cartIdArray = [_manager getCarIDArray];
    
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定删除所选商品吗"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        ESWeakSelf;
        [SVHTTPClient shoppingDeleWithCartIds:cartIdArray callBack:^(BOOL deleArrayState) {
            if(deleArrayState)
            {
              
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [__weakSelf requestData];
                    
                    [__weakSelf setShoppingCarBadge];//修改购物车数量
                    
                    __weakSelf.bottomView.isSetZero = YES;//底部归0
                    
                });
               
            }
        }];
    };
    
}
#pragma mark ************** 移入收藏方法（数组）
- (void)shoppingCollectWithArray{
    
    NSMutableArray *productIDArray = [_manager getProductIDArray];
    
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定收藏所选商品吗"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        [SVHTTPClient shoppingCollectWithProductIds:productIDArray callBack:^(BOOL addCollectState) {
            if(addCollectState){}
        }];
    };
    
}
#pragma mark ************** 修改购物车数量
- (void)setShoppingCarBadge {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [SVHTTPClient shoppingCarCountCallBack:^(int count) {
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:addShoppingCarNotification object:nil userInfo:@{@"count":@(count)}];
        }];
        
    });
}
#pragma mark ************** ShoppingCarCell 代理方法
#pragma mark ************** Cell上的选择按钮被点击
- (void)CellSelectBtnAction:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath
{
    
    MJShoppingCarModel *shopModel = _dataArray[indexPath.section];
    Products *product = shopModel.products[indexPath.row];
    product.select = isSelect;
  
    [self isSectionSelectAction:shopModel];//判断分区头按钮是否要选中
    [self isAllSelectAction];//判断是否全选
    [self ChangePrice];//更新总价格
    
}
#pragma mark ************** 更新分区头
- (void)isSectionSelectAction:(MJShoppingCarModel *)shopModel
{
    BOOL isSectionSelect = YES;//是否分区头全选
    
    for(Products * Model in shopModel.products)
    {
        if(!Model.select)
        {
            isSectionSelect = NO;//说明该区还有商品没选中
        }
    }
    
    shopModel.select = isSectionSelect;
    
    [self.tableView reloadData];
    
}
#pragma mark ************** 更新全选按钮
- (void)isAllSelectAction {
    
    
    BOOL isAllSelect = YES;//判断是否全选
    
    for(MJShoppingCarModel *shopModel in _dataArray)
    {
        if(!shopModel.select)
        {
            isAllSelect = NO;//说明还有分区没有被选中
        }
    }
    
    self.bottomView.checkAllBtn.selected = isAllSelect;
    
}
#pragma mark ************** 更新价格
- (void)ChangePrice{
    

    CGFloat totalPrices = 0.f; //总价格
    NSInteger totalCount = 0; //总数量
    
    for(MJShoppingCarModel *brandModel in self.dataArray)
    {
        for(Products *product in brandModel.products)
        {
            if(product.select)
            {
                ProductDetail *productDetail = product.productDetail;
                totalPrices += product.productQty *productDetail.dealerPurchasePrice;
                totalCount  += product.productQty;
            }
        }
    }
    //更新底部价格视图
    [self.bottomView BottomChangeWithTotalPrices:totalPrices TotalCount:totalCount];
    
}


#pragma mark ************** 数量增加、减少按钮方法
- (void)CellAddBtnAction:(NSInteger)count IndexPath:(NSIndexPath *)indexPath{
    
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
    Products *goodModel = shopModel.products[indexPath.row];
    
    ProductDetail *productDetail = goodModel.productDetail;
    
    ESWeakSelf;
    [SVHTTPClient shoppingCarCountChangeWithCarId:productDetail.seqid productQty:count callBack:^(BOOL shoppingCarCountChangeState) {
        
        if(shoppingCarCountChangeState)
        {
              goodModel.productQty = count;
            [__weakSelf.tableView reloadData];
            [__weakSelf ChangePrice];//更新总价格
        }
       
    }];
  
}

#pragma mark ************** TextFile修改数量
- (void)CellCountTfAction:(NSInteger)count IndexPath:(NSIndexPath *)indexPath
{

    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
    Products *goodModel = shopModel.products[indexPath.row];
    
    ProductDetail *productDetail = goodModel.productDetail;
    ESWeakSelf;
    [SVHTTPClient shoppingCarCountChangeWithCarId:productDetail.seqid productQty:count callBack:^(BOOL shoppingCarCountChangeState) {
        
        if(shoppingCarCountChangeState)
        {
            goodModel.productQty = count;
            [__weakSelf.tableView reloadData];
            [__weakSelf ChangePrice];//更新总价格
        }
        else
        {
            //失败
             goodModel.productQty = 1;
            [__weakSelf.tableView reloadData];
        }
    }];

}
#pragma mark ************** 备注点击事件
- (void)RemarksBtnAction:(NSIndexPath *)indexPath RemarkText:(NSString *)remarkText
{
    ESWeakSelf;
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
    Products *products = shopModel.products[indexPath.row];
    
    [YZGRemarksView showRemarksViewWithTitle:products.productDesc PlacehoderText:@"请输商品备注" ConfirmBlock:^(NSString *text) {
        
        [__weakSelf changeRemarksText:text IndexPath:indexPath];
    } CancelBlock:^{}];
}
#pragma mark ************** 修改备注信息
- (void)changeRemarksText:(NSString *)text IndexPath:(NSIndexPath *)indexPath
{
    ESWeakSelf;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //网络请求
        MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
        Products *products = shopModel.products[indexPath.row];
        NSString *carId = products.cartId;
        NSDictionary *dic = @{@"cartId":carId,@"productDesc":text};
        [SVHTTPClient shoppingRemarkWithProductIds:dic callBack:^(BOOL stase) {
            if(stase)
            {
                MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
                Products *products = shopModel.products[indexPath.row];
                products.productDesc = text;
                
                [__weakSelf.tableView reloadData];
            }
            
        }];
        
    });
    
}
#pragma mark ************** 全选按钮点击方法
- (void)BottomViewCheckAllAction:(BOOL)isCheckAll{
    
    for(MJShoppingCarModel *shopModel in _dataArray)
    {
        shopModel.select = isCheckAll;
        
        for(Products *goodModel in shopModel.products)
        {
            goodModel.select = isCheckAll;
        }
    }
    
    [self.tableView reloadData];
    [self ChangePrice];//更新总价格
}

#pragma mark ************** 结算按钮方法
- (void)BottomViewSettlementBtnAction
{
    BOOL isStock = [_manager isStocksInsufficient];//判断是否存在库存不足
    
    if(isStock)
    {
        self.bottomView.isSetZero = YES;
        
        YZGConfirmOrderVC *VC = [[YZGConfirmOrderVC alloc]init];//跳转到下个页面
        VC.dataArray = [_manager updateDataArray];//清除没有选中的数据
        [self.navigationController pushViewController:VC animated:YES];

    }
    else
    {
        [SVProgressHUD showErrorWithStatus:@"个别商品库存不足"];
    }
    
}
#pragma mark ************** 跳转到首页
- (void)PushHomeViewController
{
    [self.navigationController.tabBarController setSelectedIndex:0];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //配置tabBarController
    [window setRootViewController:self.navigationController.tabBarController];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark ************** 分区头按钮被点击
- (void)shoppingCarHeaderViewSelectButtonClicked:(BOOL)isSelect section:(NSInteger)section
{
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[section];
    shopModel.select = isSelect;
    //添加移除数据
    for(Products * Model in shopModel.products){
        
        Model.select = isSelect;
    }
    [self.tableView reloadData];
    [self isAllSelectAction];//判断是否全选
    [self ChangePrice];//更新总价格
}

#pragma mark ************** tableview代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[section];
    return shopModel.products.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

/* Cell显示*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MJShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MJShoppingCarCell" forIndexPath:indexPath];
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)self.dataArray[indexPath.section];
    cell.model = shopModel.products[indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;

    return cell;
   
}
/* 分区头部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
/* 分区头部显示*/
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    MJShoppingCarHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MJShoppingCarHeaderView"];
    if(!headerView)
    {
        headerView = [[MJShoppingCarHeaderView alloc] initWithReuseIdentifier:@"MJShoppingCarHeaderView"];
    }
    headerView.shopModel = _dataArray[section];
    headerView.section = section;
    headerView.delegate = self;
    return headerView;
}
/* cell 点击事件*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.bottomView.isSetZero = YES;
    
    ViewController *view = [[ViewController alloc]init];
    
    [self.navigationController pushViewController:view animated:YES];
}
/* 分区尾部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
/* 添加删除效果*/
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
    Products *goodModel = shopModel.products[indexPath.row];
    
    //删除按钮
    ESWeakSelf;
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        
        YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定删除该商品吗"];
        alert.alertNoBlock = ^(){};
        alert.alertYesBlock = ^(){
            
            [SVHTTPClient shoppingCarDeleteWithProductId:goodModel.cartId callBack:^(BOOL shoppingCarDeleteState) {
                if(shoppingCarDeleteState)
                {
                    [shopModel.products removeObject:goodModel];
                    if(shopModel.products.count == 0)
                    {
                        //如果分区为空，移除分区
                        [__weakSelf.dataArray removeObject:shopModel];
                    }
                    [__weakSelf.tableView reloadData];//跟新UI
                    
                    [__weakSelf ChangePrice];//更新总价格
                    [__weakSelf setShoppingCarBadge];//修改购物车数量
                    //如果数组为空的，显示空视图
                    if(__weakSelf.dataArray.count == 0)
                    {
                        __weakSelf.isShowEditBtn = NO;
                        
                        [__weakSelf.view showEmptyViewWithtype:EmptyViewTypeEmptyData IsOrder:NO refresh:^{
                            
                            [__weakSelf.view removeEmptyView];
                            [__weakSelf PushHomeViewController];
                            
                        }];
                    }
                    
                    
                }
            }];
            
        };
        
    }];
    //收藏按钮
    UITableViewRowAction *collectRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath){
        //网络请求
        [SVHTTPClient shoppingCollectWithProductIds:@[goodModel.productID] callBack:^(BOOL addCollectState) {
            if(addCollectState){
            }
        }];
        
    }];
    //返回按钮数组
    return @[deleteRowAction,collectRowAction];
}

#pragma mark ************** 添加视图
- (void)addSubViewsForShoppingCar
{
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.tableView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForShoppingCar
{
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.equalTo(@(60));
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(_bottomView.top);
    }];
}


@end

//
//  YZGMyCollectViewController.m
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGMyCollectViewController.h"
#import "MJRefresh.h"
#import "SVHTTPClient+CollectList.h"
#import "SVHTTPClient+CollectCancel.h"
#import "SVHTTPClient+Explosion.h"
#import "YZGMyCollecProductModel.h"
#import "SVHTTPClient+ShoppingCarAdd.h"
#import "YZGOrderButtonView.h"
#import "YZGCollectManager.h"
#import "KViewController.h"
#import "YZGShoppingCarView.h"
#import "MJShoppingCarVC.h"
@interface YZGMyCollectViewController ()
{
    UIImageView *imageView;
}
@property (nonatomic, strong) UIView *currentView;            /**<  视图容器 */
@property (nonatomic, strong) YZGOrderButtonView *titleView;        /**< 导航栏按钮 */
@property (nonatomic, strong) YZGCollectManager *manager;
@property (nonatomic, strong) NSMutableArray *productArray;      /**< 商品数组 */
@property (nonatomic, strong) NSMutableArray *shopArray;          /**< 店铺数组 */
@property (nonatomic, strong) NSMutableArray *hotArray;          /**< 爆款推荐 */
@property (nonatomic, assign) BOOL isLoadHotProduct;   /**< 是否加载热门产品 */
@property (nonatomic, assign) NSInteger pageNum;                /**<  商品page*/
@property (nonatomic, assign) NSInteger pageShopNum;
@property (nonatomic, assign) NSInteger pageHotNum;
@property (nonatomic, assign) NSInteger carCount;
@property (nonatomic, strong) YZGShoppingCarView *carView;          /**< 购物车按钮 */


@end

@implementation YZGMyCollectViewController

- (UIView *)currentView {
    if (!_currentView) {
        _currentView = [[UIView alloc] init];
    }
    return _currentView;
}
- (YZGShoppingCarView *)carView {
    if (!_carView) {
        ESWeakSelf;
        _carView = [[YZGShoppingCarView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 150, 40, 40)];
        _carView.hidden = YES;
        _carView.carButtonClick = ^(){
            [__weakSelf puchShoppingCarVC];
            
        };
    }
    return _carView;
}
- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        _hotArray = [NSMutableArray array];
    }
    return _hotArray;
}
- (YZGCollectManager *)manager {
    if (!_manager) {
        _manager = [[YZGCollectManager alloc]init];
    }
    return _manager;
}
- (YZGMyCollectShopView *)shopTableView
{
    if (_shopTableView == nil)
    {
        ESWeakSelf;
        _shopTableView = [[YZGMyCollectShopView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadShopData)];
        _shopTableView.mj_footer = footer;
        _shopTableView.reloadDataClick = ^(BOOL isShowSV){
            
            __weakSelf.pageShopNum = 1;
            
            [__weakSelf getShopDataWithPageNum:1];
        };
        _shopTableView.cellClick = ^(NSIndexPath *indexPath){
               NSLog(@"---%@",indexPath);
        };
        
    }
    return _shopTableView;
    
}
- (YZGMyCollectProduductView *)productTableView
{
    if (_productTableView == nil)
    {
        ESWeakSelf;
        _productTableView = [[YZGMyCollectProduductView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _productTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            __weakSelf.isLoadHotProduct?[__weakSelf loadHotData]:[__weakSelf loadProductData];
          
        }];
        _productTableView.sameBtnClickBlack = ^(NSString *productId){
            [__weakSelf sameBtnClickAction:productId];
        };
        _productTableView.carBtnClickBlack = ^(NSString *productId,UIImageView *productImg){
            [__weakSelf carBtnClickAction:productId ImageView:productImg];
        };
        _productTableView.cellClickBlack = ^(NSString *productId){
            [__weakSelf productCellClickAction:productId];
        };
        _productTableView.puchHomeVCBlack = ^(){
            [__weakSelf puchHomeVCAction];
        };
        _productTableView.hotCellClick = ^(NSString *productId){
            NSLog(@"---%@",productId);
        };
        _productTableView.reloadDataClick = ^(BOOL isShowSV){
            
            __weakSelf.pageNum = 1;
            
            __weakSelf.isLoadHotProduct = NO;
            
            [__weakSelf getDataWithPageNum:1];
            
        };
        

    }
    return _productTableView;
}

- (YZGOrderButtonView *)titleView {
    if (!_titleView) {
        ESWeakSelf;
        _titleView = [[YZGOrderButtonView alloc] initWithFrame:CGRectMake(0, 0, 54*2, 44)];
        _titleView.buttonArray = @[@"商品", @"店铺"];
        _titleView.index = self.collectType;
        _titleView.orderButtonClick = ^(NSInteger collectType)
        {
            [__weakSelf selectCollectType:collectType];//切换视图
            
        };
    }
    return _titleView;
}

- (void)selectCollectType:(NSInteger)collectType
{
    
    self.collectType = collectType;
    
    if(collectType == product)
    {
        
      [self.currentView bringSubviewToFront:self.productTableView];
        
        if(!self.productArray)
        {
            [self getDataWithPageNum:_pageNum];
        }
       
    }
    else if(collectType == shop)
    {
      [self.currentView bringSubviewToFront:self.shopTableView];
        
      if(!self.shopArray)
      {
        [self getShopDataWithPageNum:_pageShopNum];
      }
        
    }
    
    
}
#pragma mark ************** 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    _pageNum = 1;
    
    _pageShopNum = 1;
    
    self.isLoadHotProduct = NO;
    
    if(self.collectType == product)
    {
        [self getDataWithPageNum:_pageNum];
    }
    else if(self.collectType == shop)
    {
        [self getShopDataWithPageNum:_pageShopNum];
    }
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];

    [self addSubviewsForCollectView];
    
    [self addConstraintsForCollectView];

}
#pragma mark ************** 设置导航栏
- (void)setNav{
    
    
    self.navigationItem.titleView =self.titleView;
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
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 跳转到品牌大全
- (void)PushHomeViewController
{
    KViewController *vc = [[KViewController alloc]init];
    vc.index = 3;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ************** 上拉加载品牌数据
- (void)loadShopData
{
    _pageShopNum++;
    
    [self getShopDataWithPageNum:_pageShopNum];
}
- (void)getShopDataWithPageNum:(NSInteger)pageNum
{
     ESWeakSelf;
    [self.manager getCollectShopArrayWithPageNum:pageNum target:self CallBack:^(NSArray *collectShopArray) {
        
        if(!__weakSelf.shopArray)
        {
           __weakSelf.shopArray = [NSMutableArray array];
        }
        
        if(pageNum == 1)
        {
            [__weakSelf.shopArray removeAllObjects];//移除之前的数据
        }
        
        [__weakSelf.shopTableView.mj_footer endRefreshing];
        
        [__weakSelf.shopArray addObjectsFromArray:collectShopArray];
        
        __weakSelf.shopTableView.shops = __weakSelf.shopArray;
        
        if(collectShopArray.count == 0)
        {
            [__weakSelf.shopTableView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
    }];
}
#pragma mark ************** 上拉加载商品数据
- (void)loadProductData
{
    _pageNum++;
    
    [self getDataWithPageNum:_pageNum];
}
- (void)getDataWithPageNum:(NSInteger)pageNum
{
    ESWeakSelf;
   [self.manager getCollectProductArrayWithPageNum:_pageNum target:self CallBack:^(NSArray *collectProductArray) {
       
       if(!__weakSelf.productArray)
       {
           __weakSelf.productArray = [NSMutableArray array];
       }
       
       if(pageNum == 1)
       {
           [__weakSelf.productArray removeAllObjects];//移除之前的数据
           
           [__weakSelf.hotArray removeAllObjects];
           
           __weakSelf.productTableView.hotArray = __weakSelf.hotArray;
       }
      
         [__weakSelf.productTableView.mj_footer endRefreshing];
       
         [__weakSelf.productArray addObjectsFromArray:collectProductArray];
       
         __weakSelf.productTableView.products = __weakSelf.productArray;
       
       if(collectProductArray.count < 10)
       {
           __weakSelf.isLoadHotProduct = YES;
           
           __weakSelf.pageHotNum = 0;
           
           [__weakSelf loadHotData];//加载爆款推荐
       }
       
       
       
   }];
}
#pragma mark ************** 获取爆款推荐
- (void)loadHotData{
    
    _pageHotNum++;
    
    NSDictionary *params = @{@"rowsPerPage":@"10",@"pageNumber":@(_pageHotNum)};
    ESWeakSelf;
    
    [SVHTTPClient getOrderListWithParams:params CallBack:^(NSArray *explosionArray) {
    
        [__weakSelf.hotArray addObjectsFromArray:explosionArray];
        
        __weakSelf.productTableView.hotArray = __weakSelf.hotArray;
        
        [__weakSelf.productTableView.mj_footer endRefreshing];//结束转圈
        
        if(explosionArray.count == 0)
        {
            [__weakSelf.productTableView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
        
    }];

}
#pragma mark ************** 商品Cell代理
#pragma mark ************** 同系列点击
- (void)sameBtnClickWithProductId:(NSString *)productId
{
    NSLog(@"%@",productId);
  
}
#pragma mark ************** 同类推荐
- (void)sameBtnClickAction:(NSString *)productID
{
    KViewController *vc = [[KViewController alloc]init];
    vc.index = 3;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ************** 加入购物车
- (void)carBtnClickAction:(NSString *)productID ImageView:(UIImageView *)productImg
{
    ESWeakSelf;
    _carView.hidden = NO;
    
    NSDictionary *dic = @{@"seqId":productID};
    [SVHTTPClient shoppingCarAddWithDic:dic callBack:^(BOOL state,int count) {
        if(state)
        {
            __weakSelf.carCount = count;
            [__weakSelf.manager animationAction:productImg selfView:__weakSelf.view CarView:__weakSelf.carView CarCount:count];//动画效果
        }
        
    }];
}
#pragma mark ************** 商品cell点击
- (void)productCellClickAction:(NSString *)productID
{
    NSLog(@"%@",productID);
}
#pragma mark ************** 回到首页
- (void)puchHomeVCAction
{
    KViewController *vc = [[KViewController alloc]init];
    vc.index = 3;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ************** 推送到购物车界面
- (void)puchShoppingCarVC
{
    MJShoppingCarVC *VC = [[MJShoppingCarVC alloc]init];
    VC.isShowBack = YES;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCollectView
{
    
     [self.view addSubview:self.currentView];
     [self.view addSubview:self.carView];

     [self.currentView addSubview:self.productTableView];
     [self.currentView addSubview:self.shopTableView];

    if(self.collectType == product)
    {
       [self.currentView bringSubviewToFront:self.productTableView];
    }
    else if(self.collectType == shop)
    {
       [self.currentView bringSubviewToFront:self.shopTableView];
    }
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForCollectView
{
    [_currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_productTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_currentView);
    }];
    [_shopTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_currentView);
    }];
}


@end

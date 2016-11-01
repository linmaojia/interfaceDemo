//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderViewController.h"
#import "HMSegmentedControl.h"
#import "YZGOrderCell.h"
#import "YZGOrderModel.h"
#import "YZGOrderFootView.h"
#import "YZGOrderHeadView.h"
#import "YZGOrderDetailsController.h"
#import "YZGOrderManager.h"
#import "YZGAlertView.h"
//#import "YZGShopInformationViewController.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "SVHTTPClient+PayPort.h"
#import "YZGPayFinishViewController.h"
#import "SVHTTPClient+OrderCancel.h"
#import "SVHTTPClient+OrderDelete.h"
#import "SVHTTPClient+OrderConfirm.h"
#import "SVHTTPClient+OrderAddShoppingCar.h"
//#import "YZGTabBarControllerConfig.h"
#import "MJShoppingCarVC.h"
static float const CELL_HEIGHT = 85;  /**< cell高度 */
static float const FOOT_HEIGHT = 80;  /**< 分区尾部高度 */
static float const HEAD_HEIGHT = 50;  /**< 分区头部高度 */
@interface YZGOrderViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger _pageNum;   /**< 分页 */
}
@property (nonatomic, strong) HMSegmentedControl *orderSegmentedControl;    /**< 订单分段控制器 */
@property (nonatomic, assign) OrderType orderType;                          /**< 订单类型 */
@property (nonatomic, strong) NSMutableArray *dataArray;                    /**< cell标题数组 */
@property (nonatomic, assign) NSInteger index;   /**< 判断点击某个状态 */
@property (nonatomic, strong) YZGOrderManager *manager;   /**< 判断点击某个状态 */

@end

@implementation YZGOrderViewController

#pragma mark ************** 懒加载控件
- (YZGOrderManager *)manager {
    if (!_manager) {
        _manager = [[YZGOrderManager alloc]init];
    }
    return _manager;
}
- (UITableView *)rootTableView {
    
    if (!_rootTableView) {
        ESWeakSelf;
        _rootTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rootTableView.backgroundColor = RGB(247, 247, 247);
        _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分割线
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
       [_rootTableView registerClass:[YZGOrderCell class] forCellReuseIdentifier:@"yzgOrderCell"];
        [_rootTableView registerClass:[YZGOrderFootView class] forHeaderFooterViewReuseIdentifier:@"yzgOrderFootView"];
        [_rootTableView registerClass:[YZGOrderHeadView class] forHeaderFooterViewReuseIdentifier:@"yzgOrderHeadView"];
        _rootTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [__weakSelf loadMoreData];
        }];
 
    }
    return _rootTableView;
}
- (HMSegmentedControl *)orderSegmentedControl {
    
    if (!_orderSegmentedControl) {
        _orderSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"全部", @"待付款", @"待发货", @"待收货", @"已完成", @"已取消"]];
        _orderSegmentedControl.backgroundColor = RGB(245, 247, 249);
        _orderSegmentedControl.layer.borderWidth = 0.5;
        _orderSegmentedControl.layer.borderColor = RGB(227, 229, 230).CGColor;
        _orderSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _orderSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        _orderSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        _orderSegmentedControl.selectionIndicatorColor = RGB(38, 66, 136);
        _orderSegmentedControl.selectedSegmentIndex = self.orderType;
        _orderSegmentedControl.segmentEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [_orderSegmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = nil;
            if (selected) {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : RGB(38, 66, 136),NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            } else {
                attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor blackColor],NSFontAttributeName : [UIFont systemFontOfSize:14.0f]}];
            }
            return attString;
        }];
        [_orderSegmentedControl addTarget:self action:@selector(orderSegmentedIndexChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _orderSegmentedControl;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

#pragma mark ************** 系统方法
- (instancetype)initWithOrderType:(OrderType)orderType{
    if (self = [super init]) {
        self.orderType = orderType;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
     _pageNum = 1;
   
    [self getDataWithPageNum:_pageNum];  //请求数据
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForOrderList];//控件布局

}

#pragma mark ************** 设置导航栏
- (void)setNav{
    self.title = @"我的订单";
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
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}
- (void)backAction{
    BOOL isShopingCar = NO;
    for (UIViewController *vc in self.navigationController.viewControllers) {
        //返回到购物车界面
        if ([vc isKindOfClass:[MJShoppingCarVC class]]) {
            isShopingCar = YES;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
    if(!isShopingCar)
    {
        //非购物车进来
        [self.navigationController popViewControllerAnimated:YES];
    }
   
}

#pragma mark ************** 上拉加载更多数据
- (void)loadMoreData
{
   _pageNum++;
   [self getDataWithPageNum:_pageNum];
    

}
#pragma mark ************** 跳转到首页
- (void)PushHomeViewController
{
   
    
    [self.navigationController popViewControllerAnimated:YES];
    /*
    [self.navigationController.tabBarController setSelectedIndex:0];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //配置tabBarController
    [window setRootViewController:self.navigationController.tabBarController];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
     
     */
}
- (void)dealloc
{

}
#pragma mark ************** 请求数据
- (void)getDataWithPageNum:(NSInteger)pageNum {

    
    ESWeakSelf;
    [self.manager getOrderListWithPageNum:pageNum orderStatus:_orderSegmentedControl.selectedSegmentIndex target:self CallBack:^(NSArray *orderCarListArray) {
        
        if(pageNum == 1)
        {
            [__weakSelf.dataArray removeAllObjects];//移除之前的数据
        }
        
        if(_orderSegmentedControl.selectedSegmentIndex != __weakSelf.index)
        {
              [__weakSelf.dataArray removeAllObjects];//移除之前的数据
        }
       
    
        [__weakSelf.dataArray addObjectsFromArray:orderCarListArray];
        
        [__weakSelf.rootTableView reloadData];
        
        __weakSelf.index = _orderSegmentedControl.selectedSegmentIndex;
        
        [__weakSelf.rootTableView.mj_footer endRefreshing];
        if(orderCarListArray.count == 0)
        {
            [__weakSelf.rootTableView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
 
    }];
    
    
    
}

#pragma mark ************** 分栏控制器选择方法
- (void)orderSegmentedIndexChange:(HMSegmentedControl *)seg{
    
     _pageNum = 1;
    [self.rootTableView.mj_footer resetNoMoreData];//恢复没有更多数据
    [self.rootTableView setContentOffset:CGPointMake(0,0) animated:NO];
    [self getDataWithPageNum:_pageNum];
    //更换数据

}
#pragma mark ************** 分区底部按钮点击事件

- (void)footViewBtnClickActionWithTitle:(NSString *)title NSSection:(NSInteger)section TotalPrices:(CGFloat)totalPrices{
    // , @"取消订单", @"付款"  @"确认收货"  @"再次购买"   @"删除订单",
    YZGOrderModel *model = self.dataArray[section];
    
    
    
    if([title isEqualToString:@"联系卖家"])
    {
        NSLog(@"---%ld---%@",section,title);
        [self contactSellerWithBrandID:model.brandId];
    }
    else if([title isEqualToString:@"取消订单"])
    {
        NSLog(@"---%ld---%@",section,title);
        [self closeOrderWithOrderID:model.orderCode NSSection:section];
    }
    else if([title isEqualToString:@"付款"])
    {
        NSLog(@"---%ld---%lf",section,totalPrices);
        
        //判断是否为协商支付
        if(model.isPayType == 1)//1-协商支付
        {
            [SVProgressHUD showImage:nil status:@"请到电脑版支付"];
        }
        else
        {
            [self payWithOrderID:model.orderCode totalPrices:totalPrices];
        }
        
        
    }
    else if([title isEqualToString:@"确认收货"])
    {
        NSLog(@"---%ld---%@",section,title);
        //9月5号前提示到电脑确认 1473087600 为  9月5号11 点的时间戳
        NSInteger time = model.addDate;
        if(time/1000 < 1473087600)
        {
            YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"此订单由支付宝担保交易，需使用电脑登录网页版易掌管进行操作。"];
            alert.alertNoBlock = ^(){};
            alert.alertYesBlock = ^(){
            };
  
        }
        else
        {
            [self confirmrReceiptWithOrderID:model.orderCode NSSection:section];
        }
    }
    else if([title isEqualToString:@"再次购买"])
    {
        NSLog(@"---%ld---%@",section,title);
        [self buyAgainWithOrderId:model.orderCode];
    }
    else if([title isEqualToString:@"删除订单"])
    {
        NSLog(@"---%ld---%@",section,title);
        [self deleteOrderWithOrderID:model.orderCode NSSection:section];
    }
}
#pragma mark ************** 联系卖家方法
- (void)contactSellerWithBrandID:(NSString *)brandID {
    
//    YZGShopInformationViewController *shopInfomationVC = [[YZGShopInformationViewController alloc] init];
//    shopInfomationVC.brandCode = brandID;
//    shopInfomationVC.jumpToServicePage = YES;
//    [self.navigationController pushViewController:shopInfomationVC animated:YES];
}
#pragma mark ************** 取消订单方法
- (void)closeOrderWithOrderID:(NSString *)orderID NSSection:(NSInteger)section{
     ESWeakSelf;
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定取消订单吗"];
    alert.alertNoBlock = ^(){};
    
    alert.alertYesBlock = ^(){
        
        NSLog(@"点击确定事件事件");
        
            [SVHTTPClient orderCancelWithOrderId:orderID callBack:^(BOOL orderCancelState) {
                if(orderCancelState)
                {
                   
                    [__weakSelf.dataArray removeObjectAtIndex:section];
                    [__weakSelf.rootTableView reloadData];
                    
                    //判断是否为空，显示空视图
                     if(__weakSelf.dataArray.count == 0)
                     {
                         [__weakSelf.rootTableView showEmptyViewWithtype:EmptyViewTypeEmptyData IsOrder:YES refresh:^{
                             [__weakSelf.rootTableView removeEmptyView];
                             [__weakSelf PushHomeViewController];
                             
                         }];
                     }
                    

                }
            }];
    };
  
}



#pragma mark ************** 付款方法
- (void)payWithOrderID:(NSString *)orderID totalPrices:(CGFloat)totalPrices {
    

      NSMutableArray *array = [NSMutableArray array];
     [array addObject:orderID];
     [self PayAction:array :totalPrices];//进行支付
    
}

#pragma mark ************** 支付接口
- (void)PayAction:(NSArray *)orderArray :(CGFloat)totalPrices{
    
//    ESWeakSelf;
//    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
//    NSString *appScheme = @"YZGAPP";
//    
//    [SVHTTPClient payPortWithOrderIds:orderArray callBack:^(BOOL state, NSDictionary *dataDic) {
//        
//        [[AlipaySDK defaultService] payOrder:[dataDic objectForKey:@"payUrl"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            
//            NSLog(@"reslut = %@",resultDic);
//            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
//                [SVProgressHUD showImage:nil status:@"支付成功"];
//                
//                //跳转到支付成功页面
//                
//                YZGPayFinishViewController *VC = [[YZGPayFinishViewController alloc]init];
//                VC.price = totalPrices;
//                VC.state = 0; //0 代表成功
//                [__weakSelf.navigationController pushViewController:VC animated:YES];
//                
//            } else {
//                //跳转到支付失败页面
//                [SVProgressHUD showErrorWithStatus:@"支付失败"];
//
//                
//            }
//        }];
//        
//    }];
    
}

#pragma mark ************** 确认收货方法
- (void)confirmrReceiptWithOrderID:(NSString *)orderID NSSection:(NSInteger)section{
    ESWeakSelf;
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"卖家将收到您的货款,确认收货吗"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        
        [SVHTTPClient orderConfirmWithOrderID:orderID callBack:^(BOOL state) {
            if(state)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    YZGOrderModel *brandModel = __weakSelf.dataArray[section];
                    
                    YZGOrderDetailsController *DetailVC = [[YZGOrderDetailsController alloc]init];
                    DetailVC.orderId = brandModel.orderCode;
                    
                    [__weakSelf.navigationController pushViewController:DetailVC animated:YES];
                  
                });

            }
        }];
        
    };
   
}
#pragma mark ************** 再次购买方法
- (void)buyAgainWithOrderId:(NSString *)orderId
{
    [SVHTTPClient orderBuyAgainWithOrderID:orderId callBack:^(BOOL state) {
        if(state){}
    }];
}
#pragma mark ************** 删除订单方法
- (void)deleteOrderWithOrderID:(NSString *)orderID NSSection:(NSInteger)section{
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"是否删除此订单"];
    ESWeakSelf;
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
            NSLog(@"点击事件");
        
            [SVHTTPClient orderDeleteWithOrderId:orderID callBack:^(BOOL orderDeleteState) {
                if(orderDeleteState)
                {
                    [__weakSelf.dataArray removeObjectAtIndex:section];
                    [__weakSelf.rootTableView reloadData];
                    
                    //判断是否为空，显示空视图
                    if(__weakSelf.dataArray.count == 0)
                    {
                        [__weakSelf.rootTableView showEmptyViewWithtype:EmptyViewTypeEmptyData IsOrder:YES refresh:^{
                            [__weakSelf.rootTableView removeEmptyView];
                            [__weakSelf PushHomeViewController];
                            
                        }];
                    }
                }
            }];
    };
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YZGOrderModel *orderModel = self.dataArray[section];
    return   orderModel.ezgOrderdetailsArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YZGOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yzgOrderCell" forIndexPath:indexPath];
    YZGOrderModel *brandModel = self.dataArray[indexPath.section];
    YZGOrderDetailModel *detailModel = brandModel.ezgOrderdetailsArr[indexPath.row];
    cell.model = detailModel;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZGOrderModel *brandModel = self.dataArray[indexPath.section];
    YZGOrderDetailsController *DetailVC = [[YZGOrderDetailsController alloc]init];
     DetailVC.orderId = brandModel.orderCode;
    
    [self.navigationController pushViewController:DetailVC animated:YES];
}

/*分区头部部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEAD_HEIGHT;
}
/*分区尾部高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FOOT_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    YZGOrderHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"yzgOrderHeadView"];
    if(!headView)
    {
        headView = [[YZGOrderHeadView alloc] initWithReuseIdentifier:@"yzgOrderHeadView"];
    }
    YZGOrderModel *brandModel = self.dataArray[section];
    headView.brandModel = brandModel;
    return headView;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
   
    ESWeakSelf;
    YZGOrderFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"yzgOrderFootView"];
    if(!footView)
    {
        footView = [[YZGOrderFootView alloc] initWithReuseIdentifier:@"yzgOrderFootView"];
    }
    YZGOrderModel *brandModel = self.dataArray[section];
    footView.section = section;
    footView.brandModel = brandModel;
    /* 分区尾部按钮block 回调 */
    footView.footViewBtnClickBlack = ^(NSString *title,NSInteger section ,CGFloat totalPrices)
    {
        [__weakSelf footViewBtnClickActionWithTitle:title NSSection:section TotalPrices:totalPrices];
    };
    
    return footView;
    
}

#pragma mark - 控件布局
- (void)addSubviewsForOrderList
{
    
    [self.view addSubview:self.orderSegmentedControl];
    [self.view addSubview:self.rootTableView];
    
    [_orderSegmentedControl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(40)));
    }];
    [_rootTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderSegmentedControl.bottom);
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

@end

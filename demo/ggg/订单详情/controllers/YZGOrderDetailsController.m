//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderDetailsController.h"
#import "YZGOrderModel.h"
#import "YZGDetailsOrderHeadView.h"
#import "YZGDetailsOrderFootView.h"
#import "YZGDetailsOrderSctionHeadView.h"
#import "YZGDetailsOrderSctionFootView.h"
#import "YZGDetailsOrderCell.h"
#import "YZGDetailsOrderEndView.h"
#import "YZGNextOhterDetailModel.h"
#import "SVHTTPClient+OrderDetail.h"
#import "YZGAlertView.h"
#import "YZGApplyRefundVC.h"
//#import "YZGRefundInformationVC.h"
//#import "YZGShopInformationViewController.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "SVHTTPClient+PayPort.h"
#import "YZGPayFinishViewController.h"
#import "SVHTTPClient+OrderCancel.h"
#import "SVHTTPClient+OrderDelete.h"
#import "SVHTTPClient+OrderAddShoppingCar.h"
#import "SVHTTPClient+OrderConfirm.h"
//#import "YZGProductDetailViewController.h"
#import "YZGRefundProgressVC.h"
#import "RefundCloseVC.h"
#import "RefuldViewController.h"
#import "RefundSuccessVC.h"
#import "YZGremarkView.h"
#import "ViewController.h"
static float const CELL_HEIGHT = 125;  /**< cell高度 */
static float const HEAD_HEIGHT = 50;  /**< 分区头部高度 */
static float const FOOT_HEIGHT = 40;  /**< 分区尾部高度 */
@interface YZGOrderDetailsController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) YZGNextOhterDetailModel *model;  /**< 数据模型 */

@property (nonatomic, strong) UITableView *rootTableView;                     /**< 我的TableView */

@property (nonatomic, strong) YZGDetailsOrderEndView *endView;                    /**< 下方View */

@property (nonatomic, strong) YZGDetailsOrderFootView *footView;                    /**< TableView尾部信息 */

@property (nonatomic, strong) YZGDetailsOrderHeadView *headView;                    /**< TableView头部信息 */


@end

@implementation YZGOrderDetailsController

#pragma mark - 懒加载控件
- (UITableView *)rootTableView {
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _rootTableView.backgroundColor = RGB(247, 247, 247);
        _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;//取消分割线
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        _rootTableView.hidden = YES;
    }
    return _rootTableView;
    
}
- (YZGDetailsOrderHeadView *)headView {
    
    if (!_headView) {
        _headView = [[YZGDetailsOrderHeadView alloc] initWithFrame:CGRectMake(0, 0, 0, 220)];
        _headView.model = self.model;
        
    }
    return _headView;
}
- (YZGDetailsOrderFootView *)footView {
    
    if (!_footView) {
        
        _footView = [[YZGDetailsOrderFootView alloc] initWithFrame:CGRectMake(0, 0, 0, [self getFootViewHeight])];
        _footView.model = self.model;
        _footView.remarkFootBlack = ^(NSString *text){
            [YZGremarkView showAlertViewWithTitle:text ConfirmBlock:^{
                
            }];
        };
    }
    return _footView;
}
- (YZGDetailsOrderEndView *)endView {
    if (!_endView) {
        ESWeakSelf;
        _endView = [[YZGDetailsOrderEndView alloc] init];
        _endView.hidden = YES;
        _endView.endViewBtnClickBlack = ^(NSString *title){
            [__weakSelf endViewBtnClickActionWithTitle:title];
        };
    }
    return _endView;
}
#pragma mark **************** 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getData];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForDetailsVC];//控件布局
}
#pragma mark **************** 加载数据
- (void)setModel:(YZGNextOhterDetailModel *)model
{
    _model = model;//赋值
    
    self.headView = nil;
    
    self.footView = nil;
    
    self.rootTableView.tableHeaderView = self.headView;
    
    self.rootTableView.tableFooterView = self.footView;
    
    
    self.endView.model = model;
    
    self.rootTableView.hidden = NO;
    
    self.endView.hidden = NO;
    
}
#pragma mark **************** 请求数据
- (void)getData
{
    ESWeakSelf;
    [SVHTTPClient getOrderDetailWithOtherId:self.orderId target:self CallBack:^(YZGNextOhterDetailModel *detailModel) {
        __weakSelf.model = detailModel;
 
        [__weakSelf.rootTableView reloadData];
    }];
}


#pragma mark **************** 自定义方法
- (void)setNav{
    self.title = @"订单详情";
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
#pragma mark ************** 计算tableFootView 的高度
- (CGFloat)getFootViewHeight{
    CGFloat height;
    //底部空隙为45
    if(self.model.isCheckState == 0)
    {
        height = 30*2+50;
    }
    else if(self.model.isCheckState == 1 || self.model.isCheckState == 2)
    {
        height = 30*3+50;
    }
    else if(self.model.isCheckState == 3)
    {
        height = 30*4+50;
    }
    else if(self.model.isCheckState == 4)
    {
        height = 30*5+50;
    }
    else if(self.model.isCheckState == 5)
    {
        height = 30*3+50;
    }
    //订单备注 60
    height = height + 60;
    
    return height;
}
#pragma mark ************** 底部按钮点击事件
- (void)endViewBtnClickActionWithTitle:(NSString *)title{
    
    if([title isEqualToString:@"联系卖家"])
    {
        NSLog(@"------%@",title);
        [self contactSellerWithBrandID:self.model.brandId];
    }
    else if([title isEqualToString:@"取消订单"])
    {
        NSLog(@"------%@",title);
        [self closeOrderWithOrderID:self.model.orderCode];
    }
    else if([title isEqualToString:@"付款"])
    {
        NSLog(@"------%@",title);
        
        [self payWithOrderCode:self.model.orderCode ];
    }
    else if([title isEqualToString:@"确认收货"])
    {
        NSLog(@"------%@",title);
      
        NSInteger time = self.model.addDate;
        if(time/1000 < 1473087600)
        {
            YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"此订单由支付宝担保交易，需使用电脑登录网页版易掌管进行操作。"];
            alert.alertNoBlock = ^(){};
            alert.alertYesBlock = ^(){
            };
        }
        else
        {
            [self confirmrReceiptWithOrderID:self.model.orderCode];
        }
    }
    else if([title isEqualToString:@"再次购买"])
    {
        NSLog(@"------%@",title);
        [self buyAgainWithOrderId:self.model.orderCode];
    }
    else if([title isEqualToString:@"删除订单"])
    {
        NSLog(@"------%@",title);
        [self deleteOrderWithOrderID:self.model.orderCode];
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
- (void)closeOrderWithOrderID:(NSString *)orderID {
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"确定取消订单吗"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        
        ESWeakSelf;
        [SVHTTPClient orderCancelWithOrderId:orderID callBack:^(BOOL orderCancelState) {
            if(orderCancelState)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [__weakSelf.navigationController popViewControllerAnimated:YES];

                });
                
                
            }
        }];
    };
   
}
#pragma mark ************** 付款方法
- (void)payWithOrderCode:(NSString *)orderCode{
    
    CGFloat price = self.model.productMoneyCount;
   
    //判断是否为协商支付
    if(self.model.isPayType == 1)//1-协商支付
    {
        [SVProgressHUD showImage:nil status:@"请到电脑版支付"];
    }
    else
    {
        [self PayAction:@[orderCode] TotalPrices:price];
  
    }
    
    
   
}
#pragma mark ************** 确认收货方法
- (void)confirmrReceiptWithOrderID:(NSString *)orderID {
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"卖家将收到您的货款,确认收货吗"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        ESWeakSelf;
        [SVHTTPClient orderConfirmWithOrderID:orderID callBack:^(BOOL state) {
            if(state)
            {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                       [__weakSelf getData];
                  
                });

            }
        }];
        
    };
    
}
#pragma mark ************** 再次购买方法
- (void)buyAgainWithOrderId:(NSString *)orderId {
    [SVHTTPClient orderBuyAgainWithOrderID:orderId callBack:^(BOOL state) {
        if(state){}
    }];
}

#pragma mark ************** 删除订单方法
- (void)deleteOrderWithOrderID:(NSString *)orderID {
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"是否删除此订单"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        NSLog(@"点击事件");
        ESWeakSelf;
        [SVHTTPClient orderDeleteWithOrderId:orderID callBack:^(BOOL orderDeleteState) {
            if(orderDeleteState)
            {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [__weakSelf.navigationController popViewControllerAnimated:YES];
                    
                });
            }
        }];
    };

}

#pragma mark ************** 退款按钮点击事件回调
- (void)reimburseBtnClickBlack:(NSString *)text :(NSIndexPath *)indexPath{
    if([text isEqualToString:@"申请退款"] || [text isEqualToString:@"申请售后"])
    {
        if(self.model.isCheckState == 3 || self.model.isCheckState == 4)//待收货状态，成功状态
        {
            YZGRefundProgressVC *VC = [[YZGRefundProgressVC alloc] init];
            VC.brandID = self.model.brandId;
            [self.navigationController pushViewController:VC animated:YES];
        }
        else //待发货状态
        {
            NSLog(@"申请退款");
            YZGApplyRefundVC *VC = [[YZGApplyRefundVC alloc]init];
            VC.indexPath = indexPath;
            VC.model = self.model;
            [self.navigationController pushViewController:VC animated:YES];
        }

    }
    else if([text isEqualToString:@"退款中"])
    {
        
        RefuldViewController *VC = [[RefuldViewController alloc]init];
        VC.indexPath = indexPath;
        VC.orderDetailId = self.orderId;
        [self.navigationController pushViewController:VC animated:YES];

    }
    else if([text isEqualToString:@"退款关闭"])
    {
        
        RefundCloseVC *VC = [[RefundCloseVC alloc]init];
        VC.indexPath = indexPath;
        VC.orderDetailId = self.orderId;
        [self.navigationController pushViewController:VC animated:YES];
    }
    else if([text isEqualToString:@"退款成功"])
    {
        
        RefundSuccessVC *VC = [[RefundSuccessVC alloc]init];
        VC.indexPath = indexPath;
        VC.orderDetailId = self.orderId;
        [self.navigationController pushViewController:VC animated:YES];
        
    }
    
    
}
#pragma mark ************** 支付接口
- (void)PayAction:(NSArray *)orderArray TotalPrices:(CGFloat)totalPrices{
    /*
    ESWeakSelf;
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"YZGAPP";
    
    [SVHTTPClient payPortWithOrderIds:orderArray callBack:^(BOOL state, NSDictionary *dataDic) {
        
        [[AlipaySDK defaultService] payOrder:[dataDic objectForKey:@"payUrl"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            if ([[resultDic objectForKey:@"resultStatus"] isEqualToString:@"9000"]) {
                [SVProgressHUD showImage:nil status:@"支付成功"];
                
                //跳转到支付成功页面
                
                YZGPayFinishViewController *VC = [[YZGPayFinishViewController alloc]init];
                VC.price = totalPrices;
                VC.state = 0; //0 代表成功
                [__weakSelf.navigationController pushViewController:VC animated:YES];
                
            } else {
                //跳转到支付失败页面
                 [SVProgressHUD showErrorWithStatus:@"支付失败"];

                
            }
        }];
        
    }];
     
     */
    
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return   self.model.ezgOrderdetailsArr.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return CELL_HEIGHT;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YZGDetailsOrderCell *cell = [YZGDetailsOrderCell mineTableViewWith:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    cell.indexPath = indexPath;
    cell.model = self.model;
    /* 退款按钮点击事件回调 */
    ESWeakSelf;
    cell.reimburseBtnBlack = ^(NSString *text,NSIndexPath *indexPath){
        [__weakSelf reimburseBtnClickBlack:text :indexPath];
    };
    /* 备注点击回调 */
    cell.remarkBlack = ^(NSString *text)
    {
        [YZGremarkView showAlertViewWithTitle:text ConfirmBlock:^{
            
        }];
    };
    return cell;
    
}
#pragma mark **************** 分区头部部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HEAD_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    YZGDetailsOrderSctionHeadView *sctionHeadView = [[YZGDetailsOrderSctionHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,HEAD_HEIGHT)];
    YZGOrderDetailModel *detailModel = self.model.ezgOrderdetailsArr[section];
    Orderdetails *product =   detailModel.productDetail;
    sctionHeadView.brandLab.text = product.brandName;
    return sctionHeadView;
    
}
#pragma mark **************** 分区尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FOOT_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
  
    YZGDetailsOrderSctionFootView *SctionFootView = [[YZGDetailsOrderSctionFootView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FOOT_HEIGHT) ProductModel:self.model];
    return SctionFootView;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YZGOrderDetailModel *detailModel = self.model.ezgOrderdetailsArr[indexPath.row];
    NSString *productId = detailModel.productDetail.seqid;
    
    //跳转到商品详情
//    YZGProductDetailViewController *VC = [[YZGProductDetailViewController alloc]init];
//    VC.seqId = productId;
//    [self.navigationController pushViewController:VC animated:YES];
    
    ViewController *view = [[ViewController alloc]init];
    
    [self.navigationController pushViewController:view animated:YES];
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForDetailsVC
{
    [self.view addSubview:self.endView];
    [self.view addSubview:self.rootTableView];
   
    
    [_endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    [_rootTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(_endView.top);
    }];
}


@end

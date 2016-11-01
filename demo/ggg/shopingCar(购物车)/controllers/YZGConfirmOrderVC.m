//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGConfirmOrderVC.h"
#import "YZGConfirmOrderSectionHead.h"
#import "MJShoppingCarModel.h"
#import "YZGConfirmOrderCell.h"
#import "YZGConfirmOrderSectionFoot.h"
#import "YZGConfirmTableHeadView.h"
#import "YZGConfirmTableFootView.h"
#import "SVHTTPClient+GetDefaultAddress.h"
#import "YZGConfirmBottomView.h"
#import "YZGAddressModel.h"
#import "YZGAlertView.h"
//#import "SVHTTPClient+OrderAdd.h"
//#import <AlipaySDK/AlipaySDK.h>
//#import "SVHTTPClient+PayPort.h"
#import "YZGPayFinishViewController.h"
#import "YZGUserAddressSettingVC.h"
//#import "YZGOrderViewController.h"
#import "YZGRemarksView.h"
#import "YZGExpressModel.h"
#import "YZGChooseExpressController.h"
#import "SVHTTPClient+ExpressLists.h"
#import "YZGReturnAlertView.h"
static float const HEAD_HEIGHT = 45;  /**< 分区头部高度 */
static float const FOOT_HEIGHT = 100;  /**< 分区尾部高度 */
static float const CELL_HEIGHT = 140;  /**< cell高度 */

@interface YZGConfirmOrderVC ()<UITableViewDelegate, UITableViewDataSource>
{
     NSInteger _totalCount;
}
@property (nonatomic, strong) UITableView *tableView;    /**< RootTableView */
@property (nonatomic, strong) YZGConfirmBottomView *bottomView;    /**< 下单底部 */
@property (nonatomic, strong) YZGAddressModel *adderssModel;    /**< 收货地址 */
@property (nonatomic, strong) YZGExpressModel *expressModel;    /**< 物流地址 */
@property (nonatomic, strong) YZGConfirmTableHeadView *headView;    /**< UITableView 头部 */
@property (nonatomic, strong) YZGConfirmTableFootView *footView;    /**< UITableView 尾部  */

@end

@implementation YZGConfirmOrderVC
#pragma mark ************** 懒加载控件
- (YZGConfirmBottomView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[YZGConfirmBottomView alloc]init];
        ESWeakSelf;
        _bottomView.submitBtnBlack = ^()
        {
            [__weakSelf isHaveLogistics];//判断是否有物流地址
        };
        _bottomView.totalPrice = [self getPrice];
        _bottomView.totalCount = _totalCount;
        _bottomView.hidden = YES;
        
    }
    return _bottomView;
}
- (YZGConfirmTableFootView *)footView {
    
    if (!_footView) {
        _footView = [[YZGConfirmTableFootView alloc]initWithFrame:CGRectMake(0, 0, 0, 90)];
        _footView.totalPrice = [self getPrice];
    }
    return _footView;
}
- (YZGConfirmTableHeadView *)headView {
    
    if (!_headView) {
        ESWeakSelf;
        _headView = [[YZGConfirmTableHeadView alloc]initWithFrame:CGRectMake(0, 0, 0, 125)];//物流40
        _headView.userInteractionEnabled = YES;//添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headViewClick:)];
        [_headView addGestureRecognizer:tap];
        _headView.compameClick = ^(){
            [__weakSelf changeLogisticscompany];//点击物流选择
        };
    }
    return _headView;
}
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGB(250, 250, 250);
        [_tableView registerClass:[YZGConfirmOrderCell class] forCellReuseIdentifier:@"YZGConfirmOrderCell"];
        [_tableView registerClass:[YZGConfirmOrderSectionHead class] forHeaderFooterViewReuseIdentifier:@"YZGConfirmTableHeadView"];
        [_tableView registerClass:[YZGConfirmOrderSectionFoot class] forHeaderFooterViewReuseIdentifier:@"YZGConfirmTableFootView"];
        _tableView.tableHeaderView = self.headView;//头部
        _tableView.tableFooterView = self.footView;//尾部
        _tableView.hidden = YES;
        
    }
    return _tableView;
}
#pragma mark ************** 系统方法
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getDefaultAdderss];//获取默认收货地址
    
    [self addSubviewsForConfirmOrderVC];// 控件布局
    
    [self setNav];//设置导航栏
    
    
    
}

#pragma mark ************** 自定义方法
- (void)setNav{
    self.title = @"确认订单";
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
    ESWeakSelf;
    YZGReturnAlertView *alert = [[YZGReturnAlertView alloc]initWithTitle:@"便宜不等人，请三思而行~"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        [__weakSelf.navigationController popViewControllerAnimated:YES];
        
    };
}

#pragma mark ************** 点击物流
- (void)changeLogisticscompany
{
    ESWeakSelf;//更换物流信息
    YZGChooseExpressController *VC = [[YZGChooseExpressController alloc]init];
    VC.chooseExpressModel = self.expressModel;
    VC.chooseExpress = ^(YZGExpressModel *model){
        
        __weakSelf.expressModel = model;
        self.headView.expressModel = model;
        
    };
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 判断是否有选择物流公司
- (void)isHaveLogistics
{
    if(!self.expressModel)//不存在
    {
        YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"您还没选择物流公司"];
        alert.alertNoBlock = ^(){};
        alert.alertYesBlock = ^(){
        };
    }
    else
    {
        [self bottomViewSubButtonClicked];
    }
}
#pragma mark ************** 提交订单按钮
- (void)bottomViewSubButtonClicked{
    NSMutableArray *array = [NSMutableArray array];//订单备注编号数组
    NSMutableDictionary *remarkDic = [NSMutableDictionary dictionary];//备注信息数组
    for (MJShoppingCarModel *shopModel in self.dataArray)
    {
        for (Products *goodsModel in shopModel.products)
        {
            if (goodsModel.select)
            {
                [array addObject:goodsModel.cartId];
            }
        }
        NSString *remarkText = @"";
        if(shopModel.remarkText == nil)//如果为nil
        {
            remarkText = @"";
        }
        else
        {
            remarkText = shopModel.remarkText;
        }
        [remarkDic setObject:remarkText forKey:shopModel.brandId];
        
    }
    /*
    ESWeakSelf;
    [SVHTTPClient orderAddWithCarIds:array AdderssId:self.adderssModel.deliverId LogisticsId:self.expressModel.logisticsId RemarkDic:remarkDic  callBack:^(NSArray *orderIdArray, BOOL state, NSString *errorMassage) {
        if (state) {
            
            [__weakSelf PayAction:orderIdArray];//支付接口
            
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }
    }];
     
    */
}

#pragma mark ************** 支付接口
- (void)PayAction:(NSArray *)orderArray
{

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
                VC.price = [self getPrice];
                [__weakSelf.navigationController pushViewController:VC animated:YES];
                
            } else {
                //跳转到支付失败页面
                OrderType orderType = WaitPay;//跳转到订单列表
                YZGOrderViewController *cartVC = [[YZGOrderViewController alloc] initWithOrderType:orderType];
                [self.navigationController pushViewController:cartVC animated:YES];

      
            }
        }];
        
    }];
     
     */

}

#pragma mark ************** 选择收货地址
-(void)headViewClick:(UITapGestureRecognizer *)sender{
    ESWeakSelf;
    YZGUserAddressSettingVC *VC = [[YZGUserAddressSettingVC alloc]init];
    VC.isChooseAdderss = YES;
    VC.chooseAddress = self.adderssModel;  //选中的地址(开始为默认)
    VC.adderssModel = ^(YZGAddressModel *model)
    {
         __weakSelf.adderssModel = model;
         self.headView.model = model;
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark ************** 获取默认收货地址
- (void)getDefaultAdderss
{
    
    ESWeakSelf;
    [SVHTTPClient getDefaultAddressWithTarget:self CallBack:^(YZGAddressModel *defultAddressModel, BOOL isHaveDefaultAddress) {
        
        if(isHaveDefaultAddress)
        {
            _bottomView.hidden = NO;
            
            _tableView.hidden = NO;
            
            __weakSelf.adderssModel = defultAddressModel;//地址赋值
            
            __weakSelf.headView.model = defultAddressModel;//地址赋值
            
            [__weakSelf getDefaultExpress];//获取默认物流

        }
        else
        {
            //没有默认地址
            YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"设置默认地址"];
            alert.alertYesBlock = ^(){
               
                //进入地址列表
                YZGUserAddressSettingVC *VC = [[YZGUserAddressSettingVC alloc]init];
                VC.isShopCar = YES;
                VC.refreshView = ^(){
                    //重新获取默认地址
                    [__weakSelf getDefaultAdderss];//获取默认收货地址
                };
               
                [__weakSelf.navigationController pushViewController:VC animated:YES];
            };
            alert.alertNoBlock = ^(){
                [__weakSelf.navigationController popViewControllerAnimated:YES];
            };

        }
        
    }];
    
}
#pragma mark ************** 获取默认物流
- (void)getDefaultExpress
{
    ESWeakSelf;
    [SVHTTPClient getDefaultExpressWithTarget:self CallBack:^(YZGExpressModel *defultExpressModel, BOOL state) {
        if(state)
        {
            __weakSelf.expressModel = defultExpressModel;//物流赋值
            
            __weakSelf.headView.expressModel = defultExpressModel;
        }
    }];
}
#pragma mark ************** 计算总价格
- (CGFloat)getPrice{
    _totalCount = 0; //总数量
    CGFloat totalPrices = 0.f; //总价格
    for(MJShoppingCarModel *brandModel in self.dataArray)
    {
        for(Products *product in brandModel.products)
        {
            if(product.select)
            {
                ProductDetail *productDetail = product.productDetail;
                totalPrices += product.productQty *productDetail.dealerPurchasePrice;
                _totalCount  += product.productQty;

            }
        }
    }
    
    return totalPrices;
    
}

#pragma mark ************** 修改备注信息
- (void)changeRemarksWithSection:(NSInteger )section RemarkText:(NSString *)text
{
    NSString *string = nil;
    if([text isEqualToString:@"品牌备注:"])
    {
        string = @"";
    }
    else
    {
        string = text;
    }
    ESWeakSelf;
    [YZGRemarksView showRemarksViewWithTitle:string PlacehoderText:@"请输品牌备注" ConfirmBlock:^(NSString *text) {
        
        MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[section];
        shopModel.remarkText = text;
        [__weakSelf.tableView reloadData];
        
    } CancelBlock:^{
        
    }];
 
}
#pragma mark ************** tableView方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)self.dataArray[section];
    return shopModel.products.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return  CELL_HEIGHT;
}

#pragma mark ************** Cell显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YZGConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YZGConfirmOrderCell" forIndexPath:indexPath];
    MJShoppingCarModel *shopModel = (MJShoppingCarModel *)_dataArray[indexPath.section];
    cell.model = shopModel.products[indexPath.row];
    return cell;

}
#pragma mark ************** 分区头部部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEAD_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YZGConfirmOrderSectionHead *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YZGConfirmOrderSectionHead"];
    if(!sectionHeadView)
    {
        sectionHeadView = [[YZGConfirmOrderSectionHead alloc] initWithReuseIdentifier:@"YZGConfirmOrderSectionHead"];
    }
    MJShoppingCarModel *shopModel  = self.dataArray[section];
    sectionHeadView.titleLab.text =shopModel.brandName;
    return sectionHeadView;
}
#pragma mark ************** 分区尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FOOT_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    ESWeakSelf;
    YZGConfirmOrderSectionFoot *sectionFootView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YZGConfirmOrderSectionFoot"];
    if(!sectionFootView)
    {
        sectionFootView = [[YZGConfirmOrderSectionFoot alloc] initWithReuseIdentifier:@"YZGConfirmOrderSectionFoot"];
    }
    sectionFootView.model = self.dataArray[section];
    sectionFootView.section = section;
    sectionFootView.remarkFootClick = ^(NSInteger section,NSString *text)
    {
        [__weakSelf changeRemarksWithSection:section RemarkText:text];//备注按钮点击事件
       
    };
    return sectionFootView;
    
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForConfirmOrderVC
{
    [self.view addSubview:self.bottomView];
    
    [self.view addSubview:self.tableView];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(45)));
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(_bottomView.top);
        make.top.equalTo(self.view);
    }];
}

@end

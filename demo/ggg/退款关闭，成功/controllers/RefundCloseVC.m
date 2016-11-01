//
//  RefundCloseVC.m
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "RefundCloseVC.h"
#import "RefundCloseHeadView.h"
#import "RefundCloseSectionView.h"
#import "YZGMyServiceController.h"
#import "SVHTTPClient+OrderDetail.h"
#import "YZGNextOhterDetailModel.h"
//#import "YZGShopInformationViewController.h"
#import "YZGMyServiceController.h"
#import "YZGOrderDetailsController.h"
@interface RefundCloseVC ()<UITableViewDelegate, UITableViewDataSource >
{
    NSArray *_titleArray;
    NSArray *_detailsArray;
    RefundCloseHeadView *_refundCloseHeadView;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *serviceBtn;             /**<  申请客服介入 */
@property (nonatomic, strong) UIButton *brandBtn;             /**<  联系卖家 */
@property (nonatomic, strong) YZGNextOhterDetailModel *nextOhterDetailModel;  /* 订单明细Model */
@end

@implementation RefundCloseVC
- (UIButton *)brandBtn {
    if (!_brandBtn) {
        _brandBtn=[[UIButton alloc]init];
        [_brandBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
        [_brandBtn setTitleColor:mainColor forState:UIControlStateNormal];
        _brandBtn.titleLabel.font = systemFont(14);//标题文字大小
        _brandBtn.layer.borderWidth = 0.5;
        _brandBtn.layer.borderColor = mainColor.CGColor;
        _brandBtn.layer.cornerRadius = 3;
        _brandBtn.layer.masksToBounds = YES;
        [_brandBtn addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _brandBtn;
}
- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn=[[UIButton alloc]init];
        [_serviceBtn setTitle:@"申请客服介入" forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:mainColor forState:UIControlStateNormal];
        _serviceBtn.titleLabel.font = systemFont(14);//标题文字大小
        _serviceBtn.layer.borderWidth = 0.5;
        _serviceBtn.layer.borderColor = mainColor.CGColor;
        _serviceBtn.layer.cornerRadius = 3;
        _serviceBtn.layer.masksToBounds = YES;
        [_serviceBtn addTarget:self action:@selector(serviceClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _serviceBtn;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB(239, 239, 239);
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(221, 221, 221).CGColor;
        
    }
    return _bottomView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.backgroundColor = RGB(244, 244, 244);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _refundCloseHeadView = [[RefundCloseHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 120)];
        _tableView.tableHeaderView = _refundCloseHeadView;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        //分割线不留空白
        if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return _tableView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    
    //存在退款详情
    if(self.ezgRefundModel)
    {
        [self closeEzgRefund];
    }
    else
    {
        [self getData];
     }
    
}
#pragma mark ************** 退款关闭，自己撤销申请
- (void)closeEzgRefund
{
    
    [self addSubviewsForView];//添加子控件
    
     _titleArray = @[@"商铺名称",@"退款类型",@"退款金额",@"退款原因",@"退款编号",@"申请时间"];
 
    NSString *time = [self changeTime:self.ezgRefundModel.applyDate];
    NSString *brandName = self.brandName;
    

    _detailsArray = @[brandName,@"仅退款",[NSString stringWithFormat:@"%.2f元",self.ezgRefundModel.refundMoney],self.ezgRefundModel.refundReason,self.ezgRefundModel.refundCode,time];

     _refundCloseHeadView.closeTime = [self changeTime:self.ezgRefundModel.closeDate];
    
     _refundCloseHeadView.closeReason = @"由于您取消退款关闭。";
    
    
}
#pragma mark ************** 自定义方法
- (void)setNav{
    self.title = @"退款详情";
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
    
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:[YZGOrderDetailsController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
    
}
- (void)getData {
    
    _titleArray = @[@"商铺名称",@"退款类型",@"退款金额",@"退款原因",@"退款编号",@"申请时间"];
    
    
    //获取退款信息
    ESWeakSelf;
    [SVHTTPClient getOrderDetailWithOtherId:self.orderDetailId target:self CallBack:^(YZGNextOhterDetailModel *orderModel) {
        
        [__weakSelf addSubviewsForView];
        
        __weakSelf.nextOhterDetailModel = orderModel;
        
        __weakSelf.brandId =  __weakSelf.nextOhterDetailModel.brandId;
        
        YZGOrderDetailModel *detailModel =  orderModel.ezgOrderdetailsArr[__weakSelf.indexPath.row];
        
        YZGEzgRefund *ezgRefundModel = detailModel.ezgRefund;
        
        NSString *time = [__weakSelf changeTime:ezgRefundModel.applyDate];
        NSString *brandName = detailModel.productDetail.brandName;
        
        _detailsArray = @[brandName,@"仅退款",[NSString stringWithFormat:@"%.2f元",ezgRefundModel.refundMoney],ezgRefundModel.refundReason,ezgRefundModel.refundCode,time];
        
        
        _refundCloseHeadView.closeTime = [__weakSelf changeTime:ezgRefundModel.modifyDate];
        _refundCloseHeadView.closeReason = @"由于卖家已发货,请您联系卖家或申请平台介入.";
        [__weakSelf.tableView reloadData];
        
    }];
    
}
#pragma mark ************** 商家
- (void)brandClick:(UIButton *)sender
{
    
//    YZGShopInformationViewController *shopInfomationVC = [[YZGShopInformationViewController alloc] init];
//    shopInfomationVC.brandCode = self.brandId;
//    shopInfomationVC.jumpToServicePage = YES;
//    [self.navigationController pushViewController:shopInfomationVC animated:YES];
}
#pragma mark ************** 服务
- (void)serviceClick:(UIButton *)sender
{
    
    YZGMyServiceController *VC = [[YZGMyServiceController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 时间戳转换
- (NSString *)changeTime:(NSInteger)time
{
    NSString *strTime;
    NSDate *newdate=[NSDate dateWithTimeIntervalSince1970:time/1000];//NSDate
    //定义时间格式
    NSDateFormatter *dateformatter=[NSDateFormatter new];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //转为字符串
    strTime =[dateformatter stringFromDate:newdate];
    return strTime;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone; //选中cell时无色
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.detailTextLabel.text = _detailsArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithRed:0.540  green:0.564  blue:0.589 alpha:1];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.textColor = [UIColor colorWithRed:0.540  green:0.564  blue:0.589 alpha:1];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
#pragma mark ************** 分区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    RefundCloseSectionView *sectionView = [[RefundCloseSectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    return sectionView;
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
#pragma mark - 控件布局
- (void)addSubviewsForView {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.brandBtn];
    [self.bottomView addSubview:self.serviceBtn];
    
    
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.equalTo(@60);
        
    }];
    [_brandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@80);
        make.centerY.equalTo(_bottomView);
        make.centerX.equalTo(_bottomView).offset(-45);
        
    }];
    
    [_serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@90);
        make.centerY.equalTo(_bottomView);
        make.left.equalTo(_brandBtn.right).offset(10);
        
    }];
}



@end

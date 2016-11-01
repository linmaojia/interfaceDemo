//
//  RefuldViewController.m
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "RefuldViewController.h"
#import "YZGNextOhterDetailModel.h"
//#import "YZGShopInformationViewController.h"
#import "YZGMyServiceController.h"
#import "SVHTTPClient+OrderDetail.h"
#import "YZGOrderDetailsController.h"
#import "SVHTTPClient+OrderDetail.h"
#import "SVHTTPClient+RefundDelete.h"
#import "YZGApplyRefundVC.h"
#import "YZGAlertView.h"
#import "RefundCloseVC.h"
#import "YZGDetailRefuldView.h"
#import "YZGDataManage.h"
static float const SCROLLER_HEIGHT = 550;
@interface RefuldViewController ()
{
    NSInteger _hour,_minute,_day;
    UIView *bgView;
    NSInteger countData;  //退款天数
    
}

@property (nonatomic, strong) UIScrollView *scroll;    /**< Scrollow视图 */
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *changeBtn;       /**<  修改 */
@property (nonatomic, strong) UIButton *calloffBtn;     /**<  撤销 */
@property (nonatomic, strong) UIButton *severBtn;       /**<  申请客服介入 */
@property (nonatomic, strong) YZGDetailRefuldView *refuldView;  /**<  退款详情View */
@property (nonatomic, strong) YZGNextOhterDetailModel *orderModel;  /* 订单明细Model */
@property (nonatomic, strong) YZGDataManage *dataManage;  /* 数据管理者 */

@end

@implementation RefuldViewController

#pragma mark ************** 系统方法
- (YZGDataManage *)dataManage {
    
    if (!_dataManage) {
        _dataManage=[[YZGDataManage alloc]init];
    }
    return _dataManage;
}
- (YZGDetailRefuldView *)refuldView {
    
    if (!_refuldView) {
        _refuldView=[[YZGDetailRefuldView alloc]init];
    }
    return _refuldView;
}
- (UIButton *)changeBtn {
    
    if (!_changeBtn) {
        _changeBtn=[[UIButton alloc]init];
        [_changeBtn setTitle:@"修改申请" forState:UIControlStateNormal];
        [_changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _changeBtn.titleLabel.font = systemFont(15);
        _changeBtn.layer.borderWidth = 0.5;
        _changeBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _changeBtn.layer.cornerRadius = 5;
        _changeBtn.layer.masksToBounds = YES;
        [_changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _changeBtn;
}
- (UIButton *)calloffBtn {
    if (!_calloffBtn) {
        _calloffBtn=[[UIButton alloc]init];
        [_calloffBtn setTitle:@"撤销申请" forState:UIControlStateNormal];
        [_calloffBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _calloffBtn.titleLabel.font = systemFont(15);//标题文字大小
        _calloffBtn.layer.borderWidth = 0.5;
        _calloffBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _calloffBtn.layer.cornerRadius = 5;
        _calloffBtn.layer.masksToBounds = YES;
        [_calloffBtn addTarget:self action:@selector(calloffBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _calloffBtn;
}
- (UIButton *)severBtn {
    if (!_severBtn) {
        _severBtn=[[UIButton alloc]init];
        [_severBtn setTitle:@"客服介入" forState:UIControlStateNormal];
        [_severBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _severBtn.titleLabel.font = systemFont(15);//标题文字大小
        _severBtn.layer.borderWidth = 0.5;
        _severBtn.layer.borderColor = [UIColor blackColor].CGColor;
        _severBtn.layer.cornerRadius = 5;
        _severBtn.layer.masksToBounds = YES;
        [_severBtn addTarget:self action:@selector(severBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _severBtn;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB(239, 239, 239);
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(221, 221, 221).CGColor;
        _bottomView.hidden = YES;
        
    }
    return _bottomView;
}
- (UIScrollView *)scroll{
    
    if(!_scroll){
        _scroll=[[UIScrollView alloc] init];
        _scroll.contentSize=CGSizeMake(SCREEN_WIDTH, SCROLLER_HEIGHT);
        _scroll.scrollEnabled=YES;
        _scroll.showsHorizontalScrollIndicator=YES;
        _scroll.directionalLockEnabled=YES;//指定控件只能在一个方向滚动
        _scroll.backgroundColor = RGB(247, 247, 247);
        _scroll.hidden = YES;
        
    }
    return _scroll;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getData];//加载数据
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
}
#pragma mark ************** 自定义方法
- (void)setNav
{
    self.title = @"退款详情";
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
    
    //1 代表从申请退款中进来
    if (self.type == 1)
    {
        
        for (UIViewController *vc in self.navigationController.viewControllers)
        {
            if ([vc isKindOfClass:[YZGOrderDetailsController class]])
            {
                [self.navigationController popToViewController:vc animated:YES];
            }
        }
    }
    else
    {
        //从退款中进来
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)setNextOhterDetailModel:(YZGNextOhterDetailModel *)orderModel
{
    _orderModel = orderModel;
    
    YZGOrderDetailModel *detailModel =  orderModel.ezgOrderdetailsArr[self.indexPath.row];
    
    YZGEzgRefund *ezgRefundModel = detailModel.ezgRefund;
    
   
    //退款原因
    _refuldView.reasonLab.text = [NSString stringWithFormat:@"发起了申请，货物状态:未发货，原因：%@，金额：%.2f元。",ezgRefundModel.refundReason,ezgRefundModel.refundMoney];
    
    //退款时间
    _refuldView.timeLab1.text = [self.dataManage changeTime:ezgRefundModel.applyDate];
    _refuldView.timeLab2.text = [self.dataManage changeTime:ezgRefundModel.applyDate];
    
    //剩余时间
    NSInteger time = [self.dataManage getCurrentDaySurplusSecond:ezgRefundModel.applyDate/1000 CountData:ezgRefundModel.dayNum];//计算时间, //退款天数
    //退款编号
    _refuldView.numberLab.text = [NSString stringWithFormat:@"退款编号: %@",ezgRefundModel.refundCode];
    
    NSString *timeStr;
    if(time<0)
    {
        timeStr = @" 00 天 00 时 00 分";
    }
    else
    {
        timeStr = [self.dataManage getDetailTimeWithTimestamp:time];//返回富文本
    }
    NSString *string = [NSString stringWithFormat:@"卖家同意您的申请(卖家在%@内未处理您的申请，将视为默认\"同意\")，系统将退款给您；\n如果卖家发货，本次申请将关闭，您可通过\"申请售后\"要求客服介入进行处理。\n提示：请勿相信任何人给您发来的订单操作链接，以免被骗。",timeStr];
    
    _refuldView.RefuldLab.text = string;
    [self attributedString:string TimeStr:timeStr];//富文本

}
#pragma mark ************** 富文本
- (void)attributedString:(NSString *)string TimeStr:(NSString *)timeStr
{
    //调整行间距
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:3];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [string length])];
    
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:[string rangeOfString:timeStr]];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[string rangeOfString:@"天"]];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[string rangeOfString:@"时"]];
    [attributedString1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[string rangeOfString:@"分"]];
    
    [_refuldView.RefuldLab setAttributedText:attributedString1];
    [_refuldView.RefuldLab sizeToFit];
}

#pragma mark ************** 加载数据
- (void)getData
{
    ESWeakSelf; 
    [SVHTTPClient getOrderDetailWithOtherId:self.orderDetailId target:self CallBack:^(YZGNextOhterDetailModel *orderModel) {
        
        __weakSelf.bottomView.hidden = NO;
        
        __weakSelf.scroll.hidden = NO;
        
        __weakSelf.nextOhterDetailModel = orderModel;
        
    }];
}

#pragma mark ************** 撤销退款申请
- (void)refundDelete{
    
    YZGOrderDetailModel *detailModel =  self.orderModel.ezgOrderdetailsArr[self.indexPath.row];
    YZGEzgRefund *ezgRefundModel = detailModel.ezgRefund;
    ESWeakSelf;
    [SVHTTPClient refundDeleteWithRefundId:ezgRefundModel.refundId callBack:^(BOOL state,NSDictionary *ezgRefund) {
        
        if(state)
        {
            //跳转到退款关闭页面,自己撤销退款
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                RefundCloseVC *VC = [[RefundCloseVC alloc]init];
                YZGEzgRefund *ezgRefundModel = [YZGEzgRefund mj_objectWithKeyValues:ezgRefund];
                VC.ezgRefundModel = ezgRefundModel;//退款信息
                VC.brandId = __weakSelf.orderModel.brandId;
                VC.brandName = detailModel.productDetail.brandName;
                
                [__weakSelf.navigationController pushViewController:VC animated:YES];
            });
            
        }
    }];
}

- (void)calloffBtnClick:(UIButton *)sender
{
    ESWeakSelf;
    YZGAlertView *alert = [[YZGAlertView alloc]initWithTitle:@"客官您确定要撤销退款申请吗"];
    alert.alertNoBlock = ^(){};
    alert.alertYesBlock = ^(){
        [__weakSelf refundDelete];
    };
}
#pragma mark ************** 修改退款申请
- (void)changeBtnClick:(UIButton *)sender
{
    YZGApplyRefundVC *VC = [[YZGApplyRefundVC alloc]init];
    VC.indexPath = self.indexPath;
    VC.model = self.orderModel;
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark ************** 平台接入
- (void)severBtnClick:(UIButton *)sender
{
    YZGMyServiceController *VC = [[YZGMyServiceController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)addSubviews
{

//    _refuldView = [[[NSBundle mainBundle] loadNibNamed:@"RefuldsView" owner:self options:nil] objectAtIndex:0];
//    
//    _refuldView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 600);
//    
//    [self.scroll addSubview:_refuldView];
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.scroll];
    [self.view addSubview:self.bottomView];
    
    [self.scroll addSubview:self.refuldView];
    [self.bottomView addSubview:self.calloffBtn];
    [self.bottomView addSubview:self.changeBtn];
    [self.bottomView addSubview:self.severBtn];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{

    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(_bottomView.top);
    }];
    //顶部
    [_refuldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scroll);
        make.left.equalTo(_scroll);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCROLLER_HEIGHT));
    }];
    
    //底部
    [_calloffBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomView);
        make.height.equalTo(@40);
        make.width.equalTo(@80);
    }];
    [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.height.equalTo(@40);
        make.width.equalTo(@80);
        make.right.equalTo(_calloffBtn.left).offset(-20);
    }];
    [_severBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.height.equalTo(@40);
        make.width.equalTo(@80);
        make.left.equalTo(_calloffBtn.right).offset(20);
    }];

}

@end

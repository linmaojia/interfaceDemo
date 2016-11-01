//
//  RefundCloseVC.m
//  ggg
//
//  Created by LXY on 16/8/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "RefundSuccessVC.h"
#import "YZGRefundSuccessView.h"
#import "YZGNextOhterDetailModel.h"
#import "SVHTTPClient+OrderDetail.h"

static float const SCROLLER_HEIGHT = 800;
@interface RefundSuccessVC ()

@property (nonatomic, strong) UIScrollView *scroll;    /**< Scrollow视图 */

@property (nonatomic, strong) YZGNextOhterDetailModel *orderModel;  /* 订单明细Model */

@property (nonatomic, strong) YZGRefundSuccessView *successView;  /**<  退款成功View */
@end

@implementation RefundSuccessVC

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
- (YZGRefundSuccessView *)successView {
    
    if (!_successView) {
        _successView=[[YZGRefundSuccessView alloc]init];
    }
    return _successView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];

}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getData];//加载数据
}
#pragma mark ************** 自定义方法
- (void)setNav
{
    self.view.backgroundColor = [UIColor whiteColor];
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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ************** 加载数据
- (void)getData {
    
   //获取退款信息
    ESWeakSelf;
    [SVHTTPClient getOrderDetailWithOtherId:self.orderDetailId target:self CallBack:^(YZGNextOhterDetailModel *orderModel) {
        
        _scroll.hidden = NO;
        
        __weakSelf.successView.indexPath = __weakSelf.indexPath;
        
        __weakSelf.successView.orderModel = orderModel;
        
    }];
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.scroll];
    [self.scroll addSubview:self.successView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //顶部
    [_successView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scroll);
        make.left.equalTo(_scroll);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCROLLER_HEIGHT));
    }];
}
@end

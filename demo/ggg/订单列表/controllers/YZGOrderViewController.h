//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"

/**< 订单类型 */
typedef NS_ENUM(NSInteger, OrderType) {
    AllOrder,       //全部订单
    WaitPay,        //待付款
    WaitShipped,    //待发货
    WaitReceiving,  //待收货
    Finish,         //已完成
    Cancel          //已取消
};
@interface YZGOrderViewController : YZGRootViewController

- (instancetype)initWithOrderType:(OrderType)orderType;
@property (nonatomic, strong) UITableView *rootTableView;                     /**< 我的TableView */
@property (nonatomic, assign) BOOL isShopCar;       /**< 判断是否从购物车进来 */

- (void)PushHomeViewController;/**< 跳转到首页 */
- (void)getDataWithPageNum:(NSInteger)pageNum;/**< 请求数据 */
@end

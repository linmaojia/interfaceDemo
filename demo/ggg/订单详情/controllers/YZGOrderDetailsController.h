//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGOrderModel.h"
@interface YZGOrderDetailsController : YZGRootViewController

@property (nonatomic, strong) NSString *orderId;    /**< 订单Id */


@property (nonatomic,assign) NSInteger index;  /**< 点击某个订单 */

@end

//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGNextOhterDetailModel.h"

/**< 申请退款 */
@interface YZGApplyRefundVC : YZGRootViewController

@property (nonatomic, strong) YZGNextOhterDetailModel *model;             /**<  订单明细模型 */

@property (nonatomic, strong) NSIndexPath *indexPath;


@end

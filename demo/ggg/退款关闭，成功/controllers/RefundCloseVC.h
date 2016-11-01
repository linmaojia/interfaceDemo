//
//  RefundCloseVC.h
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGEzgRefund.h"
 /**< 退款关闭 */
@interface RefundCloseVC : YZGRootViewController

@property (nonatomic, strong) NSString *orderDetailId;    /**< 退款id号 */
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) YZGEzgRefund *ezgRefundModel;    /**< 退款信息 */
@property (nonatomic, strong) NSString *brandId;    /**< 商店名称 */
@property (nonatomic, strong) NSString *brandName;    /**< 商店ID */

@end

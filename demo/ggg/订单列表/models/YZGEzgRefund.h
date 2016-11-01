//
//  YZGEzgRefund.h
//  yzg
//
//  Created by LXY on 16/6/20.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZGEzgRefund : NSObject

@property (nonatomic, strong) NSString *status;       /* 退款状态*/

@property (nonatomic, assign) NSInteger dayNum;  /**< 退款天数 */

@property (nonatomic, strong) NSString *orderDetailId;  /**< 订单id */

@property (nonatomic, assign) NSInteger applyDate;  /**< 退款生成日期 */

@property (nonatomic, assign) NSInteger modifyDate;  /**< 退款撤销时间 */
@property (nonatomic, assign) NSInteger refundTime;  /**< 退款时间 */


@property (nonatomic, strong) NSString *refundAccount;  /**< 买家支付宝账号 */

@property (nonatomic, strong) NSString *refundCode;  /**< 退款编号 */
@property (nonatomic, strong) NSString *refundId;  /**< 退款id */


@property (nonatomic, strong) NSString *brandName;    /**< 商店 */

@property (nonatomic, strong) NSString *productId;

@property (nonatomic, assign) NSInteger productQty;

@property (nonatomic, assign) CGFloat refundMoney;   /**< 退款金额 */

@property (nonatomic, strong) NSString *refundReason;

@property (nonatomic, strong) NSString *refundRemark;

@property (nonatomic, assign) NSInteger closeDate;  /**< 关闭时间 */



@end

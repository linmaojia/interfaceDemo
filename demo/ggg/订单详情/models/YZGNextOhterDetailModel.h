

#import <Foundation/Foundation.h>
#import "YZGOrderDetailModel.h"
@class YZGOrderOperator;
@interface YZGNextOhterDetailModel : NSObject


@property (nonatomic, strong) NSString *logisticsInfo;       /**< 物流公司信息 */

@property (nonatomic, strong) NSString *deliverName;       /**< 收货人名称 */

@property (nonatomic, strong) NSString *deliverPhone;       /**< 收货人电话 */

@property (nonatomic, strong) NSString *deliverInfo;       /**< 收货人地址 */

@property (nonatomic, assign) NSInteger addDate;          /**< 订单创建时间 */

@property (nonatomic, assign) NSInteger deliveryDate;          /**< 发货时间 */

@property (nonatomic, assign) NSInteger onlinePayDate;    /**< 付款时间 */

@property (nonatomic, assign) NSInteger closeDate;    /**< 关闭时间 */

@property (nonatomic, assign) NSInteger completionDate;    /**< 交易成功时间 */

@property (nonatomic, strong) YZGOrderOperator *ezgOrderOperator;       /**< 订单取消状态 */

@property (nonatomic, assign) int isCheckState;  /**< 订单状态: 0-待付款, 1,2-待发货, 3-待收货, 4-已完成, 5-已取消 */

@property (nonatomic, strong) NSString *brandId;     /**< 商店ID */

@property (nonatomic, strong) NSString *orderCode;     /**< 明细付款码 */

@property (nonatomic, strong) NSString *orderId;     /**< 订单编号 */

@property (nonatomic, strong) NSString *brandName;     /**< 品牌名称 */

@property (nonatomic, assign) NSInteger productQtyCount;     /**< 购买数量 */

@property (nonatomic, assign) CGFloat productMoneyCount;     /**< 购买总金额 */

@property (nonatomic, strong) NSArray<YZGOrderDetailModel *> *ezgOrderdetailsArr;   /**<  产品数组 */

@property (nonatomic, assign) NSInteger isPayType;       /**< 付款方式 1-协商支付  2-在线支付 */

@property (nonatomic, strong) NSString *remarks;     /**< 订单备注 */

@end



@interface YZGOrderOperator : NSObject

@property (nonatomic, strong) NSString *operatorAction;     /**< 订单取消状态 */

@end


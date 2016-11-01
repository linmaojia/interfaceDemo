

#import <Foundation/Foundation.h>
#import "YZGEzgRefund.h"
@class Orderdetails;
@interface YZGOrderDetailModel : NSObject

@property (nonatomic, assign) CGFloat productPrice;     /**< 产品价格 */
@property (nonatomic, assign) NSInteger productQty;       /**< 购买数量 */
@property (nonatomic, assign) int orderDetailNode;       /**< 退款状态 0-正常  1-退款中 2-退款成功 */
@property (nonatomic, assign) NSInteger addDate;          /**< 订单创建时间 */

@property (nonatomic, strong) NSString *orderDetailCode;     /**< 订单编号-用 */
@property (nonatomic, strong) NSString *orderDetailId;     /**< 单个订单详情id */
@property (nonatomic, strong) NSString *productID;     /**< 产品ID */

@property (nonatomic, strong) NSString *brandCode;     /**< 商店code */

@property (nonatomic, strong) Orderdetails *productDetail;     /**< 产品详情 */

@property (nonatomic, strong) YZGEzgRefund *ezgRefund;     /**< 退款详情*/

@property (nonatomic, strong) NSString *remarks;     /**< 产品备注 */




@end


@interface Orderdetails : NSObject

@property (nonatomic, strong) NSString *brandName;     /**< 品牌名称 */

@property (nonatomic, strong) NSString *style;         /**<  产品风格 */

@property (nonatomic, strong) NSString *productNum;     /**<  产品类型 */

@property (nonatomic, strong) NSString *specHeight;    /**< 产品高度 */

@property (nonatomic, strong) NSString *specWidth;    /**< 产品宽度 */

@property (nonatomic, strong) NSString *specLength;    /**< 长度 */
@property (nonatomic, strong) NSString *path;    /**< 产品图片地址 */

@property (nonatomic, strong) NSString *seqid;     /**< 产品id */

@property (nonatomic, strong) NSString *productType;     /**< 产品类型 */


@end




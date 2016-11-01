

#import <Foundation/Foundation.h>

/**< 物流公司Model */
@interface YZGExpressModel : NSObject

@property (nonatomic, strong) NSString *logisticsId;     /**< 地址id */
@property (nonatomic, strong) NSString *logisticsName;      /**< 物流名称 */
@property (nonatomic, strong) NSString *logisticsPhone;     /**< 电话 */
@property (nonatomic, strong) NSString *logisticsPCAS;     /**< 地区 */
@property (nonatomic, strong) NSString *logisticsAddress;     /**< 详细地区 */
@property (nonatomic, strong) NSString *logisticsDesc;     /**< 备注 */
@property (nonatomic, strong) NSString *isDefault;        /**< 0，1   状态 1-是默认地址  */

@property (nonatomic, strong) NSString *logisticsProvince;
@property (nonatomic, strong) NSString *logisticsCity;
@property (nonatomic, strong) NSString *logisticsArea;


@end




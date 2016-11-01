

#import <Foundation/Foundation.h>


@interface YZGAddressModel : NSObject



@property (nonatomic, strong) NSString *deliverName;      /**< 名字 */
@property (nonatomic, strong) NSString *deliverNicName;     /**< 公司名 */

@property (nonatomic, strong) NSString *deliverPhone;     /**< 电话 */
@property (nonatomic, strong) NSString *deliverAddress;     /**< 详细地址 */
@property (nonatomic, strong) NSString *deliverPCAS;     /**< 省市区 */

@property (nonatomic, strong) NSString *deliverLogic;     /**< 物流信息  德邦物流(0760-88888888) */

@property (nonatomic, strong) NSString *isDefault;     /**< 0，1   状态 1-是默认地址  */

@property (nonatomic, strong) NSString *deliverId;     /**< 地址id */

@property (nonatomic, strong) NSString * deliverProvice;     /**< 省编码 */
@property (nonatomic, strong) NSString * deliverCity;     /**< 市编码 */
@property (nonatomic, strong) NSString * deliverArea;     /**< 县/区编码 */



@end






#import <Foundation/Foundation.h>
#import "ProductDetail.h"

@interface YZGMyCollecProductModel : NSObject

@property (nonatomic, strong) NSString *favoriteId;   /**< 收藏id */

@property (nonatomic, strong) ProductDetail *productDetail;     /**< 产品详情 */


@end




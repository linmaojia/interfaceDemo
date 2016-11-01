

#import <Foundation/Foundation.h>
#import "ProductDetail.h"

/* 爆款推荐model*/
@interface YZGExplosionModel : NSObject

@property (nonatomic, strong) NSString *eGoodsId;

@property (nonatomic, strong) ProductDetail *productDetail;     /**< 产品详情 */


@end




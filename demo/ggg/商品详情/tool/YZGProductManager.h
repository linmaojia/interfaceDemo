//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGProductDetailModel.h"

typedef void (^ProductDetailCallback)(YZGProductDetailModel *model);
@interface YZGProductManager : NSObject

/**< 获取商品详情Model */
- (void)getProductDetailWithProductId:(NSString *)productId target:(id)target CallBack:(ProductDetailCallback)productDetailCallback;

/**< 获取图片数组 */
- (NSArray *)getImageViewUrlArray;

/**< 获取规格参数数组 */
+ (NSArray *)getOneSectionTitleArray:(YZGProductDetailModel *)model;


@end

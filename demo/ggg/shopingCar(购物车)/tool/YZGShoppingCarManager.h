//
//  YZGShoppingCarManager.h
//  ggg
//
//  Created by LXY on 16/9/29.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJShoppingCarModel.h"


@interface YZGShoppingCarManager : NSObject

@property (nonatomic, strong) NSMutableArray *dataArray;   /**< 数据数组 */

- (NSMutableArray *)getCarIDArray; /**< 获取选中购物车id数组 */

- (NSMutableArray *)getProductIDArray; /**< 获取选中购物车产品id数组 */

- (BOOL)isStocksInsufficient; /**< 判断是否库存不足 */

- (NSMutableArray *)updateDataArray; /**< 清除没有选中的数据 */
@end

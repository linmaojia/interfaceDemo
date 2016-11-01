//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGAllBrandModel.h"

@interface YZGAllBrandManager : NSObject
typedef void (^AllBrandCallback)(YZGAllBrandModel *model);
/**< 获取品牌大全 */
- (void)getAllBrandWithDic:(NSDictionary *)dic Target:(id)target CallBack:(AllBrandCallback)allBrandCallback;
@end

//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YZGProductListManager : NSObject

typedef void (^ProductListCallback)(NSArray *listArray);
/**< 获取表视图商品列表数组 */
- (void)getroductListWithDic:(NSMutableDictionary *)dic target:(id)target CallBack:(ProductListCallback)productListCallback;


@end

//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YZGRankingListManager : NSObject

typedef void (^RankingListCallback)(NSArray *array);
/**< 获取排行版商品列表数组 */
- (void)getRankingListWithDic:(NSDictionary *)dic target:(id)target CallBack:(RankingListCallback)rankingListCallback;

@end

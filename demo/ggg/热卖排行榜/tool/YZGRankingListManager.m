//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRankingListManager.h"
#import "ProductDetail.h"
@interface YZGRankingListManager ()

@end
@implementation YZGRankingListManager
/**< 获取排行版商品列表数组 */
- (void)getRankingListWithDic:(NSDictionary *)dic target:(id)target CallBack:(RankingListCallback)rankingListCallback
{
  
    [SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    
    [[SVHTTPClient sharedClient] GET:APIHotProductListPath parameters:dic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        if (error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                    //NSString *errorString = response[@"message"];
                    
                    NSArray *array =[NSArray array];
                    rankingListCallback(array);
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }
        else
        {
            
            NSArray *array = [ProductDetail mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            
            rankingListCallback(array);
        }
    }];

}
@end

//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGAllBrandManager.h"


@interface YZGAllBrandManager ()

@end
@implementation YZGAllBrandManager
- (void)getAllBrandWithDic:(NSDictionary *)dic Target:(id)target CallBack:(AllBrandCallback)allBrandCallback
{
    [SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIAllBrandsPath parameters:dic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        if (error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }
        else
        {
               YZGAllBrandModel *allBandmodel = [YZGAllBrandModel mj_objectWithKeyValues:(NSDictionary *)response];
//
                allBrandCallback(allBandmodel);
        }
    }];

}
@end

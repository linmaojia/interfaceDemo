//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductListManager.h"
#import "ProductDetail.h"
@interface YZGProductListManager ()

@end
@implementation YZGProductListManager

- (void)getroductListWithDic:(NSMutableDictionary *)dic target:(id)target CallBack:(ProductListCallback)productListCallback
{
    NSNumber *page = dic[@"begin"];
    
    if([page integerValue] == 1)
    {
        [SVProgressHUD show];
    }
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
  
    [[SVHTTPClient sharedClient] GET:APIProductListPath parameters:dic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
       [SVProgressHUD dismiss];
        if (error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                    //NSString *errorString = response[@"message"];
                    
                    NSArray *array =[NSArray array];
                    productListCallback(array);
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
               productListCallback(array);
        }
    }];
}

@end

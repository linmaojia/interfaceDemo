//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGClassifyManager.h"
#import "YZGClassifylModel.h"
@interface YZGClassifyManager ()

@end
@implementation YZGClassifyManager
- (void)getClassifyListWithTarget:(id)target CallBack:(ClassifyListCallback)classifyListCallback
{
    [SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIClassifyList parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        [SVProgressHUD dismiss];
        if (error)
        {
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"])
                {
                    //NSString *errorString = response[@"message"];
//                    NSArray *array =[NSArray array];
//                    classifyListCallback(array);
                }
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请求失败"];
            }
        }
        else
        {
            
            NSArray *array = [YZGClassifylModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            
            classifyListCallback(array);
        }
    }];
}
@end

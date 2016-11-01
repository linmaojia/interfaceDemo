//
//  SVHTTPClient+OrderAddShoppingCar.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/18.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+OrderAddShoppingCar.h"

@implementation SVHTTPClient (OrderAddShoppingCar)

+ (void)orderBuyAgainWithOrderID:(NSString *)orderID callBack:(OrderAddShoppingCar)callback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
     NSString *url = [APIOrderBuyAgain stringByAppendingString:orderID];
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            
            if ([response isKindOfClass:[NSDictionary class]])
            {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SVProgressHUD showErrorWithStatus:errorString];
                    });
                    
                }
                
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"添加失败,请检查网络"];
            }
            callback(NO);
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD  showSuccessWithStatus:@"加入采购单成功！"];
            });

            
            callback(YES);
        }
    }];
}

@end

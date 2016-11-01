//
//  SVHTTPClient+ShoppingCarDelete.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+OrderDelete.h"

@implementation SVHTTPClient (OrderDelete)

+ (void)orderDeleteWithOrderId:(NSString *)orderId callBack:(OrderDeleteCallback)orderDeleteCallback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
     NSString *url = [APIOrderDelete stringByAppendingString:orderId];
    
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];

            orderDeleteCallback(NO);
        }
        else {
            
            [SVProgressHUD  showSuccessWithStatus:@"删除成功"];
            
            orderDeleteCallback(YES);
        }
    }];
}

@end

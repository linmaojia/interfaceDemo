//
//  SVHTTPClient+ShoppingCarDelete.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+OrderCancel.h"

@implementation SVHTTPClient (OrderCancel)

+ (void)orderCancelWithOrderId:(NSString *)orderId callBack:(OrderCancelCallback)orderCancelCallback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
     NSString *url = [APIOrderCancel stringByAppendingString:orderId];
    
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            [SVProgressHUD showErrorWithStatus:@"取消失败"];

            orderCancelCallback(NO);
        }
        else {
            NSDictionary *dic = (NSDictionary *)response;
            NSInteger status = [dic[@"status"] integerValue];
            if(status == 200)
            {
                 [SVProgressHUD  showSuccessWithStatus:@"取消成功"];
                 orderCancelCallback(YES);
            }
    
            
        }
    }];
}

@end

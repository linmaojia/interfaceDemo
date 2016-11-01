//
//  SVHTTPClient+OrderConfirm.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/6.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+OrderConfirm.h"

@implementation SVHTTPClient (OrderConfirm)

+ (void)orderConfirmWithOrderID:(NSString *)orderID callBack:(OrderConfirm)orderDeleteCallback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
     NSString *url = [APIOrderReceipt stringByAppendingString:orderID];
    [[SVHTTPClient sharedClient] GET:url  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            [SVProgressHUD showErrorWithStatus:@"确认收货失败"];
            orderDeleteCallback(NO);
        }
        else {
            
            NSDictionary *dic = (NSDictionary *)response;
            NSInteger status = [dic[@"status"] integerValue];
            if(status == 200)
            {
                [SVProgressHUD  showSuccessWithStatus:@"确认收货成功"];
                orderDeleteCallback(YES);
            }
            else
            {
                [SVProgressHUD  showErrorWithStatus:@"确认收货失败"];
            }
            
           

            
        }
    }];
}

@end

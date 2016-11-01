//
//  SVHTTPClient+DefaultReceivingAddress.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+DefaultReceivingAddress.h"

@implementation SVHTTPClient (DefaultReceivingAddress)

+ (void)setDefaultReceivingAddressWithAddrId:(NSString *)addrId CallBack:(DefaultReceivingAddressCallback)defaultReceivingAddressCallback {
    
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:[APIDefultAddress stringByAppendingString:addrId] parameters:@{@"addrId":addrId} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
                
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"设置失败"];
            }
             [SVProgressHUD dismiss];
            defaultReceivingAddressCallback(NO);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];

            });
            
            
            defaultReceivingAddressCallback(YES);
        }
    }];
}

@end

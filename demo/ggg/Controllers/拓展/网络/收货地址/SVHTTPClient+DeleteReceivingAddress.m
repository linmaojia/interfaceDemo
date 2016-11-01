//
//  SVHTTPClient+DeleteReceivingAddress.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+DeleteReceivingAddress.h"

@implementation SVHTTPClient (DeleteReceivingAddress)

+ (void)deleteReceivingAddressWithAddrId:(NSString *)addrId CallBack:(DeleteReceivingAddressCallback)deleteReceivingAddressCallback {
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:[APIDeleteAddress stringByAppendingString:addrId] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            NSLog(@"%@",error);
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                   [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
            deleteReceivingAddressCallback(NO);
        }
        else
        {
             [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            deleteReceivingAddressCallback(YES);
        }
    }];
}

@end

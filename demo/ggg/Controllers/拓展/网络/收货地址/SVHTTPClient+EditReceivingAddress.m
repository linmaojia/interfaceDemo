//
//  SVHTTPClient+EditReceivingAddress.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/2.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+EditReceivingAddress.h"

@implementation SVHTTPClient (EditReceivingAddress)

+ (void)editReceivingAddressWithParameters:(NSDictionary *)parameters CallBack:(EditReceivingAddressCallback)editReceivingAddressCallback {
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] POST:APIEditAddress parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
       // NSLog(@"%@",parameters);
        
        if(error)
        {
            NSLog(@"%@",error);
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
            editReceivingAddressCallback(NO);
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            editReceivingAddressCallback(YES);
        }
    }];
}

@end

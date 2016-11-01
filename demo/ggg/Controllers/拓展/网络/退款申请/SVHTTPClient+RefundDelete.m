//
//  SVHTTPClient+DrawbackRequset.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+RefundDelete.h"

@implementation SVHTTPClient (RefundDelete)
+ (void)refundDeleteWithRefundId:(NSString *)refundId callBack:(RefundDeleteCallback)callback {
    [SVProgressHUD showWithStatus:@"正在撤销"];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    NSString *url = [APIDeleteInformation stringByAppendingString:refundId];
    
    
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                if ([error.localizedDescription isEqualToString:@"The operation timed out."]) {
                    [SVProgressHUD showErrorWithStatus:@"请求超时"];
                } else {
                    [SVProgressHUD showErrorWithStatus:@"申请失败"];
                }
            }
            callback(NO,nil);
        }
        else {
            [SVProgressHUD showSuccessWithStatus:@"撤销成功"];
            NSLog(@"%@",response);
            NSDictionary *ezgRefund = response[@"ezgRefund"];
            callback(YES,ezgRefund);
            
        }
    }];
}
@end

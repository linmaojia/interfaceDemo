//
//  SVHTTPClient+DrawbackRequset.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+DrawbackRequset.h"

@implementation SVHTTPClient (DrawbackRequset)
+ (void)drawbackRequsetWithParameters:(NSDictionary *)parameters callBack:(DrawbackRequsetCallback)callback {
    [SVProgressHUD showWithStatus:@"正在提交退款申请信息"];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
     NSLog(@"%@",parameters);
    [[SVHTTPClient sharedClient] POST:APIDrawbackInformation parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
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
            callback(NO, nil);
        }
        else {
              [SVProgressHUD showSuccessWithStatus:@"申请成功"];
              NSLog(@"%@",parameters);
            
              callback(YES, response);
            
        }
    }];
}
@end

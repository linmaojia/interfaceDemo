//
//  SVHTTPClient+ShoppingCarPay.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarRemark.h"

@implementation SVHTTPClient (ShoppingCarRemark)

+ (void)shoppingRemarkWithProductIds:(NSDictionary *)remarkDic callBack:(ShoppingCarRemarkCallback)shoppingCarRemarkCallback {
    [SVProgressHUD show];

    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    
    [[SVHTTPClient sharedClient] POST:APIShoppingCarRemark parameters:remarkDic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }
             shoppingCarRemarkCallback(NO);
        }
        else
        {
             [SVProgressHUD showSuccessWithStatus:@"修改成功"];
             shoppingCarRemarkCallback(YES);
        }
    }];
    
}

@end

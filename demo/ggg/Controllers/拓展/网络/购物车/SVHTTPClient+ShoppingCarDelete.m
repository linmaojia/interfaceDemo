//
//  SVHTTPClient+ShoppingCarDelete.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarDelete.h"

@implementation SVHTTPClient (ShoppingCarDelete)

+ (void)shoppingCarDeleteWithProductId:(NSString *)cartId callBack:(ShoppingCarDeleteCallback)shoppingCarDeleteCallback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
     NSString *url = [APIShoppingCarDelete stringByAppendingString:cartId];
    
    [[SVHTTPClient sharedClient] GET:url parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            [SVProgressHUD showErrorWithStatus:@"删除失败"];
            
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                  
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
             
            }
            shoppingCarDeleteCallback(NO);
        }
        else {
            
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
           
            shoppingCarDeleteCallback(YES);
        }
    }];
}

@end

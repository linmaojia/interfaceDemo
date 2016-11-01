//
//  SVHTTPClient+ShoppingCarPay.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarAddCollect.h"

@implementation SVHTTPClient (ShoppingCarAddCollect)

+ (void)shoppingCollectWithProductIds:(NSArray *)productIds callBack:(ShoppingCarCollectCallback)shoppingCarCollectCallback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    NSDictionary *dic = @{@"productIds":productIds};
    
    [[SVHTTPClient sharedClient] POST:APIShoppingCarAddCollect parameters:dic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        //NSLog(@"%@",parameters);
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
            }
             shoppingCarCollectCallback(NO);
        }
        else
        {
             [SVProgressHUD showSuccessWithStatus:@"添加成功"];
             shoppingCarCollectCallback(YES);
        }
    }];
    
}

@end

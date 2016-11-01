//
//  SVHTTPClient+ShoppingCarCount.m
//  ETao
//
//  Created by AVGD－Mai on 16/4/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarCount.h"

@implementation SVHTTPClient (ShoppingCarCount)

+ (void)shoppingCarCountCallBack:(ShoppingCarCount)callback {
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIShoppingCarCount parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            
        } else {
            callback([response intValue]);
        }
    }];
}

@end

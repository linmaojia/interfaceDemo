//
//  SVHTTPClient+ShoppingCarPay.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarDeleArray.h"

@implementation SVHTTPClient (ShoppingCarDeleArray)

+ (void)shoppingDeleWithCartIds:(NSArray *)cartIds callBack:(ShoppingCarDeleArrayCallback)shoppingCarDeleArrayCallback {
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    NSDictionary *dic = @{@"cartIds":cartIds};
    
    [[SVHTTPClient sharedClient] POST:APIShoppingCarDeleteArray parameters:dic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        //NSLog(@"%@",parameters);
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
             shoppingCarDeleArrayCallback(NO);
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            
            shoppingCarDeleArrayCallback(YES);
        }
    }];
    
}

@end

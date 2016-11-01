//
//  SVHTTPClient+ShoppingCarPay.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarAdd.h"
@implementation SVHTTPClient (ShoppingCarAdd)

+ (void)shoppingCarAddWithDic:(NSDictionary *)dic callBack:(ShoppingCarAddCallback)shoppingCarAddCallback {
//    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] POST:APIAddShopingCar parameters:dic completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"添加失败,请检查网络状态"];
            }
             shoppingCarAddCallback(NO,0);
        }
        else
        {
            NSDictionary *dic = (NSDictionary *)response;
            NSInteger status = [dic[@"status"] integerValue];
            if(status == 5001)
            {
                [SVProgressHUD  showErrorWithStatus:dic[@"message"]];
            }
            else
            {
                [[[SVHTTPClient alloc]init] shoppingCarCountCallBack:shoppingCarAddCallback];
            }
        }
    }];
    
}
- (void)shoppingCarCountCallBack:(ShoppingCarAddCallback)callback {
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIShoppingCarCount parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            
        } else {
            callback(YES,[response intValue]);

        }
    }];
}


@end

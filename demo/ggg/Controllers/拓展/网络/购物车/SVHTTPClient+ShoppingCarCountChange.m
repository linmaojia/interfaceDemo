//
//  SVHTTPClient+ShoppingCarCountChange.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ShoppingCarCountChange.h"

@implementation SVHTTPClient (ShoppingCarCountChange)

+ (void)shoppingCarCountChangeWithCarId:(NSString *)seqId productQty:(NSInteger)productQty callBack:(ShoppingCarCountChangeCallback)shoppingCarCountChangeCallbackCallback {
    //[SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    
    [[SVHTTPClient sharedClient] POST:APIShoppingCarCountChange parameters:@{@"seqId":seqId,@"count":@(productQty)} completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    NSLog(@"%@",errorString);
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showImage:nil status:@"修改失败，请重试"];
            }
            shoppingCarCountChangeCallbackCallback(NO);
        }
        else {
            //[SVProgressHUD showImage:nil status:@"修改成功"];
            shoppingCarCountChangeCallbackCallback(YES);
        }
    }];
}

@end

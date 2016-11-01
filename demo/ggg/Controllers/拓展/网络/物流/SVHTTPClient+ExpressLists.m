//
//  SVHTTPClient+SameProducts.m
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+ExpressLists.h"


@implementation SVHTTPClient (ExpressLists)
/* 获取物流地址列表 */
+ (void)getExpressListsWithTarget:(id)target CallBack:(ExpressListsCallback)expressListsCallback{
    [SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
    
    [[SVHTTPClient sharedClient] GET:APILogisticsList parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        [SVProgressHUD dismiss];
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }
        else
        {
            NSArray *dataArray = [YZGExpressModel mj_objectArrayWithKeyValuesArray:response];
            
            expressListsCallback(dataArray);
        }
        
    }];
}
/* 获取默认物流 */
+ (void)getDefaultExpressWithTarget:(id )target CallBack:(DefaultExpressCallback)defaultExpressCallback
{
    
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIGetDefultLogistics  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            //没有收货地址
            if(error.code == 406)
            {
                defaultExpressCallback(nil,NO);
            }
            else
            {
                if ([response isKindOfClass:[NSDictionary class]])
                {
                    if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                        NSString *errorString = response[@"message"];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [SVProgressHUD showErrorWithStatus:errorString];
                            
                            
                        });
                        
                    }
                    
                }
            }
            
        }
        else
        {
            YZGExpressModel *model = [YZGExpressModel mj_objectWithKeyValues:(NSDictionary *)response];
            defaultExpressCallback(model,YES);
        }
    }];
}
/* 添加物流地址 */
+ (void)addExpressWithParameters:(NSDictionary *)parameters CallBack:(AddExpressCallback)addExpressCallback
{
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] POST:APIAddLogistics parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
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
            addExpressCallback(NO);
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"添加成功"];
            addExpressCallback(YES);
        }
    }];
}
/* 删除物流 */
+ (void)deleteExpressWithAddrId:(NSString *)addrId CallBack:(DeleteExpressCallback)deleteExpressCallback{
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:[APIDeleteLogistics stringByAppendingString:addrId] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            NSLog(@"%@",error);
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"删除失败"];
            }
            deleteExpressCallback(NO);
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"删除成功"];
            deleteExpressCallback(YES);
        }
    }];
    
}
/* 设置默认物流 */
+ (void)setDefaultExpressWithAddrId:(NSString *)addrId CallBack:(SetDefaultExpressCallback)setDefaultExpressCallback
{
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:[APIDefultLogistics stringByAppendingString:addrId] parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    [SVProgressHUD showErrorWithStatus:errorString];
                }
            } else {
                [SVProgressHUD showErrorWithStatus:@"设置失败"];
            }
            [SVProgressHUD dismiss];
            setDefaultExpressCallback(NO);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"设置成功"];
                
            });
            
            
            setDefaultExpressCallback(YES);
        }
    }];
}
+ (void)editExpressWithParameters:(NSDictionary *)parameters CallBack:(EditExpressCallback)editExpressCallback
{
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] POST:APIEditLogistics parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
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
            editExpressCallback(NO);
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"修改成功"];
            editExpressCallback(YES);
        }
    }];
}
@end

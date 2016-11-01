//
//  SVHTTPClient+OrderAdd.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/2.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+OrderAdd.h"

@implementation SVHTTPClient (OrderAdd)
+ (void)orderAddWithCarIds:(NSMutableArray *)carIdArray AdderssId:(NSString *)adderssId LogisticsId:(NSString *)logisticsId RemarkDic:(NSDictionary *)remark callBack:(OrderAddCallback)orderAddCallback{
    [SVProgressHUD show];
    
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    NSDictionary *parameters = @{@"cartIds":carIdArray,@"deliverId":adderssId,@"orderDescs":remark,@"logisticsId":logisticsId};
    
    [[SVHTTPClient sharedClient] POST:APIOrderAdd parameters:parameters completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        //NSLog(@"parameters====%@, API======%@",parameters,APIAddShopingCar);
        
        if(error) {
            if ([response isKindOfClass:[NSDictionary class]]) {
                if ([[(NSDictionary *)response allKeys] containsObject:@"message"]) {
                    NSString *errorString = response[@"message"];
                    
                    //判断是否存在:
                    if([errorString rangeOfString:@":"].location == NSNotFound )
                    {
                        NSLog(@"不存在");
                        [SVProgressHUD showErrorWithStatus:errorString];
                    }
                    else
                    {
                        NSLog(@"存在");
                        NSRange theRange=[errorString rangeOfString:@":"];//取出字符串
                        NSString *str = [errorString substringWithRange:NSMakeRange(theRange.location+1,errorString.length-theRange.location-1)];
                        [SVProgressHUD showErrorWithStatus:str];
                        orderAddCallback(nil,NO,errorString);
                    }
                    
                    
                }
            } else {
                [SVProgressHUD showImage:nil status:@"提交订单失败,请稍后再试"];
                orderAddCallback(nil,NO,nil);
            }            
        }
        else {
            //[SVProgressHUD dismiss];
            
            NSDictionary *dic = (NSDictionary *)response;

            orderAddCallback(dic[@"orderIds"], YES, nil);
        }
    }];
}
@end

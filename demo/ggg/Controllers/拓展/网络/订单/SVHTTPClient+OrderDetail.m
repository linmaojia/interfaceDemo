//
//  SVHTTPClient+SameProducts.m
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+OrderDetail.h"
#import "YZGNextOhterDetailModel.h"

@implementation SVHTTPClient (OrderDetail)

+ (void)getOrderDetailWithOtherId:(NSString *)otherId  target:(id)target CallBack:(OrderDetailCallback)orderDetailCallback
{


    [SVProgressHUD show];
    //配置全局请求头
     [[SVHTTPClient sharedClient] setGlobalHeaderField];
     [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
    
      NSString *url = [APIOrderDetail stringByAppendingString:otherId];
    
    [[SVHTTPClient sharedClient] GET:url  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
       
             [SVProgressHUD showErrorWithStatus:@"网络出错"];
           
        }
        else
        {
            [SVProgressHUD dismiss];
            YZGNextOhterDetailModel *model = [YZGNextOhterDetailModel mj_objectWithKeyValues:(NSDictionary *)response];
            orderDetailCallback(model);
        }
    }];
}

@end

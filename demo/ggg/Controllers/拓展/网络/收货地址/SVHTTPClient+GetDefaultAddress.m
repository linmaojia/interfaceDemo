//
//  SVHTTPClient+DefaultReceivingAddress.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+GetDefaultAddress.h"
#import "YZGAddressModel.h"
//获取默认收货地址
@implementation SVHTTPClient (GetDefaultAddress)

+ (void)getDefaultAddressWithTarget:(id)target CallBack:(DefaultAddressCallback)defaultAddressCallback {
    
    [SVProgressHUD show];
    
    //配置请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [SVHTTPClient sharedClient].sendParametersAsJSON = YES;
    
    [[SVHTTPClient sharedClient] GET:APIGetDefultAddress  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        if(error)
        {
            if(error.code == 406)//没有收货地址
            {
                [SVProgressHUD dismiss];
                defaultAddressCallback(nil,NO);
            }
            else
            {
                [SVProgressHUD showErrorWithStatus:@"请检查网络设置"];
            }
            
        }
        else
        {
            [SVProgressHUD dismiss];
            YZGAddressModel *model = [YZGAddressModel mj_objectWithKeyValues:(NSDictionary *)response];
            defaultAddressCallback(model,YES);
        }
    }];
}

@end

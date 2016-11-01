//
//  SVHTTPClient+SameProducts.m
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+AdderssLists.h"
#import "YZGAddressModel.h"
#import "YZGUserAddressSettingVC.h"

@implementation SVHTTPClient (AdderssLists)

+ (void)getAdderssListsWithTarget:(id)target CallBack:(AdderssListsCallback)adderssListsCallback{
    [SVProgressHUD show];
    //配置全局请求头
    [[SVHTTPClient sharedClient] setGlobalHeaderField];
    [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
  
    [[SVHTTPClient sharedClient] GET:APIGetAddressList parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {

       [SVProgressHUD dismiss];
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }
        else
        {
            NSArray *dataArray = [YZGAddressModel mj_objectArrayWithKeyValuesArray:response];
            
            adderssListsCallback(dataArray);
        }
  
    }];
}

@end

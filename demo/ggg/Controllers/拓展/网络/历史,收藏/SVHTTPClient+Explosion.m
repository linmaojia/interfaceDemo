//
//  SVHTTPClient+SameProducts.m
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient+Explosion.h"
#import "YZGExplosionModel.h"

@implementation SVHTTPClient (Explosion)

+ (void)getOrderListWithCallBack:(ExplosionArrayCallback)explosionArrayCallback{

    //配置全局请求头
     [[SVHTTPClient sharedClient] setGlobalHeaderField];
     [[SVHTTPClient sharedClient] setSendParametersAsJSON:YES];
 
    [[SVHTTPClient sharedClient] GET:APIProductExplosion  parameters:nil completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *error) {
       
        if(error)
        {
            [SVProgressHUD showErrorWithStatus:@"网络错误"];
        }
        else
        {
            
            NSArray *array = [YZGExplosionModel mj_objectArrayWithKeyValuesArray:(NSArray *)response];
            NSLog(@"%ld",array.count);
            explosionArrayCallback(array);
        }
    }];
}

@end

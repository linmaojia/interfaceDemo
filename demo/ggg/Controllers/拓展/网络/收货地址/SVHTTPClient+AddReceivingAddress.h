//
//  SVHTTPClient+AddReceivingAddress.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//添加收货地址 yes为 成功
typedef void (^AddReceivingAddressCallback)(BOOL addReceivingAddressState);

@interface SVHTTPClient (AddReceivingAddress)

/* 添加收货地址 */
+ (void)addReceivingAddressWithParameters:(NSDictionary *)parameters CallBack:(AddReceivingAddressCallback)addReceivingAddressCallback;

@end

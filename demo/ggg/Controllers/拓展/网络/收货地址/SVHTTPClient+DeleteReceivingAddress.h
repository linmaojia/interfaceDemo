//
//  SVHTTPClient+DeleteReceivingAddress.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//删除收货地址 yes为 成功
typedef void (^DeleteReceivingAddressCallback)(BOOL deleteReceivingAddressState);

@interface SVHTTPClient (DeleteReceivingAddress)


/* 删除收货地址 */
+ (void)deleteReceivingAddressWithAddrId:(NSString *)addrId CallBack:(DeleteReceivingAddressCallback)deleteReceivingAddressCallback;

@end

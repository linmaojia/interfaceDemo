//
//  SVHTTPClient+DefaultReceivingAddress.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//设置默认收货地址 yes为 成功
typedef void (^DefaultReceivingAddressCallback)(BOOL defaultReceivingAddressState);

@interface SVHTTPClient (DefaultReceivingAddress)

/* 设置默认地址 */
+ (void)setDefaultReceivingAddressWithAddrId:(NSString *)addrId CallBack:(DefaultReceivingAddressCallback)defaultReceivingAddressCallback;
@end

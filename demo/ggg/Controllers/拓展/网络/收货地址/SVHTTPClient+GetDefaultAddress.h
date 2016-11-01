//
//  SVHTTPClient+DefaultReceivingAddress.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
#import "YZGAddressModel.h"
//获取默认收货地址
typedef void (^DefaultAddressCallback)(YZGAddressModel *defultAddressModel, BOOL isHaveDefaultAddress);

@interface SVHTTPClient (GetDefaultAddress)

/* 获取默认地址 */
+ (void)getDefaultAddressWithTarget:(id )target CallBack:(DefaultAddressCallback)defaultAddressCallback;
@end

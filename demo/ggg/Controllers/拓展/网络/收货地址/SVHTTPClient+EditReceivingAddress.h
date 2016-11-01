//
//  SVHTTPClient+EditReceivingAddress.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/2.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//修改收货地址 yes为 成功
typedef void (^EditReceivingAddressCallback)(BOOL editReceivingAddressState);

@interface SVHTTPClient (EditReceivingAddress)

/* 修改收货地址 */
+ (void)editReceivingAddressWithParameters:(NSDictionary *)parameters CallBack:(EditReceivingAddressCallback)editReceivingAddressCallback;
@end

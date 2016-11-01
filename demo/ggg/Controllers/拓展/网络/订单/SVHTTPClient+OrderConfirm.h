//
//  SVHTTPClient+OrderConfirm.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/6.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//确认订单，确认状态 YES为成功
typedef void (^OrderConfirm)(BOOL state);

@interface SVHTTPClient (OrderConfirm)

/* 确认收货 */
+ (void)orderConfirmWithOrderID:(NSString *)orderID callBack:(OrderConfirm)orderDeleteCallback;

@end

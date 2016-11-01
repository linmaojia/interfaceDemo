//
//  SVHTTPClient+ShoppingCarDelete.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//订单取消状态 yes为 成功
typedef void (^OrderCancelCallback)(BOOL orderCancelState);

@interface SVHTTPClient (OrderCancel)


 /* 订单取消*/
+ (void)orderCancelWithOrderId:(NSString *)orderId callBack:(OrderCancelCallback)orderCancelCallback;
@end

//
//  SVHTTPClient+ShoppingCarDelete.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//订单删除状态 yes为 成功
typedef void (^OrderDeleteCallback)(BOOL orderDeleteState);

@interface SVHTTPClient (OrderDelete)


 /* 订单删除*/
+ (void)orderDeleteWithOrderId:(NSString *)orderId callBack:(OrderDeleteCallback)orderDeleteCallback;
@end

//
//  SVHTTPClient+OrderAddShoppingCar.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/18.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//订单再买状态 YES为成功
typedef void (^OrderAddShoppingCar)(BOOL state);

@interface SVHTTPClient (OrderAddShoppingCar)

/* 订单再买*/
+ (void)orderBuyAgainWithOrderID:(NSString *)orderID callBack:(OrderAddShoppingCar)callback;

@end

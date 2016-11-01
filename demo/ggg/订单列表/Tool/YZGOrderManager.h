//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger,OrderStatus) {
    OrderStatusAll ,
    OrderStatusNonPayment ,
    OrderStatusNonDelive ,
    OrderStatusNonReceive ,
    OrderStatusFinish ,
    OrderStatusCancel
};
typedef void (^OrderListCallback)(NSArray *orderCarListArray);

@interface YZGOrderManager : NSObject

- (void)getOrderListWithPageNum:(NSInteger)PageNum orderStatus:(OrderStatus)orderStatus target:(id)target CallBack:(OrderListCallback)orderListCallback;

@end

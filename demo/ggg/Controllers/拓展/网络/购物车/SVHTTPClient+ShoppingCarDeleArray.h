//
//  SVHTTPClient+ShoppingCarPay.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
//将购物车删除（数组类型） yes为 成功
typedef void (^ShoppingCarDeleArrayCallback)(BOOL deleArrayState);

@interface SVHTTPClient (ShoppingCarDeleArray)

+ (void)shoppingDeleWithCartIds:(NSArray *)cartIds callBack:(ShoppingCarDeleArrayCallback)shoppingCarDeleArrayCallback;

@end

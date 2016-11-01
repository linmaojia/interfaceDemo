//
//  SVHTTPClient+ShoppingCarPay.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
//将购物车移入收藏 yes为 成功
typedef void (^ShoppingCarCollectCallback)(BOOL addCollectState);

@interface SVHTTPClient (ShoppingCarAddCollect)

+ (void)shoppingCollectWithProductIds:(NSArray *)productIds callBack:(ShoppingCarCollectCallback)shoppingCarCollectCallback;

@end

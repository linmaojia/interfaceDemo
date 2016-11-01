//
//  SVHTTPClient+ShoppingCarCount.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//购物车数量状态 yes为 成功
typedef void (^ShoppingCarCount)(int count);

@interface SVHTTPClient (ShoppingCarCount)

/**
 *  @author Mai, 16-02-29 19:02:23
 *
 *  购物车商品数量
 */
+ (void)shoppingCarCountCallBack:(ShoppingCarCount)callback;

@end
//
//  SVHTTPClient+ShoppingCarPay.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
//将商品添加到购物车 yes为 成功,count 为购物车商品数量
typedef void (^ShoppingCarAddCallback)(BOOL state,int count);
@interface SVHTTPClient (ShoppingCarAdd)

+ (void)shoppingCarAddWithDic:(NSDictionary *)dic callBack:(ShoppingCarAddCallback)shoppingCarAddCallback;



@end

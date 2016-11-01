//
//  SVHTTPClient+ShoppingCarPay.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/29.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
//修改购物车备注
typedef void (^ShoppingCarRemarkCallback)(BOOL stase);

@interface SVHTTPClient (ShoppingCarRemark)

+ (void)shoppingRemarkWithProductIds:(NSDictionary *)remarkDic callBack:(ShoppingCarRemarkCallback)shoppingCarRemarkCallback;

@end

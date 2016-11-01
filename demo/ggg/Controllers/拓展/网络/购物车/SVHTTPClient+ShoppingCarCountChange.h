//
//  SVHTTPClient+ShoppingCarCountChange.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//购物车修改状态 yes为 成功
typedef void (^ShoppingCarCountChangeCallback)(BOOL shoppingCarCountChangeState);

@interface SVHTTPClient (ShoppingCarCountChange)

/* 修改购物车数量*/

+ (void)shoppingCarCountChangeWithCarId:(NSString *)seqId productQty:(NSInteger)productQty callBack:(ShoppingCarCountChangeCallback)shoppingCarCountChangeCallbackCallback;
@end

//
//  SVHTTPClient+ShoppingCarDelete.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//删除购物车状态 yes为 成功
typedef void (^ShoppingCarDeleteCallback)(BOOL shoppingCarDeleteState);

@interface SVHTTPClient (ShoppingCarDelete)
/**
 *  @author Mai, 16-02-29 19:02:23
 *
 *  删除购物车商品 商品id
 */
+ (void)shoppingCarDeleteWithProductId:(NSString *)cartId callBack:(ShoppingCarDeleteCallback)shoppingCarDeleteCallback;
@end

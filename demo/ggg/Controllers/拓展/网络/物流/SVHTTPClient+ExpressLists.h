//
//  SVHTTPClient+SameProducts.h
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
#import "YZGExpressModel.h"

//默认物流列表
typedef void (^ExpressListsCallback)(NSArray *expressLists);
//获取默认物流
typedef void (^DefaultExpressCallback)(YZGExpressModel *defultExpressModel, BOOL state);

//设置默认物流 yes为 成功
typedef void (^SetDefaultExpressCallback)(BOOL state);

//删除收货地址 yes为 成功
typedef void (^DeleteExpressCallback)(BOOL state);

//添加物流地址 yes为 成功
typedef void (^AddExpressCallback)(BOOL state);

//修改物流地址 yes为 成功
typedef void (^EditExpressCallback)(BOOL state);


@interface SVHTTPClient (ExpressLists)

/* 获取物流地址列表 */
+ (void)getExpressListsWithTarget:(id)target CallBack:(ExpressListsCallback)expressListsCallback;

/* 获取默认物流 */
+ (void)getDefaultExpressWithTarget:(id )target CallBack:(DefaultExpressCallback)defaultExpressCallback;

/* 设置默认物流 */
+ (void)setDefaultExpressWithAddrId:(NSString *)addrId CallBack:(SetDefaultExpressCallback)setDefaultExpressCallback;

/* 删除物流 */
+ (void)deleteExpressWithAddrId:(NSString *)addrId CallBack:(DeleteExpressCallback)deleteExpressCallback;

/* 添加物流地址 */
+ (void)addExpressWithParameters:(NSDictionary *)parameters CallBack:(AddExpressCallback)addExpressCallback;

/* 修改收货地址 */
+ (void)editExpressWithParameters:(NSDictionary *)parameters CallBack:(EditExpressCallback)editExpressCallback;
@end

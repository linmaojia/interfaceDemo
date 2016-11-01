//
//  SVHTTPClient+OrderAdd.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/2.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

//提交订单  orderIdStr订单号,添加状态 YES为成功
typedef void (^OrderAddCallback)(NSArray *orderIdArray,BOOL state,NSString *errorMassage);

@interface SVHTTPClient (OrderAdd)

/**
 *  @author Mai, 16-03-02 21:03:00
 *
 *  提交订单
 *
 *  @param carIdArray       购物车id，字符串数组
 *  @param addressId        地址id
 *  @param remark           备注，可选参数
 *  @param orderAddCallback 提交订单 orderIdStr订单号
 *  @LogisticsId            物流id
 
 *
 
 */
+ (void)orderAddWithCarIds:(NSMutableArray *)carIdArray AdderssId:(NSString *)adderssId LogisticsId:(NSString *)logisticsId RemarkDic:(NSDictionary *)remark callBack:(OrderAddCallback)orderAddCallback;

@end

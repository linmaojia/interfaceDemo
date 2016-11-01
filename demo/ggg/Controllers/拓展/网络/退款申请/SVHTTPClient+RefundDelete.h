//
//  SVHTTPClient+DrawbackRequset.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"


//申请退款状态 yes为 成功
typedef void (^RefundDeleteCallback)(BOOL state,NSDictionary *ezgRefund);

@interface SVHTTPClient (RefundDelete)


/*  退款撤销 */
+ (void)refundDeleteWithRefundId:(NSString *)refundId callBack:(RefundDeleteCallback)callback;

@end

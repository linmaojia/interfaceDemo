//
//  SVHTTPClient+DrawbackRequset.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"


//申请退款状态 yes为 成功
typedef void (^RefundModifyCallback)(BOOL state);

@interface SVHTTPClient (RefundModify)


/*  退款信息修改 */
+ (void)refundModifyWithParameters:(NSDictionary *)parameters callBack:(RefundModifyCallback)callback;

@end

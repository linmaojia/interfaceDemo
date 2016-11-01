//
//  SVHTTPClient+DrawbackRequset.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/9.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"


//申请退款状态 yes为 成功
typedef void (^DrawbackRequsetCallback)(BOOL state, NSDictionary *dic);

@interface SVHTTPClient (DrawbackRequset)


/*  上传退款申请信息 */
+ (void)drawbackRequsetWithParameters:(NSDictionary *)parameters callBack:(DrawbackRequsetCallback)callback;

@end

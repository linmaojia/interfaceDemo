//
//  SVHTTPClient+SameProducts.h
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"
#import "YZGNextOhterDetailModel.h"

typedef void (^OrderDetailCallback)(YZGNextOhterDetailModel *detailModel);

@interface SVHTTPClient (OrderDetail)

+ (void)getOrderDetailWithOtherId:(NSString *)otherId  target:(id)target CallBack:(OrderDetailCallback)orderDetailCallback;


@end

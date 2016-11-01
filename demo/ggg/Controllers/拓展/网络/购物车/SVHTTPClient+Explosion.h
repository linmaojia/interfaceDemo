//
//  SVHTTPClient+SameProducts.h
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"


typedef void (^ExplosionArrayCallback)(NSArray *explosionArray);


@interface SVHTTPClient (Explosion)

/*获取为你推荐数组*/
+ (void)getOrderListWithParams:(NSDictionary *)params CallBack:(ExplosionArrayCallback)explosionArrayCallback;



@end

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

//获取爆款推荐数组

+ (void)getOrderListWithCallBack:(ExplosionArrayCallback)explosionArrayCallback;


@end

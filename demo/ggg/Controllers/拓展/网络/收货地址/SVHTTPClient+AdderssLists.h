//
//  SVHTTPClient+SameProducts.h
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

typedef void (^AdderssListsCallback)(NSArray *adderssLists);


@interface SVHTTPClient (AdderssLists)

/* 获取地址列表 */
+ (void)getAdderssListsWithTarget:(id)target CallBack:(AdderssListsCallback)adderssListsCallback;

@end

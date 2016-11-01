//
//  SVHTTPClient+HistoryAllDelete.h
//  ETao
//
//  Created by AVGD－Mai on 16/4/8.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

typedef NS_ENUM(NSInteger, Type) {
    productType  ,    //取消商品收藏
    shopType        //取消商品收藏
    
};
//取消收藏 状态 yes为 成功
typedef void (^CollectCancelCallback)(BOOL state);

@interface SVHTTPClient (CollectCancel)


+ (void)collectCancelOrderType:(Type)type :(NSString *)favoriteId :(CollectCancelCallback)callback;

@end

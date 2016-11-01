//
//  SVHTTPClient+SameProducts.h
//  ETao
//
//  Created by LXY on 16/5/17.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "SVHTTPClient.h"

typedef NS_ENUM(NSInteger, CollectListType) {
    collectProduct  ,    //商品收藏列表类型
    collectshop        //店铺收藏列表类型
    
};

/* 获取收藏商品列表，品牌列表回调*/
typedef void (^CollectProductArrayCallback)(NSArray *collectProductArray);

@interface SVHTTPClient (CollectList)

//获取商品列表，品牌列表
+ (void)getCollectProductArrayWithPageNum:(NSInteger)PageNum Type:(CollectListType)collectListType IsShowSV:(BOOL)isShowSV target:(id)target CallBack:(CollectProductArrayCallback)collectProductArrayCallback;


@end

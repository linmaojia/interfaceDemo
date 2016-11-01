//
//  YZGCollectManager.h
//  ggg
//
//  Created by LXY on 16/9/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGShoppingCarView.h"
/* 获取收藏商品列表回调*/
typedef void (^CollectProductArrayCallback)(NSArray *collectProductArray);
/* 获取收藏品牌列表回调*/
typedef void (^CollectShopArrayCallback)(NSArray *collectShopArray);
@interface YZGCollectManager : NSObject

/* 获取收藏商品*/
- (void)getCollectProductArrayWithPageNum:(NSInteger)PageNum target:(id)target CallBack:(CollectProductArrayCallback)collectProductArrayCallback;
/* 获取品牌商品*/
- (void)getCollectShopArrayWithPageNum:(NSInteger)PageNum target:(id)target CallBack:(CollectShopArrayCallback)collectShopArrayCallback;


/* 动画效果*/
- (void)animationAction:(UIImageView *)moveImg selfView:(UIView *)view CarView:(YZGShoppingCarView *)carView CarCount:(int)carCount;

@end

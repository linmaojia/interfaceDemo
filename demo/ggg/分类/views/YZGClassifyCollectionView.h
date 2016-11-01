//
//  YZGMyCollectProduductFootView.h
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGClassifylModel.h"
@interface YZGClassifyCollectionView : UICollectionView
@property (nonatomic, strong) YZGClassifylModel *model;  
@property (nonatomic,copy) void(^cellClick)(NSDictionary *paner);  /**< 点击cell */
@property (nonatomic,copy) void(^BtnClick)(NSArray *dataArray);      /**< 排行榜回调 */
/*点击本周上新回调*/
@property (nonatomic, copy) void (^thisWeekNewProductOnLineAction)(NSDictionary *paner);
@end

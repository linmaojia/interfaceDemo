//
//  YZGMyCollectProduductFootView.h
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGHomeModel.h"
/**< 首尔collectionView */
@interface YZGHomeCollectView : UICollectionView
@property (nonatomic, strong) NSArray *dataArray;  /**< 爆款推荐 */
@property (nonatomic, strong) YZGHomeModel *model;
@property (nonatomic,copy) void(^cellClick)(NSString *productId);  /**< 点击cell */
@end

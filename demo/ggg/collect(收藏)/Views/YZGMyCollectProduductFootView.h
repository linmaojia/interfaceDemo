//
//  YZGMyCollectProduductFootView.h
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGMyCollectProduductFootView : UICollectionView
@property (nonatomic, strong) NSArray *hotArray;  /**< 爆款推荐 */
@property (nonatomic,copy) void(^cellClick)(NSString *productId);  /**< 点击cell */
@end

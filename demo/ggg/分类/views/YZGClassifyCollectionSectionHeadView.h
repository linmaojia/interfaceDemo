//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGClassifylSubModel.h"
@interface YZGClassifyCollectionSectionHeadView : UICollectionReusableView

@property (nonatomic, strong) YZGClassifylSubModel *model;
@property (nonatomic,copy) void(^BtnClick)();      /**< 排行榜回调 */
@property (nonatomic, strong) NSString *bannerUri;/**< bannerUri */
@property (nonatomic, strong) NSIndexPath *indexPath;
/*点击本周上新回调*/
@property (nonatomic, copy) void (^thisWeekNewProductOnLineAction)();


@end

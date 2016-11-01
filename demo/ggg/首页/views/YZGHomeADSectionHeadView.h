//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGClassifylSubModel.h"

/*广告（第一分区头）*/
@interface YZGHomeADSectionHeadView : UICollectionReusableView

@property (nonatomic,copy) void(^BtnClick)();      /**< 排行榜回调 */
/*banners 数组*/
@property (nonatomic, strong) NSArray *dataArray;



@end

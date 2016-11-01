//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/*广告（第一分区头）*/
@interface YZGSectionHeadView : UITableViewHeaderFooterView

@property (nonatomic,copy) void(^BtnClick)();      /**< 排行榜回调 */




@end

//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGNextOhterDetailModel.h"
@interface YZGDetailsOrderFootView : UIView

@property (nonatomic, strong) YZGNextOhterDetailModel *model;                    /**< 数据模型 */

@property (nonatomic,copy) void(^remarkFootBlack)(NSString *text);            /**< 备注回调 */
@end

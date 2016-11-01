//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGProductListTopView : UIView


@property (nonatomic,copy) void(^defaultBtnClick)();      /**< 默认回调 */
@property (nonatomic,copy) void(^priceBtnClick)(BOOL desc);      /**< 价格回调,价格排序 */
@property (nonatomic,copy) void(^filterBtnClick)();      /**< 筛选回调 */


@end

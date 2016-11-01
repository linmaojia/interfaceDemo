//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGConfirmBottomView : UIView

@property (nonatomic,copy) void(^submitBtnBlack)();  
@property (nonatomic, assign) CGFloat totalPrice;    /**< 总价格 */

@property (nonatomic, assign) NSInteger totalCount;    /**< 总数量 */

@end

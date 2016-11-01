//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGNextOhterDetailModel.h"
/**< 退款成功View */
@interface YZGRefundSuccessView : UIView

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) YZGNextOhterDetailModel *orderModel;  /* 订单明细Model */

@end

//
//  YZGSuccessBottomView.h
//  ggg
//
//  Created by LXY on 16/9/23.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGNextOhterDetailModel.h"
/**< 退款成功底部View */
@interface YZGSuccessBottomView : UIView
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) YZGNextOhterDetailModel *orderModel;  /* 订单明细Model */
@end

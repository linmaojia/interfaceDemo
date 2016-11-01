//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGOrderModel.h"

@interface YZGOrderCell : UITableViewCell

@property (nonatomic, strong) YZGOrderDetailModel *model;               /**< 产品模型 */

@property (nonatomic,copy) void(^deleBtnClickBlack)(NSString *text);     /**< 点击文本框结束编辑回调 */

@end

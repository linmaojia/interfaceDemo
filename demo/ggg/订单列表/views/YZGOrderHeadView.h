//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGOrderModel.h"
typedef NS_ENUM(NSInteger, Type) {
    TypePendingPayMoney  = 0,    //等待付款
    TypePendingConsignment,       //等待发货
    TypePendingConsignmentOther,  //等待发货2
    TypePendingConsignee,        //等待收货
    TypeComplete,                 //已完成
    TypeCancel  ,                //已取消
};
@interface YZGOrderHeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) YZGOrderModel *brandModel; /**<  品牌model */


@end

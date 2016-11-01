//
//  ETShoppingFootView.h
//  Test
//
//  Created by AVGD—JK on 16/1/8.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGOrderModel.h"
typedef NS_ENUM(NSInteger, showType)
{
    showTypePendingPayMoney,    //等待付款
    showTypePendingConsignment,     //等待发货
    showTypePendingConsignmentOther,  //等待发货2
    showTypePendingConsignee,   //等待收货
    showTypeComplete,            //已完成
    showTypeCancel  ,            //已取消
};

@interface YZGOrderFootView : UITableViewHeaderFooterView

@property (nonatomic, strong) YZGOrderModel *brandModel; /**<  品牌model */

@property (nonatomic, assign) NSInteger section;
 /**< 点击文本框结束编辑回调 */
@property (nonatomic,copy) void(^footViewBtnClickBlack)(NSString *title,NSInteger section ,CGFloat totalPrices);


@end

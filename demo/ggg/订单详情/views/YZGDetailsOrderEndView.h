//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGNextOhterDetailModel.h"
typedef NS_ENUM(NSInteger, showType)
{
    showTypePendingPayMoney,    //等待付款
    showTypePendingConsignment,  //已付款(待发货)
    showTypePendingConsignmentOther, //已付款(待发货)2
    showTypePendingConsignee,   //已发货
    showTypeComplete,            //已完成
    showTypeCancel  ,            //已取消
};
@interface YZGDetailsOrderEndView : UIView

@property (nonatomic, strong) YZGNextOhterDetailModel *model;               /**< 产品模型 */
@property (nonatomic,copy) void(^endViewBtnClickBlack)(NSString *title );     /**< 点击按钮回调 */

@end

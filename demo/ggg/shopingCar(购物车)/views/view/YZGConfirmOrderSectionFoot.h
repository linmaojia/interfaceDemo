//
//  MY_ShoppingCarHeaderView.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJShoppingCarModel.h"
@interface YZGConfirmOrderSectionFoot : UITableViewHeaderFooterView

@property (nonatomic, strong) UILabel *titleLab;    /**< 标题文字 */

@property (nonatomic, strong) MJShoppingCarModel *model;    /**< 模型*/

@property (nonatomic,copy) void(^remarkFootClick)(NSInteger section,NSString *text);     /**< 备注按钮回调*/

@property (nonatomic, assign)  NSInteger section;    /**< 传入分区值*/


@end

//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGAddressModel.h"
/**< 新增、编辑物流收货地址 */
@interface YZGUserAddressAddVC : YZGRootViewController
@property (nonatomic, strong) YZGAddressModel *model;     /**< 数据模型 */
@end

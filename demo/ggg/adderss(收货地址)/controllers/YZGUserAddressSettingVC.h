//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGAddressModel.h"

/**< 收货地址管理 */
@interface YZGUserAddressSettingVC : YZGRootViewController

@property (nonatomic, strong) YZGAddressModel *chooseAddress;       /**< 从购物车选中的地址model */

@property (nonatomic, strong) UITableView *tableView;       /**< 显示地址TableView */

@property (nonatomic, assign) BOOL isShopCar;       /**< 判断是否从购物车进来,没有默认地址的情况下 */

@property (nonatomic, assign) BOOL isChooseAdderss;       /**< 判断是否从购物车进来,没有默认地址的情况下 */

@property (nonatomic,copy) void(^adderssModel)(YZGAddressModel *model);

@property (nonatomic,copy) void(^refreshView)();  //从购物车进来，返回重新请数据
@end

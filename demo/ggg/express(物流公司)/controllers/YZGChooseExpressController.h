//
//  RefundCloseVC.h
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGExpressModel.h"

/**< 选择物流公司 */
@interface YZGChooseExpressController : YZGRootViewController

@property (nonatomic,copy) void(^chooseExpress)(YZGExpressModel *model);  //选择物流回调处理

@property (nonatomic, strong) YZGExpressModel *chooseExpressModel;       /**< 从购物车选进来的物流地址 */

@end

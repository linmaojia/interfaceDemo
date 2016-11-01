//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGAddressModel.h"
#import "YZGExpressModel.h"
@interface YZGConfirmTableHeadView : UIView

@property (nonatomic, strong) YZGAddressModel *model;    /**< 地址Model */

@property (nonatomic, strong) YZGExpressModel *expressModel;    /**< 物流Model */

@property (nonatomic,copy) void(^compameClick)();  //物流公司点击

@end

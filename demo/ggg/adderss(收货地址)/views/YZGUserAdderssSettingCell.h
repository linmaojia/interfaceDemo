//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGAddressModel.h"
@interface YZGUserAdderssSettingCell : UITableViewCell


@property (nonatomic, strong) YZGAddressModel *model;     /**< 数据模型 */
@property (nonatomic, strong) NSIndexPath  *indexPath;    /**< indexPath */
@property (nonatomic, assign) BOOL isChooseAdderss;       /**< 判断是否从购物车进来 */

@property (nonatomic, assign) BOOL isShowColourPicture;    /**< 是否显示底部彩色图片 */

@property (nonatomic,copy) void(^AdderssBtnClick)(NSString *text,NSIndexPath *indexPath);     /**< 按钮回调block */

@end

//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGExpressModel.h"
@interface YZGEditExpressCell : UITableViewCell


@property (nonatomic, strong) YZGExpressModel *model;     /**< 数据模型 */
@property (nonatomic, strong) NSIndexPath  *indexPath;    /**< indexPath */


@property (nonatomic,copy) void(^AdderssBtnClick)(NSString *text,NSIndexPath *indexPath);     /**< 按钮回调block */

@end

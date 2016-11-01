//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGExpressModel.h"

/**< 选择物流公司cell */
@interface YZGChooseExpressCell : UITableViewCell


@property (nonatomic, strong) YZGExpressModel *model;           /**< 物流公司模型 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, assign) BOOL isShowGou;    /**< 是否显示打钩图片 */

@end

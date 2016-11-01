//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGNextOhterDetailModel.h"
@interface YZGDetailsOrderCell : UITableViewCell

@property (nonatomic, strong) YZGNextOhterDetailModel *model;               /**< 产品模型 */

@property (nonatomic, strong) NSIndexPath *indexPath;             

@property (nonatomic,copy) void(^reimburseBtnBlack)(NSString *text,NSIndexPath *indexPath);  /**< 退款按钮点击事件回调 */

@property (nonatomic,copy) void(^remarkBlack)(NSString *text);

+ (YZGDetailsOrderCell *)mineTableViewWith:(UITableView *)tableView;


@end

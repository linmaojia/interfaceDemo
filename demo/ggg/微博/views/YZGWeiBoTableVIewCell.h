//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGWeiBoModel.h"
@interface YZGWeiBoTableVIewCell : UITableViewCell


@property (nonatomic, strong) YZGWeiBoModel *model;           /**< 产品模型 */
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,copy) void(^imgClickBlack)(NSInteger index);

@end

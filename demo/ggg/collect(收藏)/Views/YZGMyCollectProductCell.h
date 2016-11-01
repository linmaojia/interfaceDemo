//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGMyCollecProductModel.h"


@interface YZGMyCollectProductCell : UITableViewCell

@property (nonatomic, strong) YZGMyCollecProductModel *model;             /**<  model */

@property (nonatomic,copy) void(^sameBtnClickBlack)(NSString *productId); /*同系列点击*/

@property (nonatomic,copy) void(^carBtnClickBlack)(NSString *productId,UIImageView *imageView);/*购物车点击*/


@end

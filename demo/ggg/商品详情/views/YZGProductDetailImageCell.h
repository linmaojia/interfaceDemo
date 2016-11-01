//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGProductIntroduceModel.h"

/**<  图片cell */
@interface YZGProductDetailImageCell : UITableViewCell

@property (nonatomic, strong) YZGProductIntroduceModel *model;  /**<  model */
@property (nonatomic,copy) void(^cellHeightBlack)(CGFloat cellHeight); /*cell高度*/

@end

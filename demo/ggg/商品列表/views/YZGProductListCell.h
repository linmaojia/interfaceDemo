//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetail.h"

@interface YZGProductListCell : UITableViewCell


@property (nonatomic, strong) ProductDetail *model; /**< 产品模型 */

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

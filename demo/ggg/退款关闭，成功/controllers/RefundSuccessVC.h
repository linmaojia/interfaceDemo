//
//  RefundCloseVC.h
//  ggg
//
//  Created by LXY on 16/8/27.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"

 /**< 退款成功 */
@interface RefundSuccessVC : YZGRootViewController

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSString *orderDetailId;    /**< 退款id号 */
@end

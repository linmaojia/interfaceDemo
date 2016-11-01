//
//  RefuldViewController.h
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//


#import "YZGRootViewController.h"
/*退款详情*/
@interface RefuldViewController : YZGRootViewController

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSString *orderDetailId;    /**< 退款id号 */

@property (nonatomic, assign) NSInteger type;  //是否显示自定义的返回按钮,从申请退款中进来

@end

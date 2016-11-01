//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
/**< 商品详情 */
@interface YZGProductDetailViewVC : YZGRootViewController

@property (nonatomic, assign) NSInteger index;/**< 推荐或者详情 */

@property (nonatomic, strong) NSString *productId;
@end

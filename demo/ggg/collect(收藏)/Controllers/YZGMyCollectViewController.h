//
//  YZGMyCollectViewController.h
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
#import "YZGMyCollectProduductView.h"
#import "YZGMyCollectShopView.h"
/**< 收藏类型 */
typedef NS_ENUM(NSInteger, CollectType) {
    product,  /**< 商品 */
    shop,     /**< 店铺 */
    
};
@interface YZGMyCollectViewController : YZGRootViewController
@property (nonatomic, assign) CollectType collectType;

@property (nonatomic, strong) YZGMyCollectProduductView *productTableView;  /**< 商品TableView */
@property (nonatomic, strong) YZGMyCollectShopView *shopTableView;  /**< 店铺TableView */

- (void)PushHomeViewController;  /*跳转到品牌大全*/

- (void)getDataWithPageNum:(NSInteger)pageNum;  /*加载商品列表*/

- (void)getShopDataWithPageNum:(NSInteger)pageNum;/*加载品牌列表*/
@end

//
//  YZGShopProduductTableView.h
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGMyCollectProduductView : UITableView
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, strong) NSArray *hotArray;  /**< 爆款推荐 */


- (void)showNoneData;   /**< 第一次显示为空 */

@property (nonatomic,copy) void(^sameBtnClickBlack)(NSString *productId); /*同系列点击*/

@property (nonatomic,copy) void(^carBtnClickBlack)(NSString *productId,UIImageView *imageView);/*购物车点击*/

@property (nonatomic,copy) void(^cellClickBlack)(NSString *productId);  /**< 点击cell */

@property (nonatomic,copy) void(^puchHomeVCBlack)();  /**< 调转到首页 */

@property (nonatomic,copy) void(^reloadDataClick)(BOOL isShowSV);  /**< 取消成功后，重新刷新数据 */

@property (nonatomic,copy) void(^hotCellClick)(NSString *productId);  /**< 点击热门cell */

@end

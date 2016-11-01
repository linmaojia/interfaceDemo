//
//  YZGShopProduductTableView.h
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGProductDetailModel.h"
@interface YZGProductDetailTableView : UITableView
@property (nonatomic, strong) YZGProductDetailModel *model;

@property (nonatomic,copy) void(^procuctImgClickBlack)(NSIndexPath *indexPath); /*同系列点击*/

@property (nonatomic,copy) void(^sameCellClick)(NSString *productId);  /**< 同系列推荐 */

- (void)scrollToRowAtIndexPath:(NSInteger)index; /**< 跳转到指定位置 */

@property (nonatomic,copy) void(^titleIndexBlack)(NSInteger index);


@end

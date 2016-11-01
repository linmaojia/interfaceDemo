//
//  YZGMyCollectShopView.h
//  ggg
//
//  Created by LXY on 16/9/7.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGMyCollectShopView : UITableView
@property (nonatomic, strong) NSArray *shops;
@property (nonatomic,copy) void(^reloadDataClick)(BOOL isShowSV);  /**< 重新刷新数据 */
@property (nonatomic,copy) void(^cellClick)(NSIndexPath *indexPath);  /**< 点击cell */
@end

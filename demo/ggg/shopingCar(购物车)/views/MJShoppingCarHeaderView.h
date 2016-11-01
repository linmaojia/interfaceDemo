//
//  MY_ShoppingCarHeaderView.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJShoppingCarModel.h"
#import "MJShoppingCarVC.h"

@protocol SectionHeaderViewDelegate <NSObject>

@optional

/**< 分区头的选择按钮被点击 */
- (void)shoppingCarHeaderViewSelectButtonClicked:(BOOL)isSelect section:(NSInteger)section;

@end

@interface MJShoppingCarHeaderView : UITableViewHeaderFooterView


@property (nonatomic,assign) id <SectionHeaderViewDelegate> delegate; /**< 代理 */

@property (nonatomic, strong) MJShoppingCarModel *shopModel;

@property (nonatomic, assign) NSInteger section;

@end

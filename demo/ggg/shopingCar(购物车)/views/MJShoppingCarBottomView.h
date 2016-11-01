//
//  MJShoppingCarBottomView.h
//  Masonry
//
//  Created by LXY on 16/5/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BottomViewDelegate <NSObject>

@optional

/**< 全选按钮方法 */
- (void)BottomViewCheckAllAction:(BOOL) isCheckAll;

/**< 结算按钮方法 */
- (void)BottomViewSettlementBtnAction;

@end

@interface MJShoppingCarBottomView : UIView

@property (nonatomic, assign) id<BottomViewDelegate>delegate;    /**< BottomView代理 */

@property (nonatomic, strong) UIButton *checkAllBtn;    /**< 全选按钮 */

@property (nonatomic,assign) BOOL isEdit;    /**< 是否编辑状态 */

@property (nonatomic,copy) void(^deleClickBlock)(NSString *text);  /* 编辑，删除，按钮点击回调 */

@property (nonatomic,assign) BOOL isSetZero;    /**< 设置全选，价格，商品件数为空 */

/**< 修改价格 */
- (void)BottomChangeWithTotalPrices:(CGFloat)totalPrices TotalCount:(NSInteger )totalCount;

@end

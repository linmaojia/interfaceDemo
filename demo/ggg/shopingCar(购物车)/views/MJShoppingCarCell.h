//
//  MyShoppingCarCell.h
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJShoppingCarModel.h"

/*购物车代理方法*/
@protocol CellDelegate <NSObject>

@optional 

/*购物车Cell上的选择按钮被点击*/
- (void)CellSelectBtnAction:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath;

/*增加，减少按钮被点击*/
- (void)CellAddBtnAction:(NSInteger )count IndexPath:(NSIndexPath *)indexPath;

/*文本框回调*/
- (void)CellCountTfAction:(NSInteger )count IndexPath:(NSIndexPath *)indexPath;


/*备注按钮点击事件*/
- (void)RemarksBtnAction:(NSIndexPath *)indexPath RemarkText:(NSString *)remarkText;
@end


@interface MJShoppingCarCell : UITableViewCell

@property (nonatomic,assign) id <CellDelegate> delegate;   /**< 代理 */


@property (nonatomic, strong) Products *model;    /**< model */
@property (nonatomic, strong) NSIndexPath *indexPath;    /**< cell的位置 */
@property (nonatomic, strong) UIButton *selectBtn;    /**< 选择按钮 */
@property (nonatomic, strong) UIImageView *productImg;    /**< 商品图片 */
@property (nonatomic, strong) UILabel *productNameLab;    /**< 商品名称 */
@property (nonatomic, strong) UILabel *sizeLab;    /**< 商品规格 */
@property (nonatomic, strong) UILabel *costPriceLab;    /**< 商品批发价 */
@property (nonatomic, strong) UILabel *originalPriceLab;    /**< 商品原价 */
@property (nonatomic, strong) UILabel *stockLab;    /**< 库存 */


//cell底部
@property (nonatomic, strong) UIView *changeQty;    /**< 改变数量的视图 */
@property (nonatomic, strong) UITextField *countTextField;    /**< 数量 */
@property (nonatomic, strong) UIButton *addButton;    /**< 加按钮 */
@property (nonatomic, strong) UIButton *subtractButton;    /**< 减按钮 */


@end

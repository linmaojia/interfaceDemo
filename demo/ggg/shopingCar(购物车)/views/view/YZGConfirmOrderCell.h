//
//  MyShoppingCarCell.h
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJShoppingCarModel.h"


@interface YZGConfirmOrderCell : UITableViewCell

@property (nonatomic, strong) Products *model;    /**< model */
@property (nonatomic, strong) NSIndexPath *indexPath;    /**< cell的位置 */
@property (nonatomic, strong) UIImageView *productImg;    /**< 商品图片 */
@property (nonatomic, strong) UILabel *productNameLab;    /**< 商品名称 */
@property (nonatomic, strong) UILabel *sizeLab;    /**< 商品规格 */
@property (nonatomic, strong) UILabel *costPriceLab;    /**< 商品批发价 */
@property (nonatomic, strong) UILabel *originalPriceLab;    /**< 商品原价 */
@property (nonatomic, strong) UILabel *countLab;    /**< 商品购买件数 */


@end

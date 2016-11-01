//
//  MY_ShoppingCarModel.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetail.h"
@class Products;
@interface MJShoppingCarModel : NSObject

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, strong) NSMutableArray<Products *> *products;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic) BOOL select;


@property (nonatomic, strong) NSString *remarkText;    /**< 订单备注信息（自己添加） */

@end


//产品
@interface Products : NSObject

@property (nonatomic) BOOL select;

@property (nonatomic, strong) NSString *cartId;     /**< 购物车Id */
@property (nonatomic, strong) NSString *productID;     /**< 产品Id */
@property (nonatomic, strong) NSString *productDesc;     /**< 商品备注 */

@property (nonatomic, assign) CGFloat productPrice;     /**< 产品价格 */
@property (nonatomic, assign) NSInteger productQty;       /**< 购买数量 */
@property (nonatomic, strong) ProductDetail *productDetail;     /**< 产品详情 */


@end




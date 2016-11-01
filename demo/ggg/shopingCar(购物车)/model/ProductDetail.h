//
//  ProductDetail.h
//  yzg
//
//  Created by LXY on 16/6/25.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
//产品详情
@interface ProductDetail : NSObject
@property (nonatomic, strong) NSString *seqid;     /**< 产品id */

@property (nonatomic, strong) NSString *brandName;     /**< 品牌名称 */

@property (nonatomic, strong) NSString *style;         /**<  产品风格 */
@property (nonatomic, assign) CGFloat productPrice;         /**<  产品零售价 */
@property (nonatomic, assign) CGFloat dealerPurchasePrice;         /**<  产品具体价格 */


@property (nonatomic, strong) NSString *productNum;     /**<  产品参数 */

@property (nonatomic, strong) NSString *productType;     /**<  产品类型 */

@property (nonatomic, assign) NSInteger stock;     /**<  库存 */


@property (nonatomic, strong) NSString *specLength;    /**< 长度 */

@property (nonatomic, strong) NSString *specHeight;    /**< 产品高度 */

@property (nonatomic, strong) NSString *specWidth;    /**< 产品宽度 */

@property (nonatomic, strong) NSString *path;    /**< 产品图片地址 */

@property (nonatomic, strong) NSString *imgPath;    /**< 同系列图片地址坑 */



@end

//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGProductIntroduceModel.h"
#import "ProductDetail.h"
 /**< 商品详情model */
@interface YZGProductDetailModel : NSObject
@property (nonatomic, copy) NSString *seqid;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, strong) NSNumber *dealerPurchasePrice;
@property (nonatomic, copy) NSString *productNum;
@property (nonatomic, copy) NSString *productSeries;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *brandName;
@property (nonatomic, copy) NSString *styleLabel;
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *bodyColorLabel;
@property (nonatomic, copy) NSString *applicableRegion;
@property (nonatomic, copy) NSString *madeLabel;
@property (nonatomic, copy) NSString *Descriptions;
@property (nonatomic, copy) NSString *favoriteId;
@property (nonatomic, copy) NSString *specLength;
@property (nonatomic, copy) NSString *specWidth;
@property (nonatomic, copy) NSString *specHeight;
@property (nonatomic, copy) NSString *logoPath;
@property (nonatomic, copy) NSString *brandCode;
@property (nonatomic, strong) NSNumber *illuminantNum;
@property (nonatomic, strong) NSNumber *stock;


@property (nonatomic, strong) NSArray<YZGProductIntroduceModel *> *gintroduce;    /**< 介绍图片数组 */

@property (nonatomic, strong) NSArray<ProductDetail *> *similarProduct;    /**< 同系列数组 */



@end

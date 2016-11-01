//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGBrandModel.h"
#import "ProductDetail.h"
 /**< 单个品牌model */
@interface YZGBrandModel : NSObject
@property (nonatomic, strong) NSString *seqId;
@property (nonatomic, strong) NSString *brandName;
@property (nonatomic, strong) NSString *logoPath;

@property (nonatomic, strong) NSArray<ProductDetail *> *productArr;

@end







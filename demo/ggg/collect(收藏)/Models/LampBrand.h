//
//  ProductDetail.h
//  yzg
//
//  Created by LXY on 16/6/25.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
//产品详情
@interface LampBrand : NSObject


@property (nonatomic, strong) NSString *seqId;     /**< 品牌id */

@property (nonatomic, assign) NSInteger goodsCount;     /**< 产品数量 */


@property (nonatomic, strong) NSString *brandName;     /**< 品牌名称 */

@property (nonatomic, strong) NSString *logoPath;     /**< 商店图片 */

@property (nonatomic, strong) NSString *brandAddress;     /**< 品牌地址 */

@property (nonatomic, strong) NSString *brandCompany;     /**< 品牌公司 */



@end

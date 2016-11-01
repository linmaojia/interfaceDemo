//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGHomeModel.h"
#import "YZGHomeClassifiesModel.h"
 /**< 首页model */

@interface YZGHomeModel : NSObject

@property (nonatomic, strong) NSArray *banners;    /**< 广告model */

@property (nonatomic, strong) YZGHomeClassifiesModel *classifies;    /**< 小分类字典 */

@property (nonatomic, strong) NSArray *hotStyles; /**< 热门风格 */



@end




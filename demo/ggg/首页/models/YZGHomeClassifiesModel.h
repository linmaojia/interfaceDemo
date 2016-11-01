//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGHomeClassifiesModel.h"

 /**< 小分类model */
@class YZGDetailClassifiesModel;
@interface YZGHomeClassifiesModel : NSObject

@property (nonatomic, strong) NSArray<YZGDetailClassifiesModel *> *types;    /**< 类型 */
@property (nonatomic, strong) NSArray<YZGDetailClassifiesModel *> *spaces;    /**< 空间 */
@property (nonatomic, strong) NSArray<YZGDetailClassifiesModel *> *styles;    /**< 风格 */
@property (nonatomic, strong) NSArray<YZGDetailClassifiesModel *> *hot;    /**< 最热 */


@end



@interface YZGDetailClassifiesModel : NSObject

@property (nonatomic, strong) NSString *extend1; /**< 图片地址 */
@property (nonatomic, strong) NSString *name;


@end

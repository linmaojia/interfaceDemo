//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
 /**< 商品介绍图片model */
@interface YZGProductIntroduceModel : NSObject

@property (nonatomic, copy) NSString *gIntroduceId;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *updateDate;

@property (nonatomic, assign) CGFloat cellHeight; /**< cell高度 */

@end

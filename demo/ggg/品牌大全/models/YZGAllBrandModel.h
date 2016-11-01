//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGAllBrandModel.h"
#import "YZGBrandModel.h"
 /**< 品牌大全model */
@interface YZGAllBrandModel : NSObject
@property (nonatomic, strong) NSString *node;

@property (nonatomic, strong) NSArray<YZGBrandModel *> *data;

@property (nonatomic, strong) NSString *ezgParam;


@end




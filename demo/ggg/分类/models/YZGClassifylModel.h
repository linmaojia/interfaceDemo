//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGClassifylModel.h"
#import "YZGClassifylSubModel.h"
 /**< 分类model */
@class YZGSceneModel;
@interface YZGClassifylModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *bannerUri;
@property (nonatomic, strong) NSString *scene;
@property (nonatomic, assign) BOOL isSelect;


@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) NSArray<YZGClassifylSubModel *> *subset;    /**< 右边子model */


@end




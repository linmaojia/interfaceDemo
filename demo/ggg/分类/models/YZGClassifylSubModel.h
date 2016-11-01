//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGClassifylSubModel.h"

 /**< 分类 子model */
@class YZGClassifylDetailModel;
@interface YZGClassifylSubModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSDictionary *rankParams;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) NSArray<YZGClassifylDetailModel *> *subset;    /**< 右边子model */


@end


@interface YZGClassifylDetailModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *picUri;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSDictionary *rankParams;



@end

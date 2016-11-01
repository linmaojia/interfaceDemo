//
//  YZGProductDetailModel.m
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGHomeClassifiesModel.h"

@implementation YZGHomeClassifiesModel

+ (NSDictionary *)objectClassInArray{
    return @{@"types" : [YZGDetailClassifiesModel class],@"spaces" : [YZGDetailClassifiesModel class],@"styles" : [YZGDetailClassifiesModel class],@"hot" : [YZGDetailClassifiesModel class]};
}

@end

@implementation YZGDetailClassifiesModel



@end

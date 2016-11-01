//
//  YZGProductDetailModel.m
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductDetailModel.h"

@implementation YZGProductDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"gintroduce" : [YZGProductIntroduceModel class],@"similarProduct" : [ProductDetail class]};
}



@end

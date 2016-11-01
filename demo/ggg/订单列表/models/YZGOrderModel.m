//
//  MY_ShoppingCarModel.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderModel.h"

@implementation YZGOrderModel

+ (NSDictionary *)objectClassInArray{
    return @{@"ezgOrderdetailsArr" : [YZGOrderDetailModel class]};
}

@end

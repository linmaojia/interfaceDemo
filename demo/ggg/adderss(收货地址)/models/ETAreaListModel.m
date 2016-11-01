//
//  ETAreaListModel.m
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import "ETAreaListModel.h"

@implementation ETAreaListModel



+ (NSDictionary *)objectClassInArray{
    return @{@"edsAddrList" : [City class]};
}
@end


@implementation City

+ (NSDictionary *)objectClassInArray{
    return @{@"edsAddrList" : [Town class]};
}

@end


@implementation Town

@end



//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGWeiBoModel.h"

@interface YZGWeiBoManager : NSObject
- (NSMutableArray *)getDataArray;

+ (CGFloat )getImgArrayHeightWith:(YZGWeiBoModel *)model;
@end

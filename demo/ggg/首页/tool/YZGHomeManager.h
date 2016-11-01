//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGHomeModel.h"

@interface YZGHomeManager : NSObject
typedef void (^HomeCallback)(YZGHomeModel *model);
/**< 获取主页数据 */
- (void)getHomeModelWithTarget:(id)target CallBack:(HomeCallback)homeCallback;
@end

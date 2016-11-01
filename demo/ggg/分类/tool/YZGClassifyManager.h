//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YZGClassifyManager : NSObject

typedef void (^ClassifyListCallback)(NSArray *array);
/**< 获取分类数组 */
- (void)getClassifyListWithTarget:(id)target CallBack:(ClassifyListCallback)classifyListCallback;
@end

//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**< ScrollerView 分页 */
@interface YZGScrollerView : UIView


@property (nonatomic,copy) void(^saveBtnClick)();

@property (nonatomic, strong) NSArray *titleArray;   

@end

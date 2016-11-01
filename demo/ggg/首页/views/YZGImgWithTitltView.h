//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**< ScrollerView 子页面 */
@interface YZGImgWithTitltView : UIView


@property (nonatomic,copy) void(^viewWithTagBlack)(NSInteger tag);

@property (nonatomic, strong) NSArray *dataArray;

@end

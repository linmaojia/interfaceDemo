//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGRankingListTopView : UIView


@property (nonatomic,copy) void(^topButtonClick)(NSInteger index);  //block回调
@property (nonatomic, strong) NSArray *buttonArray; /*按钮数组*/
@property (nonatomic,copy) void(^isShowTagButton)(BOOL flag);   /*是否显示标签按钮 回调*/
@property (nonatomic, assign) NSInteger index; /*选中标题位置*/

- (void)showTopButton;/* 显示顶部按钮*/


@end

//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/*标签View*/
@interface YZGRankingListLabView : UIView

@property (nonatomic,copy) void(^tagButtonClick)(NSInteger index);  //block回调
@property (nonatomic, strong) NSArray *buttonArray; /*按钮数组*/
@property (nonatomic, assign) NSInteger index; /*选中标题位置*/
@property (nonatomic,copy) void(^showTagButton)();  //显示标签按钮block回调


- (void)dismiss;
@end

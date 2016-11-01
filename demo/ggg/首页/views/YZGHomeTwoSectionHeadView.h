//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGHomeTwoSectionHeadView : UICollectionReusableView

@property (nonatomic,copy) void(^BtnClick)();

@property (nonatomic, strong) NSString *title;



@end

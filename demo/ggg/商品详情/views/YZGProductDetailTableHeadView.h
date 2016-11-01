//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YZGProductDetailModel.h"
@interface YZGProductDetailTableHeadView : UIView

@property (nonatomic, strong) YZGProductDetailModel *model;
@property (nonatomic, copy) void (^didSelectedBigImage)();
@end

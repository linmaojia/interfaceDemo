//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGPayFinishHeadView : UICollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame ;

@property (nonatomic,copy) void(^blackBtnBlack)(NSString *text);  //按钮回调

@property (nonatomic,copy) void(^newImgClickBlack)();  //本周上新被点击

@property (nonatomic,assign) CGFloat price;  //总价格

@end

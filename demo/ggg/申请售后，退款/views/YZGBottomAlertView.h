//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGBottomAlertView : UIView
- (instancetype)initWithTitle:(NSArray *)titleArray;
@property (nonatomic,copy) void(^alertTitleBlock)(NSString *title);     /**< 传递标题 */

@end

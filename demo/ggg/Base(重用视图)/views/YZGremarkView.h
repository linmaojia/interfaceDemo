//
//  YZGAlertView.h
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YZGremarkView : UIView

+ (void)showAlertViewWithTitle:(NSString *)title ConfirmBlock:(void(^)())confirmBlock ;

@end

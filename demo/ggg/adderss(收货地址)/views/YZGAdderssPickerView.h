//
//  YZGPickerView.h
//  Masonry
//
//  Created by LXY on 16/7/7.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETAreaListModel.h"
@interface YZGAdderssPickerView : UIView


+ (void)showAlertViewWithAdderssArray:(NSArray *)dataArray AdderssBlock:(void(^)(ETAreaListModel *province,City *city,Town *town))titleBtnBlock;

@end

//
//  YZGShopProduductTableView.h
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

/*右边字母列表*/
@interface YZGLettersTableView : UITableView

@property (nonatomic, strong) NSArray *dataArray;  

@property (nonatomic,copy) void(^cellClickBlack)(NSInteger index); /*cell点击*/

@end

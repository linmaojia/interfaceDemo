//
//  YZGMineTableOrderCell.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>
/**<  标题cell */
@interface YZGProductDetailTitleCell : UITableViewCell

//@property (nonatomic,copy) void(^cellHeightBlack)(CGFloat cellHeight); /*cell高度*/
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSIndexPath *indexPath;


@end

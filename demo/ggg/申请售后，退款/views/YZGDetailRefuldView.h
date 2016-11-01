//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**< 退款详情View */
@interface YZGDetailRefuldView : UIView

@property (nonatomic, strong) UILabel *timeLab1; /**<  时间1 */
@property (nonatomic, strong) UILabel *timeLab2;  /**<  时间1 */
@property (nonatomic, strong) UILabel *reasonLab;  /**<  退款原因 */
@property (nonatomic, strong) UILabel *RefuldLab;  /**<  退款说明 */
@property (nonatomic, strong) UILabel *numberLab;  /**<  退款编号 */

@end

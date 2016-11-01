//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGChooseExpressCell.h"

@interface YZGChooseExpressCell()

@property (nonatomic, strong) UIImageView *rightImg;         /**<  右边打钩图片 */
@property (nonatomic, strong) UILabel *nameLab;             /**<  公司名称 */

@end
@implementation YZGChooseExpressCell

#pragma mark ************** 懒加载控件
- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"Tao-Mine-My order-Refund interface- selected"];
        [_rightImg setContentMode:UIViewContentModeScaleAspectFit];
        _rightImg.hidden = YES;
        
    }
    return _rightImg;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = systemFont(16);
        _nameLab.text = @"七里博城-dfdfs";
    }
    return _nameLab;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGExpressModel *)model{
    _model = model;
    
    _nameLab.text = model.logisticsName;//物流公司名称
    
}

- (void)setIsShowGou:(BOOL)isShowGou
{
    //显示打钩图片
    if(isShowGou)
    {
        _rightImg.hidden = NO;
    }
    else
    {
        _rightImg.hidden = YES;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        [self addSubviewsForCell];
        [self addConstraintsForCell];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
    }
    return self;
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.rightImg];
    [self.contentView addSubview:self.nameLab];
    
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-10));
        make.height.width.equalTo(@(20));
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(_rightImg.left).offset(-10);
        make.height.equalTo(@(40));
    }];
    
}
@end

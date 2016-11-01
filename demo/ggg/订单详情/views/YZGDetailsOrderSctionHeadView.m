//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderSctionHeadView.h"


@interface YZGDetailsOrderSctionHeadView ()
@property (nonatomic, strong) UIView *spaceView;          /**<  顶部空隙 */
@property (nonatomic, strong) UIView *lineView;           /**<  顶部分割线 */
@property (nonatomic, strong) UIView *topView;            /**<  顶部View */
/**<  顶部控件 */
@property (nonatomic, strong) UIImageView *brandImg;         /**<  商家图片 */
@end

@implementation YZGDetailsOrderSctionHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubviewsForHeadView];
        [self addConstraintsForHeadView];

    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = RGB(247, 247, 247);
    }
    return _spaceView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
    }
    return _lineView;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
- (UILabel *)brandLab {
    if (!_brandLab) {
        _brandLab = [[UILabel alloc] init];
        _brandLab.textAlignment = NSTextAlignmentLeft;
        _brandLab.font = systemFont(16);
        _brandLab.text = @"欧莱宝";
        _brandLab.textColor = [UIColor blackColor];
    }
    return _brandLab;
}
- (UIImageView *)brandImg {
    if (!_brandImg) {
        _brandImg = [[UIImageView alloc] init];
        _brandImg.image = [UIImage imageNamed:@"icon_shop"];
        
    }
    return _brandImg;
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForHeadView
{
    [self addSubview:self.spaceView];
    [self addSubview:self.lineView];
    [self addSubview:self.topView];
    /**<  顶部控件 */
    [self.topView addSubview:self.brandImg];
    [self.topView addSubview:self.brandLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForHeadView
{
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spaceView.bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(40));
    }];
    /**<  顶部控件 */
    [_brandImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(10);
        make.centerY.equalTo(_topView);
        make.width.height.equalTo(@(17));
    }];
    [_brandLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_topView);
        make.left.equalTo(_brandImg.right).offset(8);
    }];
}

@end

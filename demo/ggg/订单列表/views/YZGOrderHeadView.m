//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderHeadView.h"


@interface YZGOrderHeadView ()
@property (nonatomic, strong) UIView *spaceView;          /**<  顶部空隙 */
@property (nonatomic, strong) UIView *lineView;           /**<  顶部分割线 */
@property (nonatomic, strong) UIView *topView;            /**<  顶部View */
/**<  顶部控件 */
@property (nonatomic, strong) UILabel *brandLab; /**<  商家名称 */
@property (nonatomic, strong) UIImageView *brandImg;         /**<  商家图片 */
@property (nonatomic, strong) UIImageView *bracketsImg;         /**<  尖括号图片 */
@property (nonatomic, strong) UILabel *stateLab;             /**<  订单状态 */
@end

@implementation YZGOrderHeadView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
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
- (UIImageView *)bracketsImg {
    if (!_bracketsImg) {
        _bracketsImg = [[UIImageView alloc] init];
        _bracketsImg.image = [UIImage imageNamed:@"right_back"];
        
    }
    return _bracketsImg;
}
- (UILabel *)stateLab {
    if (!_stateLab) {
        _stateLab = [[UILabel alloc] init];
        _stateLab.textAlignment = NSTextAlignmentRight;
        _stateLab.textColor = RGB(38, 66, 136);
        _stateLab.font = systemFont(15);
        _stateLab.text = @"已完成";
    }
    return _stateLab;
}
- (void)setBrandModel:(YZGOrderModel *)brandModel
{
    int type = brandModel.isCheckState;
    
    if(type == TypePendingPayMoney) {
        _stateLab.text = @"等待买家付款";
    }
    else if (type == TypePendingConsignment || type == TypePendingConsignmentOther) {
        _stateLab.text = @"买家已付款";
    }
    else if (type == TypePendingConsignee)  {
        _stateLab.text = @"卖家已发货";
    }
    else if (type == TypeComplete) {
        _stateLab.text = @"已完成";
    }
    else if (type == TypeCancel){
        _stateLab.text = @"已关闭";
    }
    
    self.brandLab.text = brandModel.brandName;
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
    [self.topView addSubview:self.bracketsImg];
    [self.topView addSubview:self.stateLab];
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
        make.bottom.equalTo(self);
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
    [_bracketsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_brandLab.right).offset(5);
        make.centerY.equalTo(_brandLab);
        make.width.height.equalTo(@(15));
    }];
    [_stateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_topView);
        make.right.equalTo(_topView).offset(-10);
        make.width.equalTo(@(150));
    }];
}

@end

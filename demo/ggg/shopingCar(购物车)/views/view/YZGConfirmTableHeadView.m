//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGConfirmTableHeadView.h"

@interface YZGConfirmTableHeadView ()
//收货地址
@property (nonatomic, strong) UIView *topBgView;    /**< 地址背景view */
@property (nonatomic, strong) UILabel *nameLab;    /**< 名称 */
@property (nonatomic, strong) UILabel *phoneLab;    /**< 电话号码 */
@property (nonatomic, strong) UIImageView *adderssImg;    /**< 地址图片 */
@property (nonatomic, strong) UILabel *adderssLab;    /**< 地址 */
@property (nonatomic, strong) UILabel *defaultLab;    /**< 默认名称 */
@property (nonatomic, strong) UIImageView *bracketImg;    /**< 右边尖括号图片 */
@property (nonatomic, strong) UIImageView *bottomImg;    /**< 底部彩色图片 */
//物流公司
@property (nonatomic, strong) UIView *bottomView;    /**< 物流背景view */
@property(nonatomic, strong) UILabel *logisticsLab;    /**< 物流 */
@property(nonatomic, strong) UILabel *companyLab;    /**< 物流公司 */
@property (nonatomic, strong) UIImageView *bottombracketImg;    /**< 右边尖括号图片 */

@end
@implementation YZGConfirmTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubviewsForHeadView];
        
        [self addConstraintsForHeadView];
        
    }
    return self;
}

#pragma mark ************** 懒加载控件
- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = [UIColor whiteColor];
    }
    return _topBgView;
}
- (UILabel *)logisticsLab {
    if (!_logisticsLab) {
        _logisticsLab = [[UILabel alloc] init];
        _logisticsLab.textColor = [UIColor blackColor];
        _logisticsLab.textAlignment = NSTextAlignmentLeft;
        _logisticsLab.font = [UIFont boldSystemFontOfSize:14];
        _logisticsLab.text = @"物流公司";
    }
    return _logisticsLab;
}
- (UILabel *)companyLab {
    if (!_companyLab) {
        _companyLab = [[UILabel alloc] init];
        _companyLab.textColor = [UIColor blackColor];
        _companyLab.textAlignment = NSTextAlignmentRight;
        _companyLab.font = [UIFont boldSystemFontOfSize:14];
        _companyLab.text = @"未设置";
    }
    return _companyLab;
}
- (UIImageView *)bottombracketImg {
    if (!_bottombracketImg) {
        _bottombracketImg = [[UIImageView alloc] init];
        _bottombracketImg.image = [UIImage imageNamed:@"right_back"];
    }
    return _bottombracketImg;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = hexColor(FFFFFF);
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(227, 229, 230).CGColor;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(compaClick:)];
        [_bottomView addGestureRecognizer:tap];
    }
    return _bottomView;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = systemFont(16);
        _nameLab.textColor = [UIColor blackColor];
        _nameLab.text = @"和志向";
    }
    return _nameLab;
}
- (UILabel *)defaultLab {
    if (!_defaultLab) {
        _defaultLab = [[UILabel alloc] init];
        _defaultLab.textAlignment = NSTextAlignmentCenter;
        _defaultLab.font = systemFont(16);
        _defaultLab.textColor = [UIColor whiteColor];
        _defaultLab.backgroundColor = mainColor;
        _defaultLab.text = @"默认";
    }
    return _defaultLab;
}
- (UILabel *)phoneLab {
    if (!_phoneLab) {
        _phoneLab = [[UILabel alloc] init];
        _phoneLab.textAlignment = NSTextAlignmentLeft;
        _phoneLab.font = systemFont(16);
        _phoneLab.textColor = [UIColor blackColor];
        _phoneLab.text = @"1423234333";
    }
    return _phoneLab;
}
- (UILabel *)adderssLab {
    if (!_adderssLab) {
        _adderssLab = [[UILabel alloc] init];
        _adderssLab.textAlignment = NSTextAlignmentLeft;
        _adderssLab.font = systemFont(12);
        _adderssLab.textColor = [UIColor blackColor];
        _adderssLab.numberOfLines = 0;
        _adderssLab.text = @"广东省中山市古镇个虎一定的王洪刚发你是对方的水电费";
    }
    return _adderssLab;
}
- (UIImageView *)adderssImg {
    if (!_adderssImg) {
        _adderssImg = [[UIImageView alloc] init];
        _adderssImg.image = [UIImage imageNamed:@"icon_add"];
        [_adderssImg setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _adderssImg;
}
- (UIImageView *)bracketImg {
    if (!_bracketImg) {
        _bracketImg = [[UIImageView alloc] init];
        _bracketImg.image = [UIImage imageNamed:@"right_back"];
    }
    return _bracketImg;
}

- (UIImageView *)bottomImg {
    if (!_bottomImg) {
        _bottomImg = [[UIImageView alloc] init];
        _bottomImg.backgroundColor = [UIColor yellowColor];
        _bottomImg.image = [UIImage imageNamed:@"caiLine"];
        
    }
    return _bottomImg;
}

#pragma mark ************** 更新数据
- (void)setModel:(YZGAddressModel *)model{
    _model = model;
    _nameLab.text = model.deliverName;
    _phoneLab.text = model.deliverPhone;
    
    //判断详细地址是否存在
    if(model.deliverAddress)
    {
        _adderssLab.text = [NSString stringWithFormat:@"%@%@",model.deliverPCAS,model.deliverAddress];
    }
    else
    {
        _adderssLab.text = [NSString stringWithFormat:@"%@",model.deliverPCAS];
    }
    
    
    if([model.isDefault isEqualToString:@"0"])
    {
        self.defaultLab.hidden = YES;
    }
    else if([model.isDefault isEqualToString:@"1"])
    {
        self.defaultLab.hidden = NO;
    }
    
    
}
- (void)setExpressModel:(YZGExpressModel *)expressModel
{
    _expressModel = expressModel;
    self.companyLab.text = expressModel.logisticsName;
    
}
#pragma mark ************** 物流公司点击
-(void)compaClick:(UITapGestureRecognizer *)sender
{
    if(self.compameClick)
    {
        self.compameClick();
    }
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForHeadView
{
    
    //收货地址
    [self addSubview:self.topBgView];
    [self.topBgView addSubview:self.nameLab];
    [self.topBgView addSubview:self.phoneLab];
    [self.topBgView addSubview:self.adderssImg];
    [self.topBgView addSubview:self.adderssLab];
    [self.topBgView addSubview:self.bottomImg];
    [self.topBgView addSubview:self.defaultLab];
    [self.topBgView addSubview:self.bracketImg];
    //物流公司
    [self  addSubview:self.bottomView];
    [self.bottomView addSubview:self.logisticsLab];
    [self.bottomView addSubview:self.companyLab];
    [self.bottomView addSubview:self.bottombracketImg];
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForHeadView
{
    //收货地址（高度85）这个比较特别，要设置他的宽度，高度，下面的子视图用约束才不会报错
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(85));
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(AUTO_MATE_WIDTH(45));
        make.top.equalTo(_topBgView).offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(AUTO_MATE_WIDTH(90)));
    }];
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLab.right);
        make.centerY.equalTo(_nameLab);
        make.height.equalTo(@(20));
        make.width.equalTo(@110);
    }];
    [_adderssLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(5);
        make.left.equalTo(_nameLab);
        make.right.equalTo(_topBgView).offset(-40);
        make.height.equalTo(@(30));
       
    }];
    [_adderssImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_adderssLab.left).offset(-5);
        make.centerY.equalTo(_adderssLab);
        make.height.equalTo(@(17));
        make.width.equalTo(@(14));
    }];
    
    [_defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_phoneLab.right).offset(5);
        make.centerY.equalTo(_phoneLab.centerY);
        make.height.equalTo(@(20));
        make.width.equalTo(@(40));
    }];
    
    [_bracketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topBgView).offset(-10);
        make.centerY.equalTo(_topBgView);
        make.width.height.equalTo(@(16));
    }];
    [_bottomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_topBgView);
        make.bottom.equalTo(_topBgView);
        make.height.equalTo(@(3));
    }];
    //物流公司（高度40）
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    [_logisticsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bottomView).offset(20);
        make.width.equalTo(@(100));
        make.top.bottom.equalTo(_bottomView);
    }];
    [_bottombracketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView).offset(-10);
        make.centerY.equalTo(_bottomView);
        make.width.height.equalTo(@(16));
    }];
    [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottombracketImg.left).offset(-10);
        make.top.bottom.equalTo(_bottomView);
        make.width.equalTo(@(100));
    }];
    
}

@end

//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailRefuldView.h"


@interface YZGDetailRefuldView()

@property (nonatomic, strong) UIView *topBgView;    /**< 白色背景View */
@property (nonatomic, strong) UIView *bottomView;    /**< 蓝色背景View */
//顶部
@property (nonatomic, strong) UILabel *requestLab;  /**<  发起申请 */
@property (nonatomic, strong) UIView *line1;      /**<  中间线 */
//尾部
@property (nonatomic, strong) UILabel *dealLab;  /**<  待处理 */
@property (nonatomic, strong) UIView *line2;      /**<  中间线 */
@property (nonatomic, strong) UIView *line3;      /**<  中间线 */

//三角形
@property (nonatomic, strong) UIImageView *image1;
@property (nonatomic, strong) UIImageView *image2;
@end

@implementation YZGDetailRefuldView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGB(245, 245, 245);
        
        [self addSubviewsForRefuldView];
        
        [self addConstraintsForRefuldView];

    }
    return self;
}

#pragma mark ************** 懒加载控件
- (UIImageView *)image1 {
    if (!_image1) {
        _image1= [[UIImageView alloc] init];
        _image1.image = [UIImage imageNamed:@"white_jian"];
    }
    return _image1;
}
- (UIImageView *)image2 {
    if (!_image2) {
        _image2= [[UIImageView alloc] init];
        _image2.image = [UIImage imageNamed:@"san"];
    }
    return _image2;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc] init];
        _line2.backgroundColor = [UIColor whiteColor];
    }
    return _line2;
}
- (UIView *)line3 {
    if (!_line3) {
        _line3 = [[UIView alloc] init];
        _line3.backgroundColor = [UIColor whiteColor];
    }
    return _line3;
}
- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab= [[UILabel alloc] init];
        _numberLab.font = [UIFont systemFontOfSize:16];
        _numberLab.textColor = [UIColor whiteColor];
        _numberLab.text = @"退款编号:882932303002839";
        _numberLab.textAlignment = NSTextAlignmentLeft;
    }
    return _numberLab;
}
- (UILabel *)dealLab {
    if (!_dealLab) {
        _dealLab= [[UILabel alloc] init];
        _dealLab.font = [UIFont systemFontOfSize:16];
        _dealLab.text = @"待卖家处理";
        _dealLab.textColor = [UIColor whiteColor];
        _dealLab.textAlignment = NSTextAlignmentLeft;
    }
    return _dealLab;
}
- (UILabel *)RefuldLab {
    if (!_RefuldLab) {
        _RefuldLab= [[UILabel alloc] init];
        _RefuldLab.font = [UIFont systemFontOfSize:16];
        _RefuldLab.textColor = [UIColor whiteColor];
        _RefuldLab.text = @"卖家同意您的申请(卖家在04天23时59分内未处理您的申请，将视为默认\"同意\")，系统将退款给您；\n如果卖家发货，本次申请将关闭，您可通过\"申请售后\"要求客服介入进行处理。\n提示：请勿相信任何人给您发来的订单操作链接，以免被骗。";
        _RefuldLab.textAlignment = NSTextAlignmentLeft;
        _RefuldLab.numberOfLines = 0;
    }
    return _RefuldLab;
}


- (UILabel *)requestLab {
    if (!_requestLab) {
        _requestLab= [[UILabel alloc] init];
        _requestLab.font = [UIFont systemFontOfSize:16];
        _requestLab.text = @"买家发起申请";
        _requestLab.textAlignment = NSTextAlignmentLeft;
    }
    return _requestLab;
}
- (UILabel *)reasonLab {
    if (!_reasonLab) {
        _reasonLab= [[UILabel alloc] init];
        _reasonLab.font = [UIFont systemFontOfSize:16];
        _reasonLab.text = @"发起了申请，货物状态：未发货，原因：拍错/多拍/不想要，金额:12120.00元。";
        _reasonLab.textAlignment = NSTextAlignmentLeft;
        _reasonLab.numberOfLines = 0;
    }
    return _reasonLab;
}
- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = [UIColor blackColor];
    }
    return _line1;
}

- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = [UIColor whiteColor];
        _topBgView.layer.cornerRadius = 5;
        _topBgView.layer.masksToBounds = YES;
    }
    return _topBgView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB(44, 68, 135);
        _bottomView.layer.cornerRadius = 5;
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}
- (UILabel *)timeLab1 {
    if (!_timeLab1)
    {
        _timeLab1= [[UILabel alloc] init];
        _timeLab1.font = [UIFont systemFontOfSize:14];
        _timeLab1.text = @"09-23 08:33:33";
        _timeLab1.textAlignment = NSTextAlignmentCenter;
        _timeLab1.backgroundColor = [UIColor whiteColor];
        _timeLab1.layer.cornerRadius = 3;
        _timeLab1.layer.masksToBounds = YES;
    }
    return _timeLab1;
}
- (UILabel *)timeLab2 {
    if (!_timeLab2) {
        _timeLab2= [[UILabel alloc] init];
        _timeLab2.font = [UIFont systemFontOfSize:14];
        _timeLab2.text = @"09-23 08:33:33";
        _timeLab2.textAlignment = NSTextAlignmentCenter;
        _timeLab2.backgroundColor = [UIColor whiteColor];
        _timeLab2.layer.cornerRadius = 3;
        _timeLab2.layer.masksToBounds = YES;
    }
    return _timeLab2;
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForRefuldView
{
    [self addSubview:self.timeLab1];
    [self addSubview:self.timeLab2];
    [self addSubview:self.topBgView];
    [self addSubview:self.bottomView];
    //顶部
    [self.topBgView addSubview:self.requestLab];
    [self.topBgView addSubview:self.line1];
    [self.topBgView addSubview:self.reasonLab];
    //尾部
    [self.bottomView addSubview:self.dealLab];
    [self.bottomView addSubview:self.line2];
    [self.bottomView addSubview:self.RefuldLab];
    [self.bottomView addSubview:self.line3];
    [self.bottomView addSubview:self.numberLab];
    //三角形
    [self addSubview:self.image1];
    [self addSubview:self.image2];


}
#pragma mark ************** 添加约束
- (void)addConstraintsForRefuldView
{
    [_timeLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@(24));
        make.centerX.equalTo(self);
    }];
    
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@(140));
        make.top.equalTo(_timeLab1.bottom).offset(10);
    }];
    
    [_timeLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom).offset(10);
        make.width.equalTo(_timeLab1);
        make.height.equalTo(_timeLab1);
        make.centerX.equalTo(self);
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLab2.bottom).offset(10);
        make.width.equalTo(_topBgView);
        make.centerX.equalTo(self);
        make.height.equalTo(@300);
    }];
    
    //顶部
    [_requestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_topBgView).offset(10);
        make.right.equalTo(_topBgView).offset(-10);
        make.height.equalTo(@30);
    }];
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_requestLab.bottom).offset(10);
        make.centerX.equalTo(_topBgView);
        make.height.equalTo(@1);
        make.width.equalTo(_requestLab);

    }];
    [_reasonLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.bottom);
        make.bottom.equalTo(_topBgView);
        make.centerX.equalTo(_topBgView);
        make.width.equalTo(_requestLab);
    }];
    
    //尾部
    [_dealLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(_bottomView).offset(10);
        make.right.equalTo(_bottomView).offset(-10);
        make.height.equalTo(@30);
    }];
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_dealLab.bottom).offset(10);
        make.centerX.equalTo(_bottomView);
        make.height.equalTo(@1);
        make.width.equalTo(_dealLab);
    }];
    [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bottomView).offset(-10);
        make.height.equalTo(_dealLab);
        make.centerX.equalTo(_bottomView);
        make.width.equalTo(_dealLab);
    }];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_numberLab.top).offset(-10);
        make.centerX.equalTo(_bottomView);
        make.height.equalTo(@1);
        make.width.equalTo(_dealLab);
    }];
    [_RefuldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.bottom).offset(10);
        make.bottom.equalTo(_line3.top).offset(-10);
        make.centerX.equalTo(_bottomView);
        make.width.equalTo(_dealLab);
    }];
    
    //三角形
    [_image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView.right).offset(-8);
        make.width.height.equalTo(@25);
        make.top.equalTo(_topBgView).offset(8);
    }];
    [_image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.left).offset(8);
        make.width.height.equalTo(@25);
        make.top.equalTo(_bottomView).offset(8);
    }];
}

@end

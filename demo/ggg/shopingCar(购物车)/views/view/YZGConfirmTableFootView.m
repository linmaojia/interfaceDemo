//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGConfirmTableFootView.h"

@interface YZGConfirmTableFootView ()
@property (nonatomic, strong) UIView *centerView;          /**<  中部视图 */
@property (nonatomic, strong) UIView *bottomView;          /**<  底部背景 */

@property (nonatomic, strong) UILabel *payLab;    /**< 支付方式 */
@property (nonatomic, strong) UILabel *alipayLab;    /**< 支付宝 */
@property (nonatomic, strong) UILabel *commodityLab;    /**< 商品金额 */
@property (nonatomic, strong) UILabel *price;    /**< 总价 */



@end
@implementation YZGConfirmTableFootView
#pragma mark ************** 懒加载控件
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _bottomView;
}
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
        _centerView.layer.borderWidth = 0.5;
        _centerView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _centerView;
}
- (UILabel *)payLab {
    if (!_payLab) {
        _payLab = [[UILabel alloc] init];
        _payLab.textAlignment = NSTextAlignmentLeft;
        _payLab.font = systemFont(14);
        _payLab.text = @"支付配送";
    }
    return _payLab;
}
- (UILabel *)alipayLab {
    if (!_alipayLab) {
        _alipayLab = [[UILabel alloc] init];
        _alipayLab.textAlignment = NSTextAlignmentRight;
        _alipayLab.font = systemFont(14);
        _alipayLab.text = @"支付宝";
    }
    return _alipayLab;
}
- (UILabel *)commodityLab {
    if (!_commodityLab) {
        _commodityLab = [[UILabel alloc] init];
        _commodityLab.textAlignment = NSTextAlignmentLeft;
        _commodityLab.font = systemFont(14);
        _commodityLab.text = @"商品金额";
    }
    return _commodityLab;
}

- (UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.textAlignment = NSTextAlignmentRight;
        _price.font = systemFont(14);
        _price.text = @"￥1033.3";
        _price.textColor = RGB(255,0,0);
    }
    return _price;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(247, 247, 247);
       
        [self addSubviewsForFootView];
        [self addConstraintsForFootView];
    }
    return self;
}
- (void)setTotalPrice:(CGFloat)totalPrice{
    self.price.text = [NSString stringWithFormat:@"%.2f",totalPrice];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForFootView
{
    [self addSubview:self.centerView];//金额
    [self addSubview:self.bottomView];//配送
    
    [self.bottomView addSubview:self.payLab];
    [self.bottomView addSubview:self.alipayLab];
    
    [self.centerView addSubview:self.commodityLab];
    [self.centerView addSubview:self.price];
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForFootView
{
    
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(5);
        make.height.equalTo(@(40));
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_centerView.bottom).offset(5);
        make.height.equalTo(@(40));
    }];
 
    [_commodityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_centerView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(80));
        
    }];
    
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(_centerView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(80));
        
    }];

    [_payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_bottomView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(80));
        
    }];
    [_alipayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(_bottomView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(80));
    }];
}

@end

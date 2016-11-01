//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGConfirmBottomView.h"


@interface YZGConfirmBottomView ()

@property (nonatomic, strong) UIButton *submitBtn;    /**< 下单按钮 */
@property (nonatomic, strong) UILabel *priceLab;    /**< 价格 */
@property (nonatomic, strong) UILabel *countLab;    /**< 商品数量 */

@end

@implementation YZGConfirmBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB(227, 229, 230).CGColor;
        
        [self addSubviewsForConfirmBottomView];
        [self addConstraintsForConfirmBottomView];

    }
    return self;
}

#pragma mark ************** 懒加载控件
- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = mainColor;
        [_submitBtn setTitle:@"立即下单" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = systemFont(14);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitBtnAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _submitBtn;
}
- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textAlignment = NSTextAlignmentRight;
        _priceLab.font = systemFont(13);
        _priceLab.text = @"合计: ￥1044.00";
        _priceLab.textColor = RGB(255,0,0);
    }
    return _priceLab;
}
- (UILabel *)countLab {
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.textAlignment = NSTextAlignmentRight;
        _countLab.font = systemFont(13);
        _countLab.text = @"共 3 件商品";
        _countLab.textColor = RGB(255,0,0);
    }
    return _countLab;
}
- (void)setTotalPrice:(CGFloat)totalPrice{
       _priceLab.text = [NSString stringWithFormat:@"合计: %.2f",totalPrice];
}
- (void)setTotalCount:(NSInteger)totalCount{
    _countLab.text = [NSString stringWithFormat:@"共 %ld 件商品",totalCount];

}

#pragma mark ************** 下单被点击
- (void)submitBtnAction:(UIButton *)sender
{
    if(self.submitBtnBlack)
    {
        self.submitBtnBlack();
    }
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForConfirmBottomView
{
    [self addSubview:self.priceLab];
    [self addSubview:self.submitBtn];
    [self addSubview:self.countLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForConfirmBottomView
{
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.bottom.equalTo(self);
        make.width.equalTo(@(AUTO_MATE_WIDTH(80)));
        
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(_submitBtn.left).offset(-10);
        make.left.equalTo(self);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(45)/2));
        
    }];
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.bottom);
        make.right.equalTo(_submitBtn.left).offset(-10);
        make.left.equalTo(self);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(45)/2));
        
    }];
}

@end

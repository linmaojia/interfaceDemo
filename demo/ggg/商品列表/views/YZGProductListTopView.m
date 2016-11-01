//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductListTopView.h"


@interface YZGProductListTopView()
@property (nonatomic, strong) UIView *lineView;       /**<  底部线 */
@property (nonatomic, strong) UIButton *defaultButton;
@property (nonatomic, strong) UIButton *priceButton;
@property (nonatomic, strong) UIButton *filterButtton;
@property (nonatomic, assign) BOOL desc;/**<  排序 */


@end

@implementation YZGProductListTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =  [UIColor whiteColor];
        
        [self addSubviewsForView];
        
        [self addConstraintsForView];
        
        [self defaultButtonAction];
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UIView *)lineView
{
    if (_lineView == nil)
    {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = RGB(227, 229, 230);
    }
    return _lineView;
    
}
- (UIButton *)defaultButton
{
    if (_defaultButton == nil)
    {
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultButton setTitle:@"默认" forState:UIControlStateNormal];
        _defaultButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_defaultButton setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [_defaultButton setTitleColor:mainColor forState:UIControlStateSelected];
        [_defaultButton addTarget:self action:@selector(defaultButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_defaultButton setImage:[UIImage imageNamed:@"icon_default"] forState:UIControlStateNormal];
        [_defaultButton setImageEdgeInsets:UIEdgeInsetsMake(0, AUTO_MATE_WIDTH(75), 0, 0)];
    }
    return _defaultButton;
    
}
- (UIButton *)priceButton
{
    if (_priceButton == nil)
    {
        _priceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_priceButton setTitle:@"价格" forState:UIControlStateNormal];
        _priceButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_priceButton setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [_priceButton addTarget:self action:@selector(priceBottonAction) forControlEvents:UIControlEventTouchUpInside];
        [_priceButton setImage:[UIImage imageNamed:@"icon_price"] forState:UIControlStateNormal];
        [_priceButton setImage:[UIImage imageNamed:@"icon_price-2"] forState:UIControlStateSelected];
        [_priceButton setImageEdgeInsets:UIEdgeInsetsMake(0, AUTO_MATE_WIDTH(75), 0, 0)];
        [_priceButton setContentEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
        [_priceButton setTitleColor:mainColor forState:UIControlStateSelected];
    }
    return _priceButton;
}
- (UIButton *)filterButtton
{
    if (_filterButtton == nil)
    {
        _filterButtton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_filterButtton setTitle:@"筛选" forState:UIControlStateNormal];
        _filterButtton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_filterButtton setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [_filterButtton addTarget:self action:@selector(filterButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_filterButtton setImage:[UIImage imageNamed:@"icon_screen"] forState:UIControlStateNormal];
        [_filterButtton setImageEdgeInsets:UIEdgeInsetsMake(0, AUTO_MATE_WIDTH(80), 0, 0)];
        [_filterButtton setTitleColor:mainColor forState:UIControlStateSelected];
    }
    return _filterButtton;
    
}

#pragma mark **************** 点击默认按钮
- (void)defaultButtonAction
{
    self.defaultButton.selected = YES;
    self.priceButton.selected = NO;
    self.filterButtton.selected = NO;
    
    if(self.defaultBtnClick)
    {
        self.defaultBtnClick();
    }

}
#pragma mark **************** 点击价格按钮
- (void)priceBottonAction
{
    
    self.defaultButton.selected = NO;
    self.priceButton.selected = YES;
    self.filterButtton.selected = NO;
    
    self.desc = !self.desc;
    if(self.desc == YES)
    {
        //升序
        [_priceButton setImage:[UIImage imageNamed:@"icon_price-2"] forState:UIControlStateSelected];

    }
    else
    {
        //降序
        [_priceButton setImage:[UIImage imageNamed:@"icon_price-3"] forState:UIControlStateSelected];

    }
    
    if(self.priceBtnClick)
    {
        self.priceBtnClick(self.desc);
    }
    
}
#pragma mark **************** 点击筛选按钮
- (void)filterButtonAction
{
    self.defaultButton.selected = NO;
    self.priceButton.selected = NO;
    self.filterButtton.selected = YES;
    
    if(self.filterBtnClick)
    {
        self.filterBtnClick();
    }
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.defaultButton];
    [self addSubview:self.priceButton];
    [self addSubview:self.filterButtton];
    [self addSubview:self.lineView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.height.equalTo(@(40));
    }];
    [_priceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.height.equalTo(@(40));
    }];
    [_filterButtton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.height.equalTo(@(40));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(0.5));
    }];
 
}

@end

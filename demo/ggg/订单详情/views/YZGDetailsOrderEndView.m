//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDetailsOrderEndView.h"
#define padding_x 10
#define optionButton_w 70
#define optionButton_h 30
@interface YZGDetailsOrderEndView ()
{
    CGFloat _price;
}
@property (nonatomic, strong) UIButton *leftBtn;             /**<  左边按钮 */

@end

@implementation YZGDetailsOrderEndView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB(227, 229, 230).CGColor;
        
    }
    return self;
}

#pragma mark ************** 懒加载控件
- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 5, optionButton_w, optionButton_h)];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14.f];
        [_leftBtn addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _leftBtn;
}

- (void)setModel:(YZGNextOhterDetailModel *)model
{
    _model = model;
   
    [self showDownViewWithShowType:model.isCheckState]; //加载右边按钮
}


//显示downView
- (void)showDownViewWithShowType:(showType)showType
{
    //[self removeFromSuperview];
    
    int buttonCount;
    NSArray *titleArray;
    NSString *leftBtnName;
    
    if(showType == showTypePendingPayMoney)
    {
        buttonCount = 2;
        titleArray = @[@"联系卖家", @"付款"];
        leftBtnName = @"取消订单";
    }
    else if (showType == showTypePendingConsignment || showType == showTypePendingConsignmentOther )
    {
        buttonCount = 1;
        titleArray = @[@"联系卖家"];
        
    }
    else if (showType == showTypePendingConsignee)
    {
        buttonCount = 2;
        titleArray = @[@"联系卖家", @"确认收货"];
        
    }
    else if (showType == showTypeComplete)
    {
        buttonCount = 2;
        titleArray = @[@"联系卖家", @"再次购买"];
    }
    else if (showType == showTypeCancel)
    {
        buttonCount = 2;
        titleArray = @[@"联系卖家", @"再次购买"];
        leftBtnName = @"删除订单";
    }
    
    for(int i = 0; i < buttonCount; i ++)
    {
        UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        optionButton.frame = CGRectMake(SCREEN_WIDTH - (i+1) * (optionButton_w + padding_x), 5, optionButton_w, optionButton_h);
        optionButton.tag = 10 + buttonCount - i - 1;
        optionButton.backgroundColor = [UIColor whiteColor];
        [optionButton setTitle:titleArray[buttonCount - i - 1] forState:UIControlStateNormal];
        [optionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        optionButton.layer.cornerRadius = 3;
        optionButton.layer.borderWidth = 1;
        optionButton.layer.borderColor = [UIColor colorWithRed:0.894  green:0.894  blue:0.894 alpha:1].CGColor;
        optionButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        
        [optionButton addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0)
        {
            optionButton.layer.borderColor = RGB(38, 66, 136).CGColor;
            [optionButton setTitleColor:RGB(38, 66, 136) forState:UIControlStateNormal];
        }
        
        [self addSubview:optionButton];
    }
    
    [self.leftBtn setTitle:leftBtnName forState:0];
    [self addSubview:self.leftBtn];
    
}

#pragma mark ************** 按钮点击
- (void)optionButtonClick:(UIButton *)optionButton
{
    
    if(self.endViewBtnClickBlack)//传递按钮标题
    {
        self.endViewBtnClickBlack(optionButton.titleLabel.text);
    }
}

@end

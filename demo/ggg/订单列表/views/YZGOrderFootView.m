//
//  ETShoppingFootView.m
//  Test
//
//  Created by AVGD—JK on 16/1/8.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderFootView.h"
#import "YZGOrderModel.h"
#import "YZGOrderDetailModel.h"

#define padding_x 10
#define optionButton_w 70
@interface YZGOrderFootView() {
    CGFloat _totalPrices;
}

@property(nonatomic, strong)UILabel *priceLabel;   /**< 计算价格label */
@property(nonatomic, strong)UIView *lineView;   /**< 线条 */
@property(nonatomic, strong)UIView *upView;   /**< 上方结算View */
@property(nonatomic, strong)UIView *downView;   /**< 下方按钮View */
@end

@implementation YZGOrderFootView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        
        [self addSubviewsForFootView];
        [self addConstraintsForFootView];
    }
    return self;
}

- (UIView *)downView {
    if (!_downView) {
        _downView = [[UIView alloc] init];
        _downView.backgroundColor = [UIColor whiteColor];
    }
    return _downView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:0.894  green:0.894  blue:0.894 alpha:1];
    }
    return _lineView;
}
- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.font = [UIFont systemFontOfSize:14];
        _priceLabel.text = @"共计4件商品 合计 3.00 元";
    }
    return _priceLabel;
}
- (UIView *)upView {
    if (!_upView) {
        _upView = [[UIView alloc] init];
        _upView.backgroundColor = [UIColor whiteColor];
    }
    return _upView;
}

- (void)setSection:(NSInteger)section{
    _section = section;
}
- (void)setBrandModel:(YZGOrderModel *)brandModel
{
    _brandModel = brandModel;
    
    [self showPriceithModelArray:brandModel.ezgOrderdetailsArr];//计算价格,数量
    
    [self showDownViewWithShowType:brandModel.isCheckState];//显示按钮
}

#pragma mark ************** 显示按钮
- (void)showDownViewWithShowType:(showType)showType
{
    int buttonCount = 0;
    NSArray *titleArray;
    
    if(showType == showTypePendingPayMoney)
    {
        buttonCount = 3;
        titleArray = @[@"联系卖家", @"取消订单", @"付款"];
    }
    else if (showType == showTypePendingConsignment || showType == showTypePendingConsignmentOther)
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
        buttonCount = 3;
        titleArray = @[@"联系卖家", @"删除订单", @"再次购买"];
    }
    
    for (UIButton *button in _downView.subviews)
    {
        if ([button isKindOfClass:[UIButton class]])
        {
            if (button.tag == 100)
            {
                  [button setTitle:titleArray[ buttonCount - 1] forState:0];
                  button.hidden = NO;
            }
            else if (button.tag == 101)
            {
                if ( buttonCount - 2 >= 0)
                {
                    [button setTitle:titleArray[ buttonCount - 2] forState:0];
                    button.hidden = NO;
                }else
                {
                     [button setTitle:@"" forState:0];
                      button.hidden = YES;
                }
            }
            else if(button.tag == 102)
            {
                
                if ( buttonCount - 3 >= 0)
                {
                    [button setTitle:titleArray[ buttonCount - 3] forState:0];
                    button.hidden = NO;
                }else
                {
                    [button setTitle:@"" forState:0];
                    button.hidden = YES;
                }

            }
        }
    }
    
  

   
}
#pragma mark ************** 显示价格
- (void)showPriceithModelArray:(NSArray *)modelArray
{
    
    //处理产品个数
    NSInteger modelArrayCount = 0;
    for (YZGOrderDetailModel *model in modelArray)
    {
        modelArrayCount = model.productQty + modelArrayCount;
    }
    
    //处理总价
    _totalPrices = [self returnTotalPricesWithProductModelArray:modelArray];
    
    //label富文本
    NSString *string = [NSString stringWithFormat:@"共计 %ld 件商品 合计 %.2f 元",modelArrayCount, _totalPrices];
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGB(38, 66, 136)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%ld",modelArrayCount]]];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGB(38, 66, 136)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%.2f", _totalPrices]]];
    
    self.priceLabel.attributedText = attrString;
}

- (CGFloat)returnTotalPricesWithProductModelArray:(NSArray *)modelArray
{
    //处理产品个数
    CGFloat price = 0;
    
    for (YZGOrderDetailModel *model in modelArray) {
        price = model.productQty * model.productPrice + price;
    }
    return price;
}


#pragma mark ************** downView上的button点击事件
- (void)optionButtonClick:(UIButton *)optionButton
{
    if(self.footViewBtnClickBlack)
    {
        //传递按钮标题，section,总价格
        self.footViewBtnClickBlack(optionButton.titleLabel.text,self.section,_totalPrices);
    }
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForFootView
{
    [self addSubview:self.upView];
    [self addSubview:self.priceLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.downView];

    NSArray * titleArray = @[@"联系卖家", @"取消订单", @"付款"];
    for(int i = 0; i < 3; i ++)
    {
        UIButton *optionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        optionButton.tag = 100+i;
        optionButton.backgroundColor = [UIColor clearColor];
        [optionButton setTitle:titleArray[2-i] forState:UIControlStateNormal];
        [optionButton setTitleColor:[UIColor colorWithRed:0.682  green:0.682  blue:0.682 alpha:1] forState:UIControlStateNormal];
        optionButton.layer.cornerRadius = 3;
        optionButton.layer.masksToBounds = YES;
        optionButton.layer.borderWidth = 1;
        optionButton.layer.borderColor = [UIColor colorWithRed:0.894  green:0.894  blue:0.894 alpha:1].CGColor;
        optionButton.titleLabel.font = [UIFont systemFontOfSize:14.f];
        
        [optionButton addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if(i == 0)
        {
            optionButton.layer.borderColor = RGB(38, 66, 136).CGColor;
            [optionButton setTitleColor:RGB(38, 66, 136) forState:UIControlStateNormal];
        }
        
        [self.downView addSubview:optionButton];
    }
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForFootView
{
    [_upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(40));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_upView);
        make.right.equalTo(_upView).offset(-10);
        make.left.equalTo(_upView).offset(10);
        make.height.equalTo(_upView);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.bottom);
        make.right.left.equalTo(_upView);
        make.height.equalTo(@(0.5));
    }];
    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_lineView.bottom);
        make.right.left.equalTo(_upView);
        make.height.equalTo(_upView);
    }];
    
    for(int i = 0;i<3;i++)
    {
        UIButton *_myButton = (UIButton *)[_downView viewWithTag:100+i];
        
        [_myButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(_downView).offset(-(i*(optionButton_w + padding_x)+ padding_x));
            make.height.equalTo(@(30));
            make.centerY.equalTo(_downView);
            make.width.equalTo(@(optionButton_w));
            
        }];
    }

}
@end

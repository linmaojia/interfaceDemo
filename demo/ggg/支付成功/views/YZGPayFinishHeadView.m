//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGPayFinishHeadView.h"


@interface YZGPayFinishHeadView ()
@property (nonatomic, strong) UILabel *payWayLab;        /**< 支付方式 */
@property (nonatomic, strong) UIView *orderTypeBg;            /**<  订单状态背景 */
@property (nonatomic, strong) UILabel *priceLab;         /**< 订单金额 */
@property (nonatomic, strong) UIImageView *orderTypeImg;    /**< 订单状态图片 */
@property (nonatomic, strong) UIView *centerView;            /**<  底部视图（订单详情和回到首页按钮） */

@property (nonatomic, strong) UIView *bottomView;           /**<  本周上新视图背景 */
@property (nonatomic, strong) UILabel *handLab;      /**< 剁手 */
@property (nonatomic, strong) UIImageView *newsImg;    /**< 上新图片 */

@end

@implementation YZGPayFinishHeadView
#pragma mark ************** 懒加载控件
- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [[UIView alloc] init];
        _centerView.backgroundColor = [UIColor whiteColor];
      
    }
    return _centerView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB(247, 247, 247);
    }
    return _bottomView;
}
- (UIImageView *)newsImg {
    if (!_newsImg) {
        _newsImg = [[UIImageView alloc] init];
        _newsImg.image = [UIImage imageNamed:@"banner"];
        _newsImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(newImgClick:)];
        [_newsImg addGestureRecognizer:tap];
    }
    return _newsImg;
}
- (UILabel *)handLab {
    if (!_handLab) {
        _handLab = [[UILabel alloc] init];
        _handLab.textColor = [UIColor grayColor];
        _handLab.font = systemFont(14);
        _handLab.textAlignment = NSTextAlignmentCenter;
        _handLab.text = @"/为您推荐/";
    }
    return _handLab;
}

- (UILabel *)payWayLab {
    if (!_payWayLab) {
        _payWayLab = [[UILabel alloc] init];
        _payWayLab.textColor = [UIColor blackColor];
        _payWayLab.font = systemFont(14);
        _payWayLab.textAlignment = NSTextAlignmentLeft;
         _payWayLab.text = @"支付方式: 在线支付";
        _payWayLab.attributedText = [self ParagraphStyle:@"支付方式 :在线支付" :@"在线支付"];//富文本
        _payWayLab.textAlignment = NSTextAlignmentRight;
    }
    return _payWayLab;
}
- (UIView *)orderTypeBg {
    if (!_orderTypeBg) {
        _orderTypeBg = [[UIView alloc] init];
        _orderTypeBg.backgroundColor = [UIColor whiteColor];
    }
    return _orderTypeBg;
}
- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textAlignment = NSTextAlignmentLeft;
        _priceLab.font = systemFont(14);
        _priceLab.textColor = [UIColor blackColor];
        _priceLab.text = @"订单金额：￥12.22";
    }
    return _priceLab;
}
- (UIImageView *)orderTypeImg {
    if (!_orderTypeImg) {
        _orderTypeImg = [[UIImageView alloc] init];
        [_orderTypeImg setContentMode:UIViewContentModeScaleAspectFit];
         _orderTypeImg.image = [UIImage imageNamed:@"icon_my_order_06"];
    }
    return _orderTypeImg;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubviewsForHeadView];
        [self addConstraintsForHeadView];
     
    }
    return self;
}
- (void)creatOrderBtn {
    
    //中部视图
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_orderTypeBg.bottom);
        make.height.equalTo(@(60));
    }];
    
    NSArray *nameArray = @[@"查看订单",@"回到首页"];
    NSMutableArray *viewArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        
        UIButton * btn=[[UIButton alloc]init];
        [btn setTitle:nameArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(83, 83, 83) forState:UIControlStateNormal];
        btn.titleLabel.font = systemFont(14);//标题文字大小
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = RGB(83, 83, 83).CGColor;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(blackBtnClick:) forControlEvents:UIControlEventTouchDown];
        [self.centerView addSubview:btn];
        [viewArray addObject:btn];
        
    }
    
    [viewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:20 leadSpacing:30 tailSpacing:20];
    [viewArray makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(35));
        make.bottom.equalTo(@(-10));
    }];
}

- (void)setPrice:(CGFloat)price{
    
    NSString *str = [NSString stringWithFormat:@"订单金额: ￥%.2f",price];
    NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",price];
    _priceLab.attributedText = [self ParagraphStyle:str :priceStr];//富文本
    _priceLab.textAlignment = NSTextAlignmentRight;
 
}

- (NSMutableAttributedString *)ParagraphStyle:(NSString *)str :(NSString *)allPrice{
    
    //富文本
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange theRange1=[str rangeOfString:allPrice];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:RGB(38, 66, 136) range:theRange1];
    
    return AttributedStr;
}
#pragma mark ************** 按钮被点击
- (void)blackBtnClick:(UIButton *)sender
{
    if(self.blackBtnBlack)
    {
        self.blackBtnBlack(sender.titleLabel.text);
    }
}
#pragma mark ************** 本周上新被点击
-(void)newImgClick:(UITapGestureRecognizer *)sender
{
    if(self.newImgClickBlack)
    {
        self.newImgClickBlack();
    }
   
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForHeadView
{
    [self addSubview:self.orderTypeBg];
    [self addSubview:self.centerView];
    [self addSubview:self.bottomView];
    
    [self.orderTypeBg addSubview:self.orderTypeImg];
    [self.orderTypeBg addSubview:self.payWayLab];
    [self.orderTypeBg addSubview:self.priceLab];
    
    [self creatOrderBtn];//中部
    //创建底部视图
    [self.bottomView addSubview:self.newsImg];
    [self.bottomView addSubview:self.handLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForHeadView
{
    [_orderTypeBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(100));
    }];
    [_orderTypeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(AUTO_MATE_WIDTH(45));
        make.height.width.equalTo(@(70));
        make.centerY.equalTo(_orderTypeBg);
    }];
    [_payWayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderTypeImg.right).offset(10);
        make.top.equalTo(_orderTypeImg.top).offset(5);
        make.height.equalTo(@(30));
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderTypeImg.right).offset(10);
        make.top.equalTo(_payWayLab.bottom).offset(5);
        make.height.equalTo(@(30));
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(_centerView.bottom).offset(5);
        make.height.equalTo(@(95));
    }];
    
    [_newsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(_bottomView);
        make.height.equalTo(@(70));
    }];
    
    [_handLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(_bottomView);
        make.top.equalTo(_newsImg.bottom);
        make.height.equalTo(@(35));
    }];
}

@end

//
//  MJShoppingCarBottomView.m
//  Masonry
//
//  Created by LXY on 16/5/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "MJShoppingCarBottomView.h"
#import "MJShoppingCarModel.h"
@interface MJShoppingCarBottomView ()
{
    CGFloat _totalPrices;  //总价
}
@property (nonatomic, strong) UILabel *checkAllLab;    /**< 全选文字 */
@property (nonatomic, strong) UILabel *totalPricesLab;    /**< 总价文字 */
@property (nonatomic, strong) UIButton *settlementBtn;    /**< 结算按钮 */
@property (nonatomic, strong) UIButton *collectBtn;            /**<  收藏按钮 */
@property (nonatomic, strong) UIButton *deleBtn;            /**<  删除按钮 */

@end

@implementation MJShoppingCarBottomView
- (UIButton *)deleBtn {
    if (!_deleBtn) {
        _deleBtn=[[UIButton alloc]init];
        [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleBtn setTitleColor:RGB(38, 66, 136) forState:UIControlStateNormal];
        _deleBtn.titleLabel.font = systemFont(14);//标题文字大小
        _deleBtn.layer.borderWidth = 0.5;
        _deleBtn.layer.borderColor = RGB(38, 66, 136).CGColor;
        _deleBtn.layer.cornerRadius = 2;
        _deleBtn.layer.masksToBounds = YES;
        _deleBtn.hidden = YES;
        [_deleBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _deleBtn;
}
- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn=[[UIButton alloc]init];
        [_collectBtn setTitle:@"移入收藏" forState:UIControlStateNormal];
        [_collectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _collectBtn.titleLabel.font = systemFont(14);//标题文字大小
        _collectBtn.layer.borderWidth = 0.5;
        _collectBtn.layer.borderColor = [UIColor grayColor].CGColor;
        _collectBtn.layer.cornerRadius = 2;
        _collectBtn.layer.masksToBounds = YES;
        _collectBtn.hidden = YES;
        [_collectBtn addTarget:self action:@selector(deleBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _collectBtn;
}
- (UIButton *)checkAllBtn {
    if (!_checkAllBtn) {
        _checkAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkAllBtn setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_checkAllBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_checkAllBtn addTarget:self action:@selector(checkAllAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _checkAllBtn;
}

- (UILabel *)checkAllLab {
    if (!_checkAllLab) {
        _checkAllLab = [[UILabel alloc] init];
        _checkAllLab.text = @"全选";
        _checkAllLab.font = [UIFont systemFontOfSize:16];
        _checkAllLab.textAlignment = NSTextAlignmentCenter;
    }
    return _checkAllLab;
}

- (UILabel *)totalPricesLab {
    if (!_totalPricesLab) {
        _totalPricesLab = [[UILabel alloc] init];
        _totalPricesLab.font = [UIFont systemFontOfSize:14];
        _totalPricesLab.numberOfLines = 0;
        _totalPricesLab.textColor = [UIColor blackColor];
        NSString *priceStr = @"总价: 0.00元\n共 0 件商品"; //富文本
        [self ParagraphStyle:priceStr TotalCount:@" 0 " TotalPrice:@"0.00"];//富文本
 
    }
    return _totalPricesLab;
}

- (UIButton *)settlementBtn {
    if (!_settlementBtn) {
        _settlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settlementBtn.backgroundColor = mainColor;
        [_settlementBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settlementBtn addTarget:self action:@selector(settlementBtnAction:) forControlEvents:UIControlEventTouchDown];
    }
    return _settlementBtn;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubviewsForShoppingCarBottomView];
        
        [self addConstraintsForShoppingCarBottomView];

    }
    return self;
}
#pragma mark ************** 底部回复默认状态
- (void)setIsSetZero:(BOOL)isSetZero
{
    
    _totalPrices = 0;
    
    _checkAllBtn.selected = NO;
    
    NSString *priceStr = @"总价: 0.00元\n共 0 件商品"; //富文本
    
    [self ParagraphStyle:priceStr TotalCount:@" 0 " TotalPrice:@"0.00"];//富文本
    
}
#pragma mark ************** 是否编辑状态
- (void)setIsEdit:(BOOL)isEdit{
   if(isEdit)
   {
       self.totalPricesLab.hidden = YES;
       self.settlementBtn.hidden = YES;
       
       self.deleBtn.hidden = NO;
       self.collectBtn.hidden = NO;

   }
   else
   {
       self.totalPricesLab.hidden = NO;
       self.settlementBtn.hidden = NO;
       
       self.deleBtn.hidden = YES;
       self.collectBtn.hidden = YES;
   }
}
#pragma mark ************** 删除被点击
- (void)deleBtnClick:(UIButton *)sender{
    
    if(_totalPrices>0)
    {
        if(self.deleClickBlock)
        {
            self.deleClickBlock(sender.titleLabel.text);
        }
        
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"您还没有选择宝贝哦"];
    }
    
}

- (void)BottomChangeWithTotalPrices:(CGFloat)totalPrices TotalCount:(NSInteger )totalCount{
    
    _totalPrices = totalPrices;

    NSString *priceStr = [NSString stringWithFormat:@"总价: %.2f元\n共 %ld 件商品",totalPrices,totalCount];
    NSString *count = [NSString stringWithFormat:@" %ld ",totalCount];
    NSString *totalPrice = [NSString stringWithFormat:@"%.2f",totalPrices];
    [self ParagraphStyle:priceStr TotalCount:count TotalPrice:totalPrice];//富文本
}
#pragma mark ************** 富文本
- (void)ParagraphStyle:(NSString *)priceStr TotalCount:(NSString *)totalCount TotalPrice:(NSString *)totalPrice{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 4.0f;// 行间距
    NSDictionary *ats = @{NSParagraphStyleAttributeName : paragraphStyle};
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] initWithString:priceStr attributes:ats];
    [priceString addAttribute:NSForegroundColorAttributeName
                        value:RGB(255,0,0)
                        range:[priceStr rangeOfString:totalCount]];
    [priceString addAttribute:NSForegroundColorAttributeName
                        value:RGB(255,0,0)
                        range:[priceStr rangeOfString:totalPrice]];
    _totalPricesLab.attributedText = priceString;
    _totalPricesLab.textAlignment = NSTextAlignmentLeft;
    
}
#pragma mark ************** 全选方法
- (void)checkAllAction:(UIButton *)sender{

    sender.selected = !sender.selected;
    
    if(self.delegate && [self.delegate conformsToProtocol:@protocol(BottomViewDelegate)])
    {
        [self.delegate BottomViewCheckAllAction:sender.selected];
    }
    
}
#pragma mark ************** 结算方法
- (void)settlementBtnAction:(UIButton *)sender{
    //价格大于0才能被点击
    if(_totalPrices>0)
    {
        if(self.delegate && [self.delegate conformsToProtocol:@protocol(BottomViewDelegate)])
        {
            [self.delegate BottomViewSettlementBtnAction];
        }
    }
    else
    {
        [SVProgressHUD showInfoWithStatus:@"您还没有选择宝贝哦"];
    }
    
    
    
}
#pragma mark **************** 添加子控件
- (void)addSubviewsForShoppingCarBottomView
{
    
    [self addSubview:self.checkAllBtn];
    [self addSubview:self.checkAllLab];
    [self addSubview:self.totalPricesLab];
    [self addSubview:self.settlementBtn];
    //删除和收藏按钮
    [self addSubview:self.deleBtn];
    [self addSubview:self.collectBtn];
}
#pragma mark **************** 约束
- (void)addConstraintsForShoppingCarBottomView
{
    [_checkAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(35));
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
    [_checkAllLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_checkAllBtn.right);
        make.height.equalTo(@(20));
        make.width.equalTo(@(35));
        make.centerY.equalTo(self);
    }];
    [_settlementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.top.bottom.equalTo(self);
        make.width.equalTo(@(100));
    }];
    [_totalPricesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_checkAllLab.right).offset(10);
        make.height.equalTo(self);
        make.right.equalTo(_settlementBtn.left).offset(-10);
        make.centerY.equalTo(self);
    }];
    
    //删除，收藏按钮
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(@(70));
        make.height.equalTo(@(40));
        make.right.equalTo(self).offset(-10);
    }];
    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.equalTo(_deleBtn);
        make.height.equalTo(_deleBtn);
        make.right.equalTo(_deleBtn.left).offset(-10);
    }];
}

@end

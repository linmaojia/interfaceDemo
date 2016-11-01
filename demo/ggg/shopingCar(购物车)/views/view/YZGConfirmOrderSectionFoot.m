

#import "YZGConfirmOrderSectionFoot.h"


@interface YZGConfirmOrderSectionFoot ()

@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */

@property (nonatomic, strong) UIButton *remarksBtn;    /**< 备注按钮 */
@property (nonatomic, strong) UILabel *remarksLab;    /**< 备注文本 */
@end

@implementation YZGConfirmOrderSectionFoot

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = hexColor(FFFFFF);
        _bottomView.layer.borderWidth = 0.5;
        _bottomView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _bottomView;
}
- (UIButton *)remarksBtn {
    if (!_remarksBtn) {
        _remarksBtn = [[UIButton alloc]init];
        [_remarksBtn setImage:[UIImage imageNamed:@"icon_edit"] forState:UIControlStateNormal];
        [_remarksBtn addTarget:self action:@selector(remarksBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _remarksBtn;
}
- (UILabel *)remarksLab {
    if (!_remarksLab) {
        _remarksLab = [[UILabel alloc] init];
        _remarksLab.font = [UIFont systemFontOfSize:14];
        _remarksLab.numberOfLines = 0;
        _remarksLab.textColor = [UIColor grayColor];
        _remarksLab.backgroundColor = [UIColor whiteColor];
        _remarksLab.text = @"订单备注";//请输入该品牌订单的备注
    }
    return _remarksLab;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentRight;
        _titleLab.font = systemFont(14);
        _titleLab.text = @"共计10件商品，399元";
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];//需要用contentView
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB(227, 229, 230).CGColor;
        
        [self addSubViewsForFoot];
        [self addConstraintsForFoot];
    }
    return self;
}

- (void)setModel:(MJShoppingCarModel *)model{
    _model = model;
    
    CGFloat totalPrices = 0.f; //总价格
    NSInteger totalCount = 0; //总数量
    
    for(Products *product in model.products)
    {
            ProductDetail *productDetail = product.productDetail;
            totalPrices += product.productQty *productDetail.dealerPurchasePrice;
            totalCount  += product.productQty;
    }

    //label富文本
    NSString *string = [NSString stringWithFormat:@"共计 %ld 件商品 合计 %.2f 元",totalCount, totalPrices];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGB(255,0,0)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%ld",totalCount]]];
    
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:RGB(255,0,0)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%.2f", totalPrices]]];
    self.titleLab.attributedText = attrString;
    self.titleLab.textAlignment = NSTextAlignmentRight;
    
    //品牌订单备注
    NSString *remarkString = model.remarkText ? model.remarkText : @"品牌备注:";
    _remarksLab.text = remarkString;
    
}
- (void)setSection:(NSInteger)section
{
    _section = section;
}
#pragma mark ************** 备注点击事件
- (void)remarksBtnClick:(UIButton *)sender
{
    if(self.remarkFootClick)
    {
        self.remarkFootClick(_section,_remarksLab.text);
    }
  
}

- (void)addSubViewsForFoot
{
     [self addSubview:self.titleLab];
     [self addSubview:self.bottomView];

    //尾部
    [self.bottomView addSubview:self.remarksBtn];
    [self.bottomView addSubview:self.remarksLab];
}
- (void)addConstraintsForFoot
{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.right.equalTo(self).offset(-8);
        make.height.equalTo(@40);
       
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLab.bottom);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    //底部
    [_remarksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView).offset(-10);
        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.centerY.equalTo(_bottomView);
        
    }];
    [_remarksLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView).offset(5);
        make.left.equalTo(_bottomView).offset(10);
        make.right.equalTo(_remarksBtn.left).offset(-10);
        make.bottom.equalTo(@(-5));
        
    }];
    
}


@end

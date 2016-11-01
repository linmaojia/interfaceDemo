//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductListCell.h"

@interface YZGProductListCell()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) UILabel *nameLab;             /**<  产品名称 */
@property (nonatomic, strong) UILabel *numLab;             /**<  产品编号 */
@property (nonatomic, strong) UILabel *priceLab;              /**<  零售格 */
@property (nonatomic, strong) UILabel *tradePrice;            /**<  批发价 */
@property (nonatomic, strong) UILabel *sizeLab;    /**< 商品规格 */
@property (nonatomic, strong) UIView *lineView;            /**<  顶部线 */
@property (nonatomic, strong) UIButton *addToCartButton;


@end
@implementation YZGProductListCell

- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(13);
        _sizeLab.textColor = [UIColor blackColor];
    }
    return _sizeLab;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
        
    }
    return _lineView;
}

#pragma mark ************** 懒加载控件
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"account_highlight"];
        [_leftImg setContentMode:UIViewContentModeScaleAspectFit];
        
    }
    return _leftImg;
}
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.font = systemFont(16);
        _nameLab.text = @"七里博城-dfdfs";
    }
    return _nameLab;
}
- (UILabel *)numLab {
    if (!_numLab) {
        _numLab = [[UILabel alloc] init];
        _numLab.textAlignment = NSTextAlignmentLeft;
        _numLab.font = systemFont(15);
        _numLab.text = @"七里博城-dfdfs";
    }
    return _numLab;
}

- (UILabel *)tradePrice {
    if (!_tradePrice) {
        _tradePrice = [[UILabel alloc] init];
        _tradePrice.textAlignment = NSTextAlignmentLeft;
        _tradePrice.textColor = RGB(255,0,0);
        _tradePrice.font = systemFont(14);
        _tradePrice.text = @"批发价：233.99元";
    }
    return _tradePrice;
}
- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.textAlignment = NSTextAlignmentLeft;
        _priceLab.textColor = [UIColor grayColor];
        _priceLab.font = systemFont(13);
        _priceLab.text = @"零售价:10.00元";
    }
    return _priceLab;
}


#pragma mark ************** 设置cell 内容
- (void)setModel:(ProductDetail *)model{
    _model = model;
    
    NSURL *imgUrl = [NSURL URLWithString:[[model.path stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_leftImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
    
    _nameLab.text = [NSString stringWithFormat:@"%@%@%@",model.brandName,model.style ,model.productType ];
    _numLab.text = model.productNum;
    
    _priceLab.text = [NSString stringWithFormat:@"零售: %.2f元",model.productPrice];
    _tradePrice.text = [NSString stringWithFormat:@"批发: %.2f元",model.dealerPurchasePrice];
    
    NSString *specWidth = model.specWidth ? model.specWidth : @"0";
    NSString *specHeight = model.specHeight ? model.specHeight : @"0";
    NSString *specdd = model.specLength ? model.specLength : @"0";
    
     _sizeLab.text = [NSString stringWithFormat:@"规格: W:%@ H:%@ D:%@",specWidth,specHeight,specdd];
    
}
- (void)returnColor
{
    _nameLab.textColor = [UIColor blackColor];
    _numLab.textColor = [UIColor blackColor];
    _tradePrice.textColor = RGB(255,0,0);
    _sizeLab.textColor = [UIColor blackColor];
}
- (void)changeGrayColor
{
    _nameLab.textColor = [UIColor grayColor];
    _numLab.textColor = [UIColor grayColor];
    _tradePrice.textColor = [UIColor grayColor];
    _sizeLab.textColor = [UIColor grayColor];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.leftImg];
   
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.sizeLab];
    [self.contentView addSubview:self.tradePrice];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.addToCartButton];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@(10));
        make.height.width.equalTo(@(100));
    }];
   
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg.top);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(20));
    }];
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(5);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(15));
    }];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numLab.mas_bottom).offset(5);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@15);
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sizeLab.bottom).offset(5);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(20));
    }];
    [_tradePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLab.bottom);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(20));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
  
}

@end

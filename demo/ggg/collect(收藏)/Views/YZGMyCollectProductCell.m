//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGMyCollectProductCell.h"

@interface YZGMyCollectProductCell()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) UILabel *nameLab;             /**<  产品名称 */
@property (nonatomic, strong) UILabel *numLab;             /**<  产品编号 */
@property (nonatomic, strong) UILabel *tradePrice;            /**<  批发价 */
@property (nonatomic, strong) UIButton *sameBtn;             /**<  同类推荐 */

@property (nonatomic, strong) UIButton *carBtn;         /**<  购物车 */
@property (nonatomic, strong) UIView *lineView;            /**<  顶部线 */
@property (nonatomic, strong) UILabel *sizeLab;    /**< 商品规格 */
@property (nonatomic, strong) UILabel *priceLab;              /**<  零售格 */

@end
@implementation YZGMyCollectProductCell

#pragma mark ************** 懒加载控件
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
- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(12);
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
        _numLab.text = @"MYDIDJLOSL";
    }
    return _numLab;
}

- (UILabel *)tradePrice {
    if (!_tradePrice) {
        _tradePrice = [[UILabel alloc] init];
        _tradePrice.textAlignment = NSTextAlignmentLeft;
        _tradePrice.textColor = RGB(255, 79, 0);
        _tradePrice.font = systemFont(14);
        _tradePrice.text = @"233.99元";
    }
    return _tradePrice;
}
- (UIButton *)sameBtn {
    if (!_sameBtn) {
        _sameBtn=[[UIButton alloc]init];
        [_sameBtn setTitle:@"同类推荐" forState:UIControlStateNormal];
        [_sameBtn setTitleColor:RGB(51,51,51) forState:UIControlStateNormal];
        _sameBtn.titleLabel.font = systemFont(14);//标题文字大小
        _sameBtn.layer.borderWidth = 0.5;
        _sameBtn.layer.borderColor = RGB(201,201,201).CGColor;
        _sameBtn.layer.cornerRadius = 3;
        _sameBtn.layer.masksToBounds = YES;
        [_sameBtn addTarget:self action:@selector(sameBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _sameBtn;
}

- (UIButton *)carBtn {
    if (!_carBtn) {
        _carBtn = [[UIButton alloc]init];
        [_carBtn setImage:[UIImage imageNamed:@"icon_shopping_gray"] forState:UIControlStateNormal];
        [_carBtn addTarget:self action:@selector(carBtnClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _carBtn;
}
#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGMyCollecProductModel *)model{
    _model = model;
    ProductDetail *productDetail = model.productDetail;
    NSURL *imgUrl = [NSURL URLWithString:[[productDetail.path stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_leftImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
    
    _nameLab.text = [NSString stringWithFormat:@"%@%@%@",productDetail.brandName,productDetail.style ,productDetail.productType ];
    _numLab.text = productDetail.productNum;
    
    _priceLab.text = [NSString stringWithFormat:@"零售: %.2f元",productDetail.productPrice];
    _tradePrice.text = [NSString stringWithFormat:@"批发: %.2f元",productDetail.dealerPurchasePrice];
    
    NSString *specWidth = productDetail.specWidth ? productDetail.specWidth : @"0";
    NSString *specHeight = productDetail.specHeight ? productDetail.specHeight : @"0";
    NSString *specdd = productDetail.specLength ? productDetail.specLength : @"0";
    _sizeLab.text = [NSString stringWithFormat:@"规格: W:%@ H:%@ D:%@",specWidth,specHeight,specdd];
    
}

#pragma mark ************** 同类推荐
- (void)sameBtnClick:(UIButton *)sender
{
    ProductDetail *productDetail = _model.productDetail;
    NSString *productId = productDetail.seqid;
    
    if(self.sameBtnClickBlack)
    {
        self.sameBtnClickBlack(productId);
    }
    
}
#pragma mark ************** 购物车点击
- (void)carBtnClick:(UIButton *)sender
{
    
    ProductDetail *productDetail = _model.productDetail;
    NSString *productId = productDetail.seqid;
    
    if(self.carBtnClickBlack)
    {
        self.carBtnClickBlack(productId,self.leftImg);
    }
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
      
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.leftImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.sizeLab];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.tradePrice];
    [self.contentView addSubview:self.sameBtn];
    [self.contentView addSubview:self.carBtn];
    [self.contentView addSubview:self.lineView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForCell
{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@(10));
        make.height.width.equalTo(@(110));
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg.top).offset(-10);
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
    
    [_sameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tradePrice.bottom);
        make.left.equalTo(_leftImg.right).offset(10);
        make.width.equalTo(@(76));
        make.height.equalTo(@(26));
    }];
    
    [_carBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_sameBtn);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.height.equalTo(@(30));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
}

@end

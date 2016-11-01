//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGOrderCell.h"

@interface YZGOrderCell()
@property (nonatomic, strong) UIView *spaceView;          /**<  顶部空隙 */
@property (nonatomic, strong) UIImageView *productImg;    /**< 商品图片 */
@property (nonatomic, strong) UILabel *productNameLab;    /**< 商品名称 */
@property (nonatomic, strong) UILabel *sizeLab;          /**< 商品规格 */
@property (nonatomic, strong) UILabel *priceLab;        /**< 商品原价 */


@end
@implementation YZGOrderCell

#pragma mark ************** 懒加载控件
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = [UIColor whiteColor];
    }
    return _spaceView;
}
- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.image = [UIImage imageNamed:@"account_highlight"];
        [_productImg setContentMode:UIViewContentModeScaleAspectFit];
        _productImg.layer.borderWidth = 0.5;
        _productImg.layer.borderColor = RGB(227, 229, 230).CGColor;
        _productImg.backgroundColor = [UIColor whiteColor];
    }
    return _productImg;
}

- (UILabel *)productNameLab {
    if (!_productNameLab) {
        _productNameLab = [[UILabel alloc] init];
        _productNameLab.textAlignment = NSTextAlignmentLeft;
        _productNameLab.font = boldSystemFont(15);
        _productNameLab.text = @"失联飞机老地方了圣诞节发";
    }
    return _productNameLab;
}

- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(12);
        _sizeLab.textColor = [UIColor grayColor];
        _sizeLab.textAlignment = NSTextAlignmentLeft;
        _sizeLab.text = @"规格:W:813 H:640";
    }
    return _sizeLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = systemFont(12);
        _priceLab.textColor = RGB(38, 66, 136);
        _priceLab.textAlignment = NSTextAlignmentLeft;
        _priceLab.text = @"7739.00元";
    }
    return _priceLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = RGB(246, 246, 246);
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}

- (void)setModel:(YZGOrderDetailModel *)model{
    _model = model;
    
    //图片
    Orderdetails *productModel = model.productDetail;
    NSURL *imgUrl = [NSURL URLWithString:[[productModel.path stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_productImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];

    //名称
    _productNameLab.text = [NSString stringWithFormat:@"%@ %@ %@",productModel.brandName,productModel.style,productModel.productNum];

    if([productModel.productType isEqualToString:@"物料"])
    {
        _sizeLab.hidden = YES;
    }
    else
    {
         _sizeLab.text = [NSString stringWithFormat:@"规格:W:%@ H:%@ D:%@",productModel.specWidth,productModel.specHeight,productModel.specLength];
         _sizeLab.hidden = NO;
    }

     _priceLab.text = [NSString stringWithFormat:@"%.2lf 元  x %ld", model.productPrice,model.productQty];
    
}

#pragma mark ************** 按钮被点击
- (void)deleBtnClick:(UIButton *)sender{
    
    if(self.deleBtnClickBlack)
    {
        self.deleBtnClickBlack(sender.titleLabel.text);
    }
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.spaceView];
    [self.contentView addSubview:self.productImg];
    [self.contentView addSubview:self.productNameLab];
    [self.contentView addSubview:self.sizeLab];
    [self.contentView addSubview:self.priceLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForCell
{
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(@(5));
    }];
    
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_spaceView.bottom).offset(10);
        make.left.equalTo(self.contentView).offset(20);
        make.width.height.equalTo(@(60));
    }];
    [_productNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productImg.top).offset(5);
        make.left.equalTo(_productImg.right).offset(10);
        make.height.equalTo(@(15));
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productNameLab.bottom).offset(8);
        make.left.equalTo(_productImg.right).offset(10);
        make.height.equalTo(@(10));
        make.right.equalTo(self.contentView).offset(-5);
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sizeLab.bottom).offset(8);
        make.left.equalTo(_productImg.right).offset(10);
        make.height.equalTo(@(10));
        make.right.equalTo(self.contentView).offset(-5);
    }];
}

@end

//
//  MyShoppingCarCell.m
//  Masonry
//
//  Created by LXY on 16/5/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGConfirmOrderCell.h"

@interface YZGConfirmOrderCell ()

@property (nonatomic, strong) UIView *topBgView;    /**< 图片背景view */
@property (nonatomic, strong) UIView *bottomView;    /**< 底部背景view */
@property (nonatomic, strong) UILabel *remarksLab;    /**< 备注文本 */

@end

@implementation YZGConfirmOrderCell


#pragma mark ************** 内部初始化方法
- (UILabel *)remarksLab {
    if (!_remarksLab) {
        _remarksLab = [[UILabel alloc] init];
        _remarksLab.font = [UIFont systemFontOfSize:12];
        _remarksLab.numberOfLines = 0;
        _remarksLab.textColor = [UIColor grayColor];
        _remarksLab.backgroundColor = [UIColor whiteColor];
        _remarksLab.text = @"";
    }
    return _remarksLab;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

#pragma mark ************** 懒加载控件
- (UIView *)topBgView {
    if (!_topBgView) {
        _topBgView = [[UIView alloc] init];
        _topBgView.backgroundColor = [UIColor whiteColor];
        _topBgView.layer.borderWidth = 0.5;
        _topBgView.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _topBgView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _topBgView.backgroundColor = [UIColor whiteColor];
      
    }
    return _bottomView;
}



- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.layer.borderWidth = 0.5;
        _productImg.layer.borderColor = RGB(227, 229, 230).CGColor;
    }
    return _productImg;
}

- (UILabel *)productNameLab {
    if (!_productNameLab) {
        _productNameLab = [[UILabel alloc] init];
        _productNameLab.font = systemFont(16);
    }
    return _productNameLab;
}

- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(12);
        _sizeLab.textColor = hexColor(949494);
        _sizeLab.numberOfLines = 0;
    }
    return _sizeLab;
}
- (UILabel *)countLab {
    if (!_countLab) {
        _countLab = [[UILabel alloc] init];
        _countLab.font = systemFont(12);
        _countLab.textColor = RGB(255,0,0);
        _countLab.textAlignment = NSTextAlignmentRight;
    }
    return _countLab;
}

- (UILabel *)costPriceLab {
    if (!_costPriceLab) {
        _costPriceLab = [[UILabel alloc] init];
        _costPriceLab.font = systemFont(12);
        _costPriceLab.textColor = RGB(255,0,0);
        _costPriceLab.textAlignment = NSTextAlignmentLeft;
        _costPriceLab.text = @"333.0元";
    }
    return _costPriceLab;
}
- (UILabel *)originalPriceLab {
    if (!_originalPriceLab) {
        _originalPriceLab = [[UILabel alloc] init];
        _originalPriceLab.font = systemFont(12);
        _originalPriceLab.textColor = hexColor(949494);
        _originalPriceLab.textAlignment = NSTextAlignmentLeft;
        _originalPriceLab.text = @"零售价:222.0元";
    }
    return _originalPriceLab;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = hexColor(FAFAFA);
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self addSubViewsForCarCell];
        [self addConstraintsForCarCell];
    
    }
    return self;
}


#pragma mark ************** 更新数据
- (void)setModel:(Products *)model {
    
    
    
    _model = model;

    ProductDetail *productDetailModel =  model.productDetail;
    //图片
     NSString *productPicUri = [[productDetailModel.path stringByAppendingString:@"@!product-list" ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];//转码
    [_productImg sd_setImageWithURL:[NSURL URLWithString:productPicUri] placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];

    _productNameLab.text = [NSString stringWithFormat:@"%@%@%@",productDetailModel.brandName,productDetailModel.style,productDetailModel.productType];

    NSString *specWidth = productDetailModel.specWidth ? productDetailModel.specWidth : @"0";
    NSString *specHeight = productDetailModel.specHeight ? productDetailModel.specHeight : @"0";
    NSString *specdd = productDetailModel.specLength ? productDetailModel.specLength : @"0";
    if([productDetailModel.productType isEqualToString:@"物料"])
    {
        _sizeLab.hidden = YES;
    }
    else
    {
        _sizeLab.text = [NSString stringWithFormat:@"规格: W:%@ H:%@ D:%@",specWidth,specHeight,specdd];

        _sizeLab.hidden = NO;
    }

    _costPriceLab.text = [NSString stringWithFormat:@"批发价:%.2f元",productDetailModel.dealerPurchasePrice];
    _originalPriceLab.text = [NSString stringWithFormat:@"零售价:%.2f元",productDetailModel.productPrice];

    _countLab.text = [NSString stringWithFormat:@"x%ld",model.productQty];
    
    
    //备注信息
    NSString *remarkString = model.productDesc ? [NSString stringWithFormat:@"商品备注:%@",model.productDesc] : @"商品备注: 无";
    _remarksLab.text = remarkString;
}

#pragma mark ************** 加载视图
- (void)addSubViewsForCarCell
{

    
    [self.contentView addSubview:self.topBgView];
    [self.contentView addSubview:self.bottomView];
    
    //顶部
    [self.topBgView addSubview:self.productImg];
    [self.topBgView addSubview:self.productNameLab];
    [self.topBgView addSubview:self.sizeLab];
    [self.topBgView addSubview:self.costPriceLab];
    [self.topBgView addSubview:self.originalPriceLab];
    [self.topBgView addSubview:self.countLab];

    //尾部
    [self.bottomView addSubview:self.remarksLab];
    
    
}
#pragma mark ************** 添加约束
- (void)addConstraintsForCarCell
{
    [_topBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.equalTo(@(100));
    }];
   
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView.bottom);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    

    //顶部
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topBgView).offset(10);
        make.centerY.equalTo(_topBgView);
        make.height.width.equalTo(@80);
    }];
    [_productNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topBgView).offset(15);
        make.height.equalTo(@15);
        make.right.equalTo(_topBgView).offset(-5);
        make.left.equalTo(_productImg.mas_right).offset(10);
    }];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productNameLab.mas_bottom).offset(6);
        make.left.equalTo(_productNameLab);
        make.height.equalTo(@15);
    }];
    
    [_originalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sizeLab.bottom).offset(6);
        make.left.equalTo(_productNameLab);
        make.height.equalTo(@15);
    }];
    
    [_costPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_originalPriceLab.bottom).offset(6);
        make.left.equalTo(_productNameLab);
        make.height.equalTo(@15);
    }];
    [_countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_costPriceLab);
        make.right.equalTo(_topBgView).offset(-10);
        make.height.equalTo(_costPriceLab);
        make.width.equalTo(@100);
    }];
    //尾部
    [_remarksLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(_bottomView);
        make.left.equalTo(_bottomView).offset(10);
        make.right.equalTo(_bottomView).offset(-10);
        
    }];
    
    
}


@end

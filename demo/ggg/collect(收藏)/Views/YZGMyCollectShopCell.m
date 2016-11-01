//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGMyCollectShopCell.h"

@interface YZGMyCollectShopCell()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  品牌图片 */
@property (nonatomic, strong) UILabel *nameLab;             /**<  品牌名称 */
@property (nonatomic, strong) UILabel *numLab;             /**<  商品数量 */
@property (nonatomic, strong) UILabel *adderss;            /**<  所在地区 */

@property (nonatomic, strong) UIView *lineView;            /**<  顶部线 */

@end
@implementation YZGMyCollectShopCell


#pragma mark ************** 懒加载控件
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
        _numLab.textColor = RGB(102,102,102);
        _numLab.font = systemFont(14);
        _numLab.text = @"商品数量: 500种";
    }
    return _numLab;
}

- (UILabel *)adderss {
    if (!_adderss) {
        _adderss = [[UILabel alloc] init];
        _adderss.textAlignment = NSTextAlignmentLeft;
        _adderss.textColor = RGB(102,102,102);
        _adderss.font = systemFont(14);
        _adderss.text = @"所在地区：浙江 金华市";
    }
    return _adderss;
}

#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGMyCollecShopModel *)model{
    _model = model;
    LampBrand *lampBrand = model.lampBrand;
    NSURL *imgUrl = [NSURL URLWithString:[lampBrand.logoPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_leftImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
    
    _nameLab.text = lampBrand.brandName;
    _numLab.text = [NSString stringWithFormat:@"商品数量: %ld种",lampBrand.goodsCount];
    _adderss.text = [NSString stringWithFormat:@"所在地区: %@",lampBrand.brandAddress];

}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    _indexPath = indexPath;
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
    [self.contentView addSubview:self.adderss];
    [self.contentView addSubview:self.lineView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForCell
{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(@(10));
        make.height.width.equalTo(@(100));
    }];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg.top).offset(10);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(20));
    }];
    
    [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLab.bottom).offset(5);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(24));
    }];
    
    [_adderss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_numLab.bottom).offset(5);
        make.left.equalTo(_leftImg.right).offset(10);
        make.right.equalTo(self.contentView).offset(-20);
        make.height.equalTo(@(24));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.left.equalTo(_nameLab);
        make.height.equalTo(@(0.5));
    }];
}

@end

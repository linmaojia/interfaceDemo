

#import "YZGProductListCollectCell.h"

@interface YZGProductListCollectCell ()
@property (nonatomic, strong) UIImageView *productImg;     /**< 品牌图片 */
@property (nonatomic, strong) UILabel *brandNameLab;     /**< 品牌名 */
@property (nonatomic, strong) UILabel *priceLab;     /**< 批发价 */
@property (nonatomic, strong) UILabel *productNumLab;    /**< 规格 */
@property (nonatomic, strong) UILabel *originPriceLab;    /**< 原价 */
@end


@implementation YZGProductListCollectCell

+ (YZGProductListCollectCell *)workNewsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    YZGProductListCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YZGProductListCollectCell alloc] init];
    }
    return cell;
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
}

- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        [_productImg setContentMode:UIViewContentModeScaleAspectFit];
        _productImg.userInteractionEnabled = YES;
        _productImg.image = [UIImage imageNamed:@"deng"];
        
    }
    return _productImg;
}

- (UILabel *)brandNameLab {
    if (!_brandNameLab) {
        _brandNameLab = [[UILabel alloc] init];
        _brandNameLab.font = [UIFont systemFontOfSize:14];
        _brandNameLab.textAlignment = NSTextAlignmentCenter;
        _brandNameLab.userInteractionEnabled = YES;
        _brandNameLab.text = @"维洛斯吊灯";
        
    }
    return _brandNameLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.font = [UIFont systemFontOfSize:12];
        _priceLab.textColor = hexColor(FF6600);
        _priceLab.textAlignment = NSTextAlignmentCenter;
        _priceLab.text = @"批发价：2522.00元";
    }
    return _priceLab;
}

- (UILabel *)originPriceLab {
    if (!_originPriceLab) {
        _originPriceLab = [[UILabel alloc] init];
        _originPriceLab.font = [UIFont systemFontOfSize:12];
        _originPriceLab.textColor = hexColor(AFAFAF);
        _originPriceLab.textAlignment = NSTextAlignmentCenter;
        _originPriceLab.text = @"零售价：2855.00元";
    }
    return _originPriceLab;
}

- (UILabel *)productNumLab {
    if (!_productNumLab) {
        _productNumLab = [[UILabel alloc] init];
        _productNumLab.font = [UIFont systemFontOfSize:14];
        _productNumLab.textAlignment = NSTextAlignmentCenter;
        _productNumLab.text = @"YY9146-8";
    }
    return _productNumLab;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}

- (void)setModel:(ProductDetail *)model{
    _model = model;
    
    NSURL *imgUrl = [NSURL URLWithString:[[model.path stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_productImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"]];
    
    _brandNameLab.text = model.brandName;
    
    _productNumLab.text = model.productNum;
    _priceLab.text = [NSString stringWithFormat:@"批发价：%.2f",model.dealerPurchasePrice];
    _originPriceLab.text = [NSString stringWithFormat:@"零售价：%.2f",model.productPrice];;
    
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.brandNameLab];
    [self.contentView addSubview:self.productImg];
    [self.contentView addSubview:self.productNumLab];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.originPriceLab];
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(140));
    }];
    [_brandNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_productImg.bottom).offset(5);
        make.height.equalTo(@(20));
    }];
    [_productNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_brandNameLab.bottom).offset(5);
        make.height.equalTo(@(20));
    }];
    [_originPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_productNumLab.bottom);
        make.height.equalTo(@(20));
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(_originPriceLab.bottom);
        make.height.equalTo(@(20));
    }];
}



@end



#import "YZGClassifyCollectionCell.h"

@interface YZGClassifyCollectionCell ()
@property (nonatomic, strong) UIImageView *productImg;     /**< 品牌图片 */
@property (nonatomic, strong) UILabel *brandNameLab;     /**< 品牌名 */

@end


@implementation YZGClassifyCollectionCell

#pragma ******************* init
- (void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
}

- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
    }
    return _productImg;
}

- (UILabel *)brandNameLab {
    if (!_brandNameLab) {
        _brandNameLab = [[UILabel alloc] init];
        _brandNameLab.font = [UIFont systemFontOfSize:12];
        _brandNameLab.textAlignment = NSTextAlignmentCenter;
        _brandNameLab.text = @"亚洲风格";
        _brandNameLab.numberOfLines = 0;
    
        
    }
    return _brandNameLab;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        
        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}

- (void)setModel:(YZGClassifylDetailModel *)model{
    _model = model;
    
    NSURL *imgUrl = [NSURL URLWithString:[[model.picUri stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [_productImg sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageLowPriority | SDWebImageRetryFailed];
    
    _brandNameLab.text = model.name;

}

#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.brandNameLab];
    [self.contentView addSubview:self.productImg];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_brandNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@35);
    }];
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(_brandNameLab.top);
    }];
 
}



@end



#import "MJShoppingCarHeaderView.h"


@interface MJShoppingCarHeaderView ()

@property (nonatomic, strong) UIView *spaceView;    /**< 空隙 */
@property (nonatomic, strong) UIView *bottomView;     /**<  底部背景 */
@property (nonatomic, strong) UIButton *selectBtn;    /**< 选择按钮 */
@property (nonatomic, strong) UIImageView *titleImg;    /**< 标题图片 */
@property (nonatomic, strong) UILabel *titleLab;    /**< 标题文字 */

@end

@implementation MJShoppingCarHeaderView
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB(241,241,241);
    }
    return _bottomView;
}
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = hexColor(FAFAFA);
        _spaceView.layer.borderColor = hexColor(EAEAEA).CGColor;
        _spaceView.layer.borderWidth = 0.5f;
    }
    return _spaceView;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(headerViewSelectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    }
    return _selectBtn;
}

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"icon_shop"];
    }
    return _titleImg;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
    }
    return _titleLab;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self addSubviewsForShoppingCarHeaderView];
        [self addConstraintsForShoppingCarHeaderView];
    }
    return self;
}
- (void)setSection:(NSInteger)section
{
    _section = section;
}

- (void)headerViewSelectButtonClicked:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarHeaderViewSelectButtonClicked:section:)])
    {
        [self.delegate shoppingCarHeaderViewSelectButtonClicked:sender.selected section:_section];
    }
}

- (void)setShopModel:(MJShoppingCarModel *)shopModel {
    _titleLab.text = shopModel.brandName;
    
    if(shopModel.select)
    {
        _selectBtn.selected = YES;
    }
    else
    {
        _selectBtn.selected  = NO;
    }
    
}

#pragma mark **************** 添加子控件
- (void)addSubviewsForShoppingCarHeaderView
{
    [self addSubview:self.spaceView];
    [self addSubview:self.bottomView];

    [self.bottomView addSubview:self.selectBtn];
    [self.bottomView addSubview:self.titleImg];
    [self.bottomView addSubview:self.titleLab];
}
#pragma mark **************** 约束
- (void)addConstraintsForShoppingCarHeaderView
{
    
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(10));
    }];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_spaceView.bottom);
        make.bottom.equalTo(self);
    }];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(35));
        make.left.equalTo(_bottomView).offset(10);
        make.centerY.equalTo(_bottomView);
    }];
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(17));
        make.left.equalTo(_selectBtn.mas_right).offset(8);
        make.centerY.equalTo(_bottomView);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleImg.mas_right).offset(8);
        make.height.equalTo(@(20));
        make.centerY.equalTo(_bottomView);
    }];
}


@end

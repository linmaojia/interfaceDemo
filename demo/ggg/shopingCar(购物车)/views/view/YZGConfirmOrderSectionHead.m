

#import "YZGConfirmOrderSectionHead.h"

@interface YZGConfirmOrderSectionHead ()
@property (nonatomic, strong) UIView *spaceView;          /**<  顶部空隙 */
@property (nonatomic, strong) UIView *lineView;            /**<  顶部线 */

@end

@implementation YZGConfirmOrderSectionHead
- (UIView *)spaceView {
    if (!_spaceView) {
        _spaceView = [[UIView alloc] init];
        _spaceView.backgroundColor = RGB(247, 247, 247);
    }
    return _spaceView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(227, 229, 230);
        
    }
    return _lineView;
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
        
        self.contentView.backgroundColor = RGB(241,241,241);
        
        [self addSubviewsForSectionHead];
        
        [self addConstraintsForSectionHead];
    }
    return self;
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForSectionHead
{
    [self addSubview:self.spaceView];
    [self addSubview:self.lineView];
    [self addSubview:self.titleImg];
    [self addSubview:self.titleLab];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForSectionHead
{
    [_spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@(5));
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self);
        make.top.equalTo(_spaceView.bottom);
        make.height.equalTo(@(0.5));
    }];
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(17));
        make.left.equalTo(self).offset(10);
        make.top.equalTo(_lineView.bottom).offset(10);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleImg.mas_right).offset(10);
        make.height.equalTo(@(20));
        make.width.equalTo(@(150));
        make.top.equalTo(_lineView.bottom).offset(10);
    }];
}

@end

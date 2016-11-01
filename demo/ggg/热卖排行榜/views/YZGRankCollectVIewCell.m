

#import "YZGRankCollectVIewCell.h"

@interface YZGRankCollectVIewCell ()
@property (nonatomic, strong) UIView *lineView;

@end


@implementation YZGRankCollectVIewCell

+ (YZGRankCollectVIewCell *)hotProductsCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    YZGRankCollectVIewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YZGRankCollectVIewCell alloc] init];
    }
    return cell;
    
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab=[[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.textColor = mainColor;
        _titleLab.text = @"吊灯";
        _titleLab.font = systemFont(14);
    }
    return _titleLab;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = mainColor;
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
     
        [self addSubviewsForCell];
        
        [self addConstraintsForCell];

    }
    return self;
}

- (void)setIsShowLine:(BOOL)isShowLine
{
    if(isShowLine)
    {
        _lineView.hidden = NO;
        _titleLab.textColor = mainColor;
    }
    else
    {
       _lineView.hidden = YES;
        _titleLab.textColor = [UIColor blackColor];
    }
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.lineView];
}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@3);
        make.right.left.bottom.equalTo(self.contentView);
    }];
}







@end

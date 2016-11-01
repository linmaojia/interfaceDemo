//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGAllBrandCell.h"
#import "YZGAllBrandCollectView.h"
@interface YZGAllBrandCell()

@property (nonatomic, strong) YZGAllBrandCollectView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectLayout;



@end
@implementation YZGAllBrandCell


#pragma mark ************** 设置cell 内容
- (UICollectionViewFlowLayout *)collectLayout
{
    if (!_collectLayout)
    {
        _collectLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectLayout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        _collectLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滑动
        _collectLayout.minimumInteritemSpacing = 10; //列与列之间的间距
        _collectLayout.minimumLineSpacing = 0;//行与行之间的间距
        _collectLayout.itemSize = CGSizeMake(100, 100);//cell的大小
    }
    return _collectLayout;
}
- (YZGAllBrandCollectView *)collectionView {
    
    if (!_collectionView) {
        ESWeakSelf;
        _collectionView = [[YZGAllBrandCollectView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectLayout];
    }
    return _collectionView;
}
- (void)setModel:(YZGBrandModel *)model{
    _model = model;
    
    _collectionView.dataArray = model.productArr;
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

    [self.contentView addSubview:self.collectionView];
 

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

}

@end

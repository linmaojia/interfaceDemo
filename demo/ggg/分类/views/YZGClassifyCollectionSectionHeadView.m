//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGClassifyCollectionSectionHeadView.h"


@interface YZGClassifyCollectionSectionHeadView()
/*本周上新图片*/
@property (nonatomic, strong) UIImageView *latestProductButton;
@property (nonatomic, strong) UILabel *titleLab;             /**<  说明 */
@property (nonatomic, strong) UIButton * rankingBtn;      /**< 排行版按钮 */

@end

@implementation YZGClassifyCollectionSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =  RGB(235, 235, 241);
        
        [self addSubviewsForView];
        
        [self addConstraintsForView];

    }
    return self;
}

#pragma mark ************** 懒加载控件
- (UIImageView *)latestProductButton
{
    if (_latestProductButton == nil)
    {
        _latestProductButton = [[UIImageView alloc] init];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(latestProductButtonAction)];
        _latestProductButton.userInteractionEnabled = YES;
        [_latestProductButton addGestureRecognizer:tapGesture];
        _latestProductButton.image = [UIImage imageNamed:@"banner"];
    }
    return _latestProductButton;
    
}
- (UIButton *)rankingBtn
{
    if(!_rankingBtn)
    {
        _rankingBtn = [[UIButton alloc]init];
        _rankingBtn.titleLabel.font = boldSystemFont(14);
        [_rankingBtn setTitle:@"排行榜" forState:0];
        [_rankingBtn setTitleColor:[UIColor blackColor] forState:0];
        [_rankingBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rankingBtn;
    
}
- (UILabel *)titleLab {
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.font = systemFont(14);
        _titleLab.text = @"xxxx";
    }
    return _titleLab;
}
- (void)setModel:(YZGClassifylSubModel *)model
{
    _titleLab.text = model.name;
    
    if(model.rankParams)
    {
        _rankingBtn.hidden = NO;
    }
    else
    {
        _rankingBtn.hidden = YES;
    }
}
#pragma mark ************** 按钮被点击
- (void)saveBtnClick:(UIButton *)sender
{
    if(self.BtnClick)
    {
        self.BtnClick();
    }
}
#pragma mark **************** 点击本周上新触发
- (void)latestProductButtonAction
{
    if (self.thisWeekNewProductOnLineAction)
    {
        self.thisWeekNewProductOnLineAction();
    }
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if(indexPath.section == 0)
    {
        _latestProductButton.hidden = NO;
        [self.latestProductButton sd_setImageWithURL:[NSURL URLWithString:[self.bannerUri stringByAppendingString:@"@!product-list"] ] placeholderImage:[UIImage imageNamed:@"logo_del_pro"] options:SDWebImageRetryFailed];
    }
    else
    {
        _latestProductButton.hidden = YES;
    }
    
    
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.latestProductButton];
    [self addSubview:self.titleLab];
    [self addSubview:self.rankingBtn];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        
    }];
    [_latestProductButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(_titleLab.top);
    }];
    [_rankingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLab);
        make.height.equalTo(_titleLab);
        make.right.equalTo(self).offset(-10);
    }];
}

@end

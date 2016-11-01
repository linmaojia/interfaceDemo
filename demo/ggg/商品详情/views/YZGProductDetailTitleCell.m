//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductDetailTitleCell.h"

@interface YZGProductDetailTitleCell()


@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *rightImg;


@end
@implementation YZGProductDetailTitleCell


#pragma mark ************** 懒加载控件
- (UILabel *)titleLab
{
    if (_titleLab == nil)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:13];
        _titleLab.text = @"";
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.textColor = [UIColor grayColor];
    }
    return _titleLab;
}
- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"taoDetailsSpecificationOnPageIcon"];
    }
    return _rightImg;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
      

        [self addSubviewsForCell];
        [self addConstraintsForCell];
    }
    return self;
}
#pragma mark ************** 设置cell 内容
- (void)setTitle:(NSString *)title
{
    _titleLab.text = title;
}
- (void)setIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 )
   {
       _rightImg.hidden = NO;
   }
   else
   {
       _rightImg.hidden = YES;
   }
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForCell
{
 
    [self.contentView addSubview:self.rightImg];
    [self.contentView addSubview:self.titleLab];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForCell
{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-40);
    }];
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.contentView);
        make.width.height.equalTo(@20);
    }];
    
}

@end

//
//  YZGMineTableOrderCell.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGClassifyTableCell.h"

@interface YZGClassifyTableCell()

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIView *lineView;            /**<  顶部线 */

@end
@implementation YZGClassifyTableCell
#pragma mark ************** 懒加载控件
- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
        _nameLab.textAlignment = NSTextAlignmentCenter;
        _nameLab.font = systemFont(16);
        _nameLab.text = @"查看详情";
        _nameLab.backgroundColor = [UIColor whiteColor];
    }
    return _nameLab;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor grayColor];
        
    }
    return _lineView;
}
#pragma mark ************** 设置cell 内容
- (void)setModel:(YZGClassifylModel *)model{
    _model = model;
    
    _nameLab.text = model.name;
    
    if(model.isSelect)
    {
       _nameLab.backgroundColor = RGB(235, 235, 241);
    }
    else
    {
        _nameLab.backgroundColor = [UIColor whiteColor];
    }
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
    [self.contentView addSubview:self.nameLab];
  
    [self.contentView addSubview:self.lineView];

}
#pragma mark **************** 约束
- (void)addConstraintsForCell
{
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
   
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(0.5));
    }];
}
@end

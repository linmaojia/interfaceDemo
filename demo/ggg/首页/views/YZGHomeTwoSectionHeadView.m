//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGHomeTwoSectionHeadView.h"

@interface YZGHomeTwoSectionHeadView()

@property (nonatomic, strong) UILabel *titleLab;
@end

@implementation YZGHomeTwoSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor grayColor];
        [self addSubviewsForView];

    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"热门风格";
        _titleLab.backgroundColor = [UIColor redColor];
    }
    return _titleLab;
}

#pragma mark ************** 按钮被点击

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.titleLab];
    
    [_titleLab makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self);
    }];

}


@end

//
//  RefundCloseHeadView.m
//  ggg
//
//  Created by LXY on 16/8/26.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "RefundCloseSectionView.h"

@interface RefundCloseSectionView()

@end

@implementation RefundCloseSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGB(247, 247, 247);
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = RGB(221, 221, 221).CGColor;
    
        UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0,10, 4, 40)];
        line.backgroundColor = RGB(38, 66, 136);
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(4, 10, self.frame.size.width - 3, 40)];
        titleLabel.text = @"  协商详情";
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = systemFont(14);
        titleLabel.layer.borderWidth = 0.5;
        titleLabel.layer.borderColor = RGB(221, 221, 221).CGColor;
        
        
        [self addSubview:line];
        [self addSubview:titleLabel];

    }
    return self;
}


@end

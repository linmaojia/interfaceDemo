//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRankingListLabView.h"

@interface YZGRankingListLabView()<UIScrollViewDelegate>
{
    
    CGFloat self_width,self_height,btnBgView_H;//按钮背景高度
}
@property (nonatomic, strong) UIView *btnBgView;   /**< 按钮背景 */
@property (nonatomic, strong) UIButton *tempBtn;

@end

@implementation YZGRankingListLabView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       
        self_width = self.frame.size.width;
        
        self_height = self.frame.size.height;

        [self addSubviewsForView];
        
        [self addConstraintsForView];
        
       

    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UIView *)btnBgView
{
    if (!_btnBgView) {
        _btnBgView = [[UIView alloc] init];
        _btnBgView.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1];
       
    }
    return _btnBgView;
}


- (void)setButtonArray:(NSArray *)buttonArray
{
    _buttonArray = buttonArray;

    [self creatButton];
    
    [self show];
}

#pragma mark ************** 创建按钮
- (void)creatButton
{
    //第一个 label的起点
    CGSize size = CGSizeMake(10, 40);
    
    //间距
    CGFloat padding = 10.0;
    
    CGFloat button_height = 20;
    
    CGFloat width = self_width;
    
  
    for (int i = 0; i < _buttonArray.count; i ++) {
        
        CGFloat keyWorldWidth = [self getSizeByString:_buttonArray[i] AndFontSize:14].width;
        if (keyWorldWidth > width) {
            keyWorldWidth = width;
        }
        if (width - size.width < keyWorldWidth) {
            size.height += button_height + padding;
            size.width = 10.0;
        }
        //创建 label点击事件
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(size.width, size.height-30, keyWorldWidth, button_height)];
        button.titleLabel.numberOfLines = 0;
        button.backgroundColor = [UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        button.layer.cornerRadius = 8.0;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:_buttonArray[i] forState:UIControlStateNormal];
        [_btnBgView addSubview:button];
        button.tag = 100 + i;
        [button addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //起点 增加
        size.width += keyWorldWidth+padding;
        
        //改变颜色
        if(i == self.index)
        {
            self.tempBtn = button;
            self.tempBtn.selected = YES;
           
        }
    }
    btnBgView_H = size.height;
    
    
    
    
    NSLog(@"--xx-%lf",size.height);
    
}
- (void)tagButtonClick:(UIButton *)sender
{
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = YES;
    self.tempBtn = sender;
    
    //回调
    if(self.tagButtonClick)
    {
        self.tagButtonClick(sender.tag - 100);
    }
    
    [self dismiss];
    
}

#pragma mark ************** 计算文字所占大小
- (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 20;
    return size;
}
#pragma mark ************** 消失
- (void)dismiss {
    [UIView animateWithDuration:0.4f  animations:^{
        
        [self setBackgroundColor:RGBA(0, 0, 0, 0)];
        
        _btnBgView.frame = CGRectMake(0, -btnBgView_H, self_width, 150);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        

    }];
    
    if(self.showTagButton)
    {
        self.showTagButton();
    }
    
}
#pragma mark ************** 显示
- (void)show
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
       self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
       _btnBgView.frame = CGRectMake(0, 0, self_width, btnBgView_H);
        
        
    } completion:nil];
    
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    self.backgroundColor = [UIColor grayColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
    
    
   [self addSubview:self.btnBgView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
     _btnBgView.frame = CGRectMake(0, -150, self_width, 150);
    

}

@end

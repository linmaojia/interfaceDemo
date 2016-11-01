//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRankingListTopView.h"
#import "YZGRankCollectVIewCell.h"

@interface YZGRankingListTopView()<UIScrollViewDelegate>
{
    CGFloat button_width,button_height;
    CGFloat self_width,self_height;
}
@property (nonatomic, strong) UIButton *tempBtn;
@property (nonatomic, strong) UIScrollView *scroll;    /**< Scrollow视图 */
@property (nonatomic, strong) UIView *lineView;      /**< 顶部横线 */
@property (nonatomic, strong) UIImageView *Img;         /**<  图片 */
@property (nonatomic, assign) BOOL isShowMoreView;
@property (nonatomic, strong) UIView *blackView; /**<  灰色背景 */
@property (nonatomic, strong) UIView *bottomView;      /**< 白色背景 */
@property (nonatomic, strong) UILabel *titleLab;             /**<  标签标题 */

@end

@implementation YZGRankingListTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =  RGB(247, 247, 247);
        
        self_width = self.frame.size.width;
        
        self_height = self.frame.size.height;
        
        button_height = self.frame.size.height;

        button_width = 80;
        
        [self addSubviewsForView];
        
        [self addConstraintsForView];

    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"    为你精选以下标签";
        _titleLab.backgroundColor = [UIColor whiteColor];
        _titleLab.hidden = YES;
    }
    return _titleLab;
}
- (UIImageView *)Img {
    if (!_Img) {
        _Img = [[UIImageView alloc] init];
        _Img.image = [UIImage imageNamed:@"icon_jian"];
        _Img.backgroundColor = [UIColor clearColor];
        _Img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImgClick:)];
        [_Img addGestureRecognizer:tap];
    }
    return _Img;
}
- (UIScrollView *)scroll{
    
    if(!_scroll){
        _scroll=[[UIScrollView alloc] init];
        _scroll.contentSize=CGSizeMake(self_width, self_height);
        _scroll.scrollEnabled=YES;
        _scroll.directionalLockEnabled=YES;//指定控件只能在一个方向滚动
        _scroll.backgroundColor = RGB(247, 247, 247);
    }
    return _scroll;
}
#pragma mark ************** 图片点击
-(void)ImgClick:(UITapGestureRecognizer *)sender
{

    self.isShowMoreView = !self.isShowMoreView;
    self.titleLab.hidden = !self.titleLab.hidden;
    if(self.isShowTagButton)
    {
        self.isShowTagButton(self.isShowMoreView);
    }
    
    [self showImgAnimations];
  
 
}
- (void)showImgAnimations
{
    [UIView animateWithDuration:0.3f animations:^{
        self.Img.transform = CGAffineTransformRotate(self.Img.transform,M_PI);
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}
- (void)showTopButton
{
   self.isShowMoreView = NO;
    
   self.titleLab.hidden = YES;
    
  [self showImgAnimations];
}
- (void)setIndex:(NSInteger)index
{
    UIButton *selectBtn = (UIButton *)[self viewWithTag: index + 100];
    
    [self optionButtonClick:selectBtn];
}
#pragma mark ************** 消失


- (void)setButtonArray:(NSArray *)buttonArray
{
    _buttonArray = buttonArray;
    
    _scroll.contentSize=CGSizeMake(button_width * _buttonArray.count, button_height);
    
    for (int i = 0; i < buttonArray.count; i++)
    {
        
        UIButton *button = [[UIButton alloc]init];
        button.titleLabel.font = systemFont(15);
        button.frame = CGRectMake(i*button_width, 0, button_width, button_height);
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:buttonArray[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button setTitleColor:mainColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(optionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [_scroll addSubview:button];
        
    }
    
    UIButton *selectBtn = (UIButton *)[self viewWithTag:100];
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, button_width, 2)];
    self.lineView.center = CGPointMake(selectBtn.center.x, button_height - 1);
    self.lineView.backgroundColor = mainColor;
    [_scroll addSubview:self.lineView];

}
#pragma mark ************** downView上的button点击事件
- (void)optionButtonClick:(UIButton *)sender
{
    self.tempBtn.selected = !self.tempBtn.selected;
    sender.selected = YES;
    self.tempBtn = sender;
    
    CGFloat sWidth = _scroll.frame.size.width;
    
    
    [UIView animateWithDuration:0.15 animations:^{
        
        self.lineView.center = CGPointMake(sender.center.x, self.lineView.center.y);

       
        
    } completion:^(BOOL finished) {
        
        CGFloat offectX;
        
        
        if(sender.center.x > sWidth/2) //滚动到一半就偏移
        {

          if(sender.center.x >= self.scroll.contentSize.width - sWidth/2)//尾部判断
          {
              offectX = self.scroll.contentSize.width - sWidth;
              
             [self.scroll setContentOffset:CGPointMake(offectX,0) animated:YES];
          }
          else
          {
              offectX = sender.center.x - 2*button_width;//中部判断
              
              [self.scroll setContentOffset:CGPointMake(offectX,0) animated:YES];
          }
           
   
        }
        else
        {
            [self.scroll setContentOffset:CGPointMake(0,0) animated:YES];//头部判断
        }
       
         //block回调
        if(self.topButtonClick)
        {
            self.topButtonClick(sender.tag - 100);
        }
        
    }];
}

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.scroll];
    
    [self addSubview:self.Img];
    
    [self addSubview:self.titleLab];

    

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
    _scroll.frame = CGRectMake(0, 0, self_width - 40, self_height);
    
    _Img.frame = CGRectMake(0, 0, 30, 30);
    
    self.Img.center = CGPointMake(self_width - 20, self.center.y);

    _titleLab.frame = _scroll.frame;

}

@end

//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGScrollerView.h"
#import "YZGImgWithTitltView.h"
#import "YZGOrderButtonView.h"
@interface YZGScrollerView()<UIScrollViewDelegate>
{
    CGFloat self_width,self_height;
    CGFloat scroller_W,scroller_H;
    CGFloat title_W,title_H;
}
@property (nonatomic, strong) UIScrollView *scroll;    /**< Scrollow视图 */
@property (nonatomic, strong) YZGOrderButtonView *titleView;

@end

@implementation YZGScrollerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor =  [UIColor whiteColor];
        
       
        self_width = self.frame.size.width;
        
        self_height = self.frame.size.height;
        
        title_W = self_width;
        
        title_H = 40;

        scroller_W = self_width;
        
        scroller_H = self_height - title_H;


        [self addSubviewsForView];
        

    }
    return self;
}

- (YZGOrderButtonView *)titleView {
    if (!_titleView) {
        ESWeakSelf;
        CGRect frame  = CGRectMake(0, 0, title_W, title_H);
        _titleView = [[YZGOrderButtonView alloc] initWithFrame:frame];
        _titleView.buttonArray = @[@"最热", @"类型",@"空间", @"风格"];
        _titleView.index = 0;
         _titleView.isHideLineView = YES;
        _titleView.backgroundColor = RGB(241, 241, 241);
        _titleView.orderButtonClick = ^(NSInteger index)
        {
            NSLog(@"xxx---%ld",index);
            [__weakSelf.scroll setContentOffset:CGPointMake(index * scroller_W,0) animated:YES];
        };
        
    }
    return _titleView;
}
#pragma mark ************** 懒加载控件
- (UIScrollView *)scroll{
    
    if(!_scroll){
        _scroll=[[UIScrollView alloc] init];
        _scroll.frame = CGRectMake(0, title_H, scroller_W, scroller_H);
        _scroll.contentSize=CGSizeMake(4*scroller_W, scroller_H);
        _scroll.backgroundColor = RGB(247, 247, 247);
        _scroll.showsHorizontalScrollIndicator=YES;
        _scroll.pagingEnabled=YES;
        _scroll.backgroundColor = [UIColor grayColor];
        _scroll.delegate = self;
    }
    return _scroll;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    [self creatView];
}
- (void)creatView
{
    ESWeakSelf;
    for(int j = 0; j < 4; j++)
    {
        CGRect frame = CGRectMake(j * scroller_W, 0, scroller_W, scroller_H);
        YZGImgWithTitltView *view = [[YZGImgWithTitltView alloc]initWithFrame:frame];
        view.viewWithTagBlack = ^(NSInteger tag){
            [__weakSelf viewClickWithSection:j Tag:tag];
        };
        view.dataArray = _titleArray[j];
        view.backgroundColor = [UIColor whiteColor];
        view.tag = 100 + j;
        [_scroll addSubview:view];
        
    }

}
#pragma ******************* 偏移量
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
   
    _titleView.index = offset/scroller_W;
    
    NSLog(@"--%lf---%lf",offset,offset/scroller_W);
  
}
#pragma mark ************** 按钮被点击
-(void)viewClickWithSection:(NSInteger)section Tag:(NSInteger)tag
{
    NSLog(@"--%ld---%ld",section,tag);
 
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.scroll];
    [self addSubview:self.titleView];

}


@end

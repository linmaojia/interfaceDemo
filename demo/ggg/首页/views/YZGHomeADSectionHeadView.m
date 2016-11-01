//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGHomeADSectionHeadView.h"
#import "HYBLoopScrollView.h"

@interface YZGHomeADSectionHeadView()

/**< 广告轮播图 */
@property (nonatomic, weak) HYBLoopScrollView *loop;
/*url 数组*/
@property (nonatomic, strong) NSMutableArray *urlArray;
@end

@implementation YZGHomeADSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor grayColor];

    }
    return self;
}

#pragma mark ************** 懒加载控件
- (HYBLoopScrollView *)loop
{
    
    if(!_loop)
    {
        
        _loop = [HYBLoopScrollView loopScrollViewWithFrame:CGRectZero imageUrls:_urlArray timeInterval:5 didSelect:^(NSInteger atIndex) {
            
            NSLog(@"---%ld",atIndex);
            
        } didScroll:^(NSInteger toIndex) {
            
            NSLog(@"--xxxx-%ld",toIndex);//切换页面时调用
        }];
        
        _loop.placeholder = [UIImage imageNamed:@"logo_del_pro"];
        
        _loop.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"logo_del_pro"]];
        
        _loop.alignment = kPageControlAlignCenter;
        
        _loop.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        
        _loop.imageContentMode = UIViewContentModeScaleAspectFill;
        
        
        
    }
    return _loop;
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    if(dataArray)
    {
        //筛选
        _urlArray = [NSMutableArray array];
        for(int i = 0;i<dataArray.count;i++)
        {
            [_urlArray addObject:dataArray[i][@"picUri"]];
        }
        
        [self addSubviewsForView];
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

#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.loop];
    
    [_loop makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

}


@end

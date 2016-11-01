//
//  YZGAlertView.m
//  Masonry
//
//  Created by LXY on 16/6/14.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGBottomAlertView.h"
static float const BTN_HEIGHT = 40;
@interface YZGBottomAlertView()
@property (nonatomic, strong) UIView *alertView;


@end

@implementation YZGBottomAlertView

- (UIView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[UIView alloc] init];
        _alertView.backgroundColor = [UIColor whiteColor];
    }
    return _alertView;
}

- (instancetype)initWithTitle:(NSArray *)titleArray{
    if (self = [super init]) {
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5;
        self.frame = keyWindow.frame;
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCancelBtn)];
        [self addGestureRecognizer:tap];//添加手势
        [keyWindow addSubview:self];
        
        //alertView
        self.alertView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, titleArray.count*BTN_HEIGHT);
        [keyWindow addSubview:self.alertView];
        [self creatBtn:titleArray];
        
        
    }
     return self;
}
#pragma mark **************** 添加子控件
- (void)creatBtn:(NSArray *)titleArray{
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];// 所有按钮
        [btn setTag:i];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [[btn titleLabel] setFont:[UIFont systemFontOfSize:14.0f]];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setFrame:CGRectMake(0, i*BTN_HEIGHT, SCREEN_WIDTH, BTN_HEIGHT)];
        [_alertView addSubview:btn];
        
         //线条
        UIView *linLab = [[UIView alloc]initWithFrame:CGRectMake(0, (BTN_HEIGHT+1) *i, SCREEN_WIDTH, 0.5)];
        linLab.backgroundColor = RGB(227, 229, 230);
        [_alertView addSubview:linLab];
        
        }
    
        [self show];
        
}
#pragma mark ************** 按钮被点击
- (void)didClickBtn:(UIButton *)sender{
     self.alertTitleBlock(sender.titleLabel.text);
     [self  dismiss];
}
#pragma mark **************** 出现
- (void)show {
    [UIView animateWithDuration:0.3f animations:^{
        
        CGRect frame = _alertView.frame;
        frame.origin.y -= frame.size.height;
        _alertView.frame = frame;
    } completion:nil];
}


- (void)dismiss
{
    
    [UIView animateWithDuration:0.3f  animations:^{
        [self setBackgroundColor:RGBA(0, 0, 0, 0)];
        
        CGRect frame = _alertView.frame;
        frame.origin.y += frame.size.height;
        _alertView.frame = frame;
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        [self.alertView removeFromSuperview];
    }];
    
}
//消失
- (void)didClickCancelBtn {
    [self dismiss];
}
@end

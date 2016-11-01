//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGShopViewController.h"

@interface YZGShopViewController ()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */


@end

@implementation YZGShopViewController

#pragma mark ************** 懒加载控件
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"account_highlight"];
        [_leftImg setContentMode:UIViewContentModeScaleAspectFit];
        
    }
    return _leftImg;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    

}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    self.view.backgroundColor = RGB(235, 235, 241);
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self.view addSubview:self.leftImg];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(@(10));
        make.height.width.equalTo(@(80));
    }];
}
@end

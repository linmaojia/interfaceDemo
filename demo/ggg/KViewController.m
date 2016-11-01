//
//  KViewController.m
//  ggg
//
//  Created by longma on 16/9/20.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "KViewController.h"
#import "MJShoppingCarVC.h"
#import "YZGOrderButtonView.h"
#import "YZGShoppingCarView.h"
#import "YZGProductListTopView.h"
#import "YZGScrollerView.h"
#import "NSString+Extend.h"
#import "SDPhotoBrowser.h"
@interface KViewController ()<SDPhotoBrowserDelegate>

@property (nonatomic, strong) YZGOrderButtonView *orderButtonView;
@property (nonatomic, strong) YZGOrderButtonView *titleView;
@property (nonatomic, strong) YZGShoppingCarView *carView;
@property (nonatomic, strong) YZGProductListTopView *topView;

@property (nonatomic, assign) NSInteger indexTag;
@property (nonatomic, strong) YZGScrollerView *scrollerView;
@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */
@property (nonatomic, strong) UIImageView *titleImg;         /**<  图片 */

@end

@implementation KViewController

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"c_1"];
        _titleImg.backgroundColor = [UIColor grayColor];
        _titleImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [_titleImg addGestureRecognizer:tap];
        
    }
    return _titleImg;
}


- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(20);
        _titleLab.text = @"查看详情";
        _titleLab.backgroundColor = [UIColor redColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}
- (YZGProductListTopView *)topView
{
    if (!_topView)
    {
        _topView = [[YZGProductListTopView alloc]init];
    }
    return _topView;
}
- (YZGShoppingCarView *)carView {
    if (!_carView) {
        ESWeakSelf;
        _carView = [[YZGShoppingCarView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 60, self.view.frame.size.height - 150, 40, 40)];
        _carView.carButtonClick = ^(){
            [__weakSelf xxx];
           
        };
    }
    return _carView;
}
- (YZGOrderButtonView *)titleView {
    if (!_titleView) {
        _titleView = [[YZGOrderButtonView alloc] initWithFrame:CGRectMake(0, 0, 54*2, 44)];
        _titleView.buttonArray = @[@"商品", @"店铺"];
        _titleView.index = 0;
        _titleView.orderButtonClick = ^(NSInteger index)
        {
            NSLog(@"xxx---%ld",index);
        };
        
    }
    return _titleView;
}
- (YZGOrderButtonView *)orderButtonView {
    if (!_orderButtonView) {
        _orderButtonView = [[YZGOrderButtonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _orderButtonView.backgroundColor = RGB(245, 247, 249);
        _orderButtonView.buttonArray = @[@"全部", @"待付款", @"待发货", @"待收货", @"已完成", @"已取消"];
        _orderButtonView.index = self.index;
        _orderButtonView.orderButtonClick = ^(NSInteger index)
        {
            NSLog(@"xxx---%ld",index);
        };
        
    }
    return _orderButtonView;
}
- (void)xxx
{
     self.carView.count = 23;
}

#pragma mark ************** 系统方法
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.orderButtonView];
   
    self.navigationItem.titleView =self.titleView;
  
    
    [self.view addSubview:self.carView];
    
    NSLog(@"%@",NSStringFromCGRect(self.carView.frame));
     NSLog(@"%@",NSStringFromCGRect(self.view.frame));

    [self.view addSubview:self.topView];

        [_topView makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(_orderButtonView.bottom).offset(20);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(40));
        }];
    
//////////////////////
    
    
    [self.view addSubview:self.titleImg];
    [_titleImg makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_topView.bottom).offset(20);
        make.left.equalTo(@30);
        make.height.width.equalTo(@(80));
    }];
    
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self.view; // 原图的父控件
    browser.imageCount = 1; // 图片总数
    browser.currentImageIndex = 0;
    browser.delegate = self;
    [browser show];

    
}
#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
}
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"logo_del_pro"];
}


//// 返回高质量图片的url
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    
//    return [NSURL URLWithString:self.selectArray[index]];
//}
@end

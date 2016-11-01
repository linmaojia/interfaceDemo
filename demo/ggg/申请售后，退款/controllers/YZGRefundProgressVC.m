//
//  YZGRefundProgressVC.m
//  yzg
//
//  Created by LXY on 16/8/25.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRefundProgressVC.h"
//#import "YZGShopInformationViewController.h"
#import "YZGMyServiceController.h"

@interface YZGRefundProgressVC ()
@property (nonatomic, strong) UIImageView *imageView;    /**< 图片 */
@property (nonatomic, strong) UIView *bottomView;            /**<  view */
@property (nonatomic, strong) UIButton *serviceBtn;             /**<  申请客服介入 */
@property (nonatomic, strong) UIButton *brandBtn;             /**<  联系卖家 */
@end

@implementation YZGRefundProgressVC
- (UIButton *)brandBtn {
    if (!_brandBtn) {
        _brandBtn=[[UIButton alloc]init];
        [_brandBtn setTitle:@"联系卖家" forState:UIControlStateNormal];
        [_brandBtn setTitleColor:mainColor forState:UIControlStateNormal];
        _brandBtn.titleLabel.font = systemFont(14);//标题文字大小
        _brandBtn.layer.borderWidth = 0.5;
        _brandBtn.layer.borderColor = mainColor.CGColor;
        _brandBtn.layer.cornerRadius = 3;
        _brandBtn.layer.masksToBounds = YES;
        [_brandBtn addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _brandBtn;
}
- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn=[[UIButton alloc]init];
        [_serviceBtn setTitle:@"申请客服介入" forState:UIControlStateNormal];
        [_serviceBtn setTitleColor:mainColor forState:UIControlStateNormal];
        _serviceBtn.titleLabel.font = systemFont(14);//标题文字大小
        _serviceBtn.layer.borderWidth = 0.5;
        _serviceBtn.layer.borderColor = mainColor.CGColor;
        _serviceBtn.layer.cornerRadius = 3;
        _serviceBtn.layer.masksToBounds = YES;
        [_serviceBtn addTarget:self action:@selector(serviceClick:) forControlEvents:UIControlEventTouchDown];
        
    }
    return _serviceBtn;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = RGB(239, 239, 239);
        
    }
    return _bottomView;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"explains"];
    }
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];//设置导航栏
    [self addSubviewsForVC];
    
}
- (void)brandClick:(UIButton *)sender{
    
//    YZGShopInformationViewController *shopInfomationVC = [[YZGShopInformationViewController alloc] init];
//    shopInfomationVC.brandCode = self.brandID;
//    shopInfomationVC.jumpToServicePage = YES;
//    [self.navigationController pushViewController:shopInfomationVC animated:YES];
}
- (void)serviceClick:(UIButton *)sender{
    
    YZGMyServiceController *VC = [[YZGMyServiceController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 自定义方法
- (void)setNav{
    self.title = @"退款处理";
    self.view.backgroundColor = RGB(247, 247, 247);
    
    
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
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addSubviewsForVC
{
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.bottomView];

    [self.bottomView addSubview:self.brandBtn];

    [self.bottomView addSubview:self.serviceBtn];

    UIImage *img = [UIImage imageNamed:@"explains"];

    CGFloat height = (SCREEN_WIDTH * img.size.height)/img.size.width;
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.equalTo(@60);

    }];
    [_brandBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@80);
        make.centerY.equalTo(_bottomView);
        make.centerX.equalTo(_bottomView).offset(-45);
        
    }];
    
    [_serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@90);
        make.centerY.equalTo(_bottomView);
        make.left.equalTo(_brandBtn.right).offset(10);
        
    }];
}

@end

//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGHomeViewVC.h"
#import "YZGHomeCollectView.h"
#import "YZGClassifyCollectionView.h"
#import "YZGHomeModel.h"
#import "YZGHomeManager.h"
@interface YZGHomeViewVC ()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) YZGHomeCollectView *collectionView;
@property (nonatomic, strong) YZGHomeManager *manager;
@property (nonatomic, strong) YZGHomeModel *model;


@end

@implementation YZGHomeViewVC

#pragma mark ************** 懒加载控件
- (YZGHomeCollectView *)collectionView {
    
    if (!_collectionView) {
        ESWeakSelf;
       UICollectionViewFlowLayout *collectLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[YZGHomeCollectView alloc] initWithFrame:CGRectZero collectionViewLayout:collectLayout];
        
    }
    return _collectionView;
}
- (YZGHomeManager *)manager {
    if (!_manager) {
        _manager = [[YZGHomeManager alloc]init];
    }
    return _manager;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];

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

#pragma mark ************** 获取数据
- (void)getData
{
    ESWeakSelf;
    [self.manager getHomeModelWithTarget:self CallBack:^(YZGHomeModel *model) {
        __weakSelf.model = model;
    }];
  
}
- (void)setModel:(YZGHomeModel *)model
{
    _model = model;
    
    _collectionView.model = model;
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self.view addSubview:self.collectionView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end

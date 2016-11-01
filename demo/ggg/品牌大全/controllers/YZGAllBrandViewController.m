//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGAllBrandViewController.h"
#import "YZGAllBrandManager.h"
#import "YZGAllBrandModel.h"
#import "YZGAllBrandTableView.h"
@interface YZGAllBrandViewController ()

@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) YZGAllBrandManager *manager;
@property (nonatomic, strong) YZGAllBrandModel *model;
@property (nonatomic, strong) YZGAllBrandTableView *tableView;

@end

@implementation YZGAllBrandViewController

#pragma mark ************** 懒加载控件
- (YZGAllBrandTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGAllBrandTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}
- (YZGAllBrandManager *)manager {
    if (!_manager) {
        _manager = [[YZGAllBrandManager alloc]init];
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
- (void)setModel:(YZGAllBrandModel *)model
{
    _model = model;
    
    self.tableView.dataArray = model.data;
}
#pragma mark ************** 获取数据
- (void)getData
{
    ESWeakSelf;
    NSMutableDictionary *mdict = [NSMutableDictionary dictionary];
    [mdict setObject:@"10" forKey:@"rowsPerPage"];
    [mdict setObject:@(1) forKey:@"pageNumber"];
    
    [self.manager getAllBrandWithDic:mdict Target:self CallBack:^(YZGAllBrandModel *model) {
        __weakSelf.model = model;
    }];
   
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.tableView];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
@end

//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGWeiBoController.h"
#import "YZGWeiBoTableView.h"
#import "YZGWeiBoManager.h"

@interface YZGWeiBoController ()

@property (nonatomic, strong) YZGWeiBoTableView *tableView;
@property (nonatomic, strong) YZGWeiBoManager *manager;
@property (nonatomic, strong) NSMutableArray *dataArray; /**< 数据 */
@end

@implementation YZGWeiBoController

#pragma mark ************** 懒加载控件
- (YZGWeiBoManager *)manager {
    if (!_manager) {
        _manager = [[YZGWeiBoManager alloc]init];
    }
    return _manager;
}
- (YZGWeiBoTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGWeiBoTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.cellClickBlack = ^(NSString *productId){
            
            
        };
    }
    return _tableView;
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
    self.dataArray = [self.manager getDataArray];
    
    _tableView.dataArray = self.dataArray;
    NSLog(@"---%@",self.dataArray);
    
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

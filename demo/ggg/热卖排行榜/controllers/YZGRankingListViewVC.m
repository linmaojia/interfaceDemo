//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRankingListViewVC.h"
#import "YZGRankingListTopView.h"
#import "YZGRankingListLabView.h"
#import "YZGRankingListTableView.h"
#import "YZGRankingListManager.h"
#import "YZGClassifylModel.h"
@interface YZGRankingListViewVC ()
{
    YZGRankingListLabView *centerView;
    NSMutableArray *hotArrayName; /*排行榜名称数组*/
    NSMutableDictionary *indexDic; /*选择标签*/
}

@property (nonatomic, strong) YZGRankingListTopView *topView;
@property (nonatomic, strong) YZGRankingListTableView *tableView;
@property (nonatomic, strong) YZGRankingListManager *manager;
@property (nonatomic, strong) NSMutableDictionary *arrayDic; /*字典数组*/
@property (nonatomic, assign) NSInteger index;

@end

@implementation YZGRankingListViewVC

- (NSMutableDictionary *)arrayDic
{
    if (!_arrayDic)
    {
        _arrayDic = [NSMutableDictionary dictionary];
    }
    return _arrayDic;
}
- (YZGRankingListTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGRankingListTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}


#pragma mark ************** 懒加载控件
- (YZGRankingListTopView *)topView {
    if (!_topView) {
        ESWeakSelf;
        _topView = [[YZGRankingListTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _topView.buttonArray = hotArrayName;
        _topView.topButtonClick = ^(NSInteger index)
        {
            __weakSelf.index = index;
            
            YZGClassifylDetailModel *model = __weakSelf.hotArray[index];
            
            [__weakSelf screenWithDic:model.rankParams];
          
            [__weakSelf getData];
            
        };
        _topView.isShowTagButton = ^(BOOL flag){
            [__weakSelf isShowTagButtonAction:flag];
        };
        
    }
    return _topView;
}
#pragma mark ************** 是否显示标签按钮
- (void)isShowTagButtonAction:(BOOL)flag
{
    if(flag == YES)
    {
        ESWeakSelf;
        CGFloat point_x = _topView.frame.origin.y + _topView.frame.size.height;
        CGFloat height = SCREEN_HEIGHT - _topView.frame.size.height - 64;
        centerView = [[YZGRankingListLabView alloc] initWithFrame:CGRectMake(0, point_x, SCREEN_WIDTH, height)];
        centerView.index = _index;
        centerView.buttonArray =  hotArrayName;
        centerView.tagButtonClick = ^(NSInteger index)
        {
            __weakSelf.index = index;
            
            __weakSelf.topView.index = index;
        };
        centerView.showTagButton = ^(){
            
            [__weakSelf.topView showTopButton];
        };
        
        [self.view insertSubview:centerView atIndex:1];
        
    }
    else
    {
        [centerView dismiss];
    }
}
- (YZGRankingListManager *)manager {
    if (!_manager) {
        _manager = [[YZGRankingListManager alloc]init];
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
- (void)setHotArray:(NSArray *)hotArray
{
    _hotArray = hotArray;
    
    _index = 0;
    
    //获取数组名称
    hotArrayName = [NSMutableArray array];
    for(int i = 0;i<hotArray.count;i++)
    {
        YZGClassifylDetailModel *model = hotArray[i];
        [hotArrayName addObject:model.name];
    }
    
    YZGClassifylDetailModel *model = hotArray[0];
    
    
   [self screenWithDic:model.rankParams];//筛选字典
    
  
    
}

- (void)screenWithDic:(NSDictionary *)dic
{
    indexDic = [NSMutableDictionary dictionary];
    if([dic[@"rank"] isEqualToString:@"type"])
    {
        [indexDic setValue:dic[@"id"] forKey:@"value"];
        [indexDic setValue:dic[@"rank"] forKey:@"rank"];
        [indexDic setValue:@"typeId" forKey:@"key"];

    }
    else
    {
        [indexDic setValue:dic[@"name"] forKey:@"value"];
        [indexDic setValue:dic[@"rank"] forKey:@"rank"];
        [indexDic setValue:@"name" forKey:@"key"];
    }
}
- (void)getData
{
  
    ESWeakSelf;
   NSDictionary *params = @{indexDic[@"key"]:indexDic[@"value"],@"rank":indexDic[@"rank"]};
    
  
    BOOL isExistArray = NO;
    for (NSString *key in self.arrayDic)
    {
        if ([key isEqualToString:indexDic[@"value"]])
        {
            isExistArray = YES;
        }
    }
    
    if(isExistArray)//存在
    {
        self.tableView.dataArray = self.arrayDic[indexDic[@"value"]];
        
        [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    }
    else
    {
        [self.manager getRankingListWithDic:params target:self CallBack:^(NSArray *array) {
            
            __weakSelf.tableView.dataArray = array;
            
            [__weakSelf.tableView setContentOffset:CGPointMake(0,0) animated:NO];
            
            [__weakSelf.arrayDic setObject:array forKey:indexDic[@"value"]];
            
        }];
    }
    
 
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    self.view.backgroundColor = [UIColor whiteColor];
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
 
   [self.view addSubview:self.tableView];
   [self.view addSubview:self.topView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
}
@end

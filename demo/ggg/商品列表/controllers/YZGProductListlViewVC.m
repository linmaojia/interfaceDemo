//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGProductListlViewVC.h"
#import "YZGProductListTableView.h"
#import "YZGProductListTopView.h"
#import "YZGProductListManager.h"
#import "YZGProductListCollectView.h"
#import "YZGProductDetailViewVC.h"
#import "JKTextField.h"
#import "YZGSearchController.h"
@interface YZGProductListlViewVC ()<UITextFieldDelegate>
{
    BOOL isDecs; //是否是升降序查询
    NSString *decsString;  //asc/desc 两种
}
@property (nonatomic, strong) UIImageView *leftImg;         /**<  产品图片 */
@property (nonatomic, strong) YZGProductListTopView *topView;
@property (nonatomic, strong) YZGProductListManager *manager;
@property (nonatomic, strong) NSMutableArray *tableDataArray;        /**< 横排数组 */
@property (nonatomic, strong) NSMutableArray *collectDataArray;      /**< 竖排数组 */
@property (nonatomic, assign) NSInteger tablelPageNum;
@property (nonatomic, assign) NSInteger collectionPageNum;
/*tableView*/
@property (nonatomic, strong) YZGProductListTableView *tableView;
/*模式切换按钮*/
@property (nonatomic, strong) UIButton *changeViewButton;
/*collectView*/
@property (nonatomic, strong) YZGProductListCollectView *collectionView;
/*视图容器*/
@property (nonatomic, strong) UIView *currentView;
/*搜索栏*/
@property (nonatomic, strong) JKTextField *navSearchBar;

@end

@implementation YZGProductListlViewVC

#pragma mark ************** 懒加载控件
- (JKTextField *)navSearchBar
{
    if (!_navSearchBar)
    {
        _navSearchBar = [[JKTextField alloc] init];
        _navSearchBar.delegate = self;
        _navSearchBar.frame = CGRectMake(0, 0, AUTO_MATE_WIDTH(280), 30);
        _navSearchBar.backgroundColor = [UIColor whiteColor];
        _navSearchBar.placeholder = @"搜索易掌管商品/品牌";
        _navSearchBar.font = [UIFont systemFontOfSize:14];
        _navSearchBar.leftViewPadding = 5;
        _navSearchBar.centerViewPadding = 8;
        _navSearchBar.layer.cornerRadius = 4;
        _navSearchBar.backgroundColor = [UIColor colorWithHexColorString:@"EAEAEA"];
        UIImageView *searchImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
        searchImage.image = [UIImage imageNamed:@"nav_-search"];
        
        _navSearchBar.leftView = searchImage;
        _navSearchBar.leftViewMode = UITextFieldViewModeAlways;
    }
    return _navSearchBar;
    
}
- (YZGProductListTopView *)topView
{
    if (!_topView)
    {
        ESWeakSelf;
        _topView = [[YZGProductListTopView alloc]init];
        _topView.defaultBtnClick = ^(){
            [__weakSelf defaultBtnClickAction];
        };
        _topView.priceBtnClick = ^(BOOL desc){
            [__weakSelf priceBtnClickAction:desc];
        };
        _topView.filterBtnClick = ^(){
            [__weakSelf filterBtnClickAction];
        };

    }
    return _topView;
}

- (UIView *)currentView {
    if (!_currentView) {
        _currentView = [[UIView alloc] init];
    }
    return _currentView;
}
- (YZGProductListCollectView *)collectionView {
    
    if (!_collectionView) {
        ESWeakSelf;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
        layout.minimumInteritemSpacing = 10; //列与列之间的间距
        layout.minimumLineSpacing = 10;//行与行之间的间距
        layout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, 240);//cell的大小
        _collectionView = [[YZGProductListCollectView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [__weakSelf loadCollectionData];
        }];
        _collectionView.cellClick = ^(NSString *productId){
        };
    }
    return _collectionView;
}
- (UIButton *)changeViewButton
{
    if (_changeViewButton == nil)
    {
        _changeViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_changeViewButton setImage:[UIImage imageNamed:@"tab_classify_pre"] forState:UIControlStateNormal];
        [_changeViewButton setImage:[UIImage imageNamed:@"nav_list"] forState:UIControlStateSelected];
        [_changeViewButton addTarget:self action:@selector(changeViewDisplayStyle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeViewButton;
    
}
- (YZGProductListManager *)manager {
    if (!_manager) {
        _manager = [[YZGProductListManager alloc]init];
    }
    return _manager;
}
- (YZGProductListTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGProductListTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [__weakSelf loadTableData];
        }];
        _tableView.cellClickBlack = ^(NSString *productId){
            [__weakSelf puchDetailProductViewVC:productId];
        };
    }
    return _tableView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionPageNum = 1;
    
    self.tablelPageNum = 1;
    
    [self setNav];
    
    [self getTableDatawithPageNum:_tablelPageNum];
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    

}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.navigationItem.titleView = self.navSearchBar;
    self.navSearchBar.frame = CGRectMake(0, 0, 320, 30);
    
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
    //模式切换按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.changeViewButton];
    self.changeViewButton.frame = CGRectMake(0, 0, 40, 40);
    self.changeViewButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0,-20);
    
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setSearchDic:(NSDictionary *)searchDic
{
  
    NSString *dicKey = @"";
    NSString *dicValue = @"";
    for(NSString *key in searchDic)
    {
       NSLog(@"key :%@  value :%@", key, [searchDic objectForKey:key]);
        dicKey = key;
        dicValue = [searchDic objectForKey:key];
    }
    
    self.navSearchBar.text = dicValue;
    _searchDic = @{@"key":dicKey,@"value":dicValue};
}

#pragma mark ************** 数据
- (void)loadCollectionData
{
    _collectionPageNum++;
    
    [self getCollectionDatawithPageNum:_collectionPageNum];
}
#pragma mark ************** 数据
- (void)loadTableData
{
    _tablelPageNum++;

    [self getTableDatawithPageNum:_tablelPageNum];
}
#pragma mark ************** 获取数据
- (void)getCollectionDatawithPageNum:(NSInteger)pageNum
{
    ESWeakSelf;
    NSDictionary *params = @{@"size":@"10",@"begin":@(pageNum)};
    
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithDictionary:params];
    
   
    [mdict setValue:self.searchDic[@"value"] forKey:self.searchDic[@"key"]];
    
   
    //排序查询
    if(isDecs)
    {
        [mdict setValue:decsString forKey:@"pricesort"];
    }
   
    [self.manager getroductListWithDic:mdict target:self CallBack:^(NSArray *listArray) {
        
        if(!__weakSelf.collectDataArray)
        {
            __weakSelf.collectDataArray = [NSMutableArray array];
        }
        if(pageNum == 1)
        {
            [__weakSelf.collectDataArray removeAllObjects];
        }
        
        [__weakSelf.collectionView.mj_footer endRefreshing];
        
        [__weakSelf.collectDataArray addObjectsFromArray:listArray];
        
        __weakSelf.collectionView.hotArray = __weakSelf.collectDataArray;
        
        if(listArray.count == 0)
        {
            [__weakSelf.collectionView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
    }];
}
#pragma mark ************** 获取数据
- (void)getTableDatawithPageNum:(NSInteger)pageNum
{
     ESWeakSelf;
     NSDictionary *params = @{@"size":@"10",@"begin":@(pageNum)};
    
     NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithDictionary:params];
    
    
    if(self.searchDic)
    {
        [mdict setValue:self.searchDic[@"value"] forKey:self.searchDic[@"key"]];
    }
    
      //排序查询
     if(isDecs)
     {
        [mdict setValue:decsString forKey:@"pricesort"];
     }

    
    [self.manager getroductListWithDic:mdict target:self CallBack:^(NSArray *listArray) {
        
        if(!__weakSelf.tableDataArray)
        {
            __weakSelf.tableDataArray = [NSMutableArray array];
        }
        if(pageNum == 1)
        {
            [__weakSelf.tableDataArray removeAllObjects];
        }
        
         [__weakSelf.tableView.mj_footer endRefreshing];
        
        [__weakSelf.tableDataArray addObjectsFromArray:listArray];
        
         __weakSelf.tableView.dataArray = __weakSelf.tableDataArray;
        
        if(listArray.count == 0)
        {
            [__weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];//设置没有更多数据
        }
    }];
}
#pragma mark **************** 点击导航栏右侧按钮触发
- (void)changeViewDisplayStyle
{
    self.changeViewButton.selected = !self.changeViewButton.selected;
    
    if(self.changeViewButton.selected == YES)
    {
        [self.currentView bringSubviewToFront:self.collectionView];
        
        if(!self.collectDataArray)
        {
            [self getCollectionDatawithPageNum:1];
        }
    }
    else
    {
        [self.currentView bringSubviewToFront:self.tableView];
        
        if(!self.tableDataArray)
        {
            [self getTableDatawithPageNum:1];
        }
    }
    
}
#pragma mark ************** 点击默认
- (void)defaultBtnClickAction
{
    isDecs = NO;
    
    [self loadDataSoure];
}
#pragma mark ************** 点击价格
- (void)priceBtnClickAction:(BOOL)desc
{
    isDecs = YES;
    
    decsString = desc == YES?@"asc":@"desc";
    
    [self loadDataSoure];
}
#pragma mark ************** 点击顶部按钮
- (void)loadDataSoure
{
    
    _collectionPageNum = 1;
    
    _tablelPageNum = 1;
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
    
    [self.collectionView setContentOffset:CGPointMake(0,0) animated:NO];
    
    self.changeViewButton.selected? [self getCollectionDatawithPageNum:_collectionPageNum]:[self getTableDatawithPageNum:_tablelPageNum];
}
#pragma mark ************** 点击筛选
- (void)filterBtnClickAction
{
    
}
#pragma mark ************** 跳转到商品详情
- (void)puchDetailProductViewVC:(NSString *)productId
{
    YZGProductDetailViewVC *vc = [[YZGProductDetailViewVC alloc]init];
    vc.productId = productId;
    vc.index = 0;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ************** 触摸文本框
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    YZGSearchController *searchVC;
    for (UIViewController *viewVC in self.navigationController.viewControllers)
    {
        if ([viewVC isKindOfClass:[YZGSearchController class]])
        {
            [self.navigationController popToViewController:viewVC animated:YES];
            return;
        }
    }
    searchVC = [[YZGSearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
   
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self.view addSubview:self.currentView];
   [self.view addSubview:self.topView];
   [self.currentView addSubview:self.collectionView];
   [self.currentView addSubview:self.tableView];


}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.equalTo(self.view);
        make.height.equalTo(@40);
    }];
    [_currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topView.bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_currentView);
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_currentView);
    }];
    
}
@end

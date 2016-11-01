//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGClassifyVC.h"
#import "YZGClassifyCollectionView.h"
#import "YZGClassifyTableView.h"
#import "YZGClassifyManager.h"
#import "YZGLettersTableView.h"
#import "YZGProductListlViewVC.h"
#import "YZGRankingListViewVC.h"
@interface YZGClassifyVC ()

@property (nonatomic, strong) YZGLettersTableView *lettersView;
@property (nonatomic, strong) YZGClassifyTableView *tableView;
@property (nonatomic, strong) YZGClassifyCollectionView *collectionView;
@property (nonatomic, strong) YZGClassifyManager *manager;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectLayout;


@end

@implementation YZGClassifyVC
#pragma mark ************** 懒加载控件
- (UICollectionViewFlowLayout *)collectLayout
{
    if (!_collectLayout)
    {
        _collectLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectLayout.sectionInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
        _collectLayout.minimumInteritemSpacing = 0; //列与列之间的间距
        _collectLayout.minimumLineSpacing = 0;//行与行之间的间距
        _collectLayout.itemSize = CGSizeMake((SCREEN_WIDTH-100)/3, 90);//cell的大小
    }
    return _collectLayout;
}
- (YZGLettersTableView *)lettersView
{
    if (!_lettersView)
    {
        ESWeakSelf;
        _lettersView = [[YZGLettersTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _lettersView.hidden = YES;
        _lettersView.cellClickBlack = ^(NSInteger index){
            
         [__weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        };
    }
    return _lettersView;
}
- (YZGClassifyCollectionView *)collectionView {
    
    if (!_collectionView) {
        ESWeakSelf;
        _collectionView = [[YZGClassifyCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.collectLayout];
        _collectionView.BtnClick = ^(NSArray *hotArray){
            
             YZGRankingListViewVC *VC = [[YZGRankingListViewVC alloc]init];
            VC.hotArray = hotArray;
            [__weakSelf.navigationController pushViewController:VC animated:YES];
        };
        _collectionView.thisWeekNewProductOnLineAction = ^(NSDictionary *paner){
            
            [__weakSelf bannerClickWithDic:paner];
        };
        _collectionView.cellClick = ^(NSDictionary *paner){
            [__weakSelf bannerClickWithDic:paner];
        };
       
    }
    return _collectionView;
}
- (YZGClassifyTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGClassifyTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.cellClickBlack = ^(NSInteger index){
            
            [__weakSelf showLetterViewWithNSInteger:index];
            
        };
    }
    return _tableView;
}
- (NSString *)choosePuchViewControllerWithDic:(NSDictionary *)paner
{
   NSString *VC = @"";
    
    for (NSString *key in paner)
    {
        if([key isEqualToString:@"uri"])
        {
            VC = @"Web页面";
        }
        else
        {
            VC = @"商品列表";
        }
        if([[paner objectForKey:key] isEqualToString:@"ProductNew"])
        {
            VC = @"本周上新";
        }
        
    }
    if(!paner)
    {
        VC = @"品牌大全";
    }
    
    return VC;
}
#pragma mark ************** 点击banner
- (void)bannerClickWithDic:(NSDictionary *)paner
{
    
    NSString * VCString = [self choosePuchViewControllerWithDic:paner];
    NSLog(@"--xxxxxxc-%@",VCString);
    if([VCString isEqualToString:@"商品列表"])
    {
        YZGProductListlViewVC *vc = [[YZGProductListlViewVC alloc]init];
        vc.searchDic = paner;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}
#pragma mark ************** 显示字母
- (void)showLetterViewWithNSInteger:(NSInteger)index
{
    YZGClassifylModel *firstModel =  self.dataArray[index];
    
    self.collectionView.model = firstModel;
    
    if([firstModel.name isEqualToString:@"品牌"])
    {
        self.lettersView.hidden = NO;
        self.lettersView.dataArray = firstModel.subset;
        
        [_collectionView updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-40);
        }];
        
        _collectLayout.itemSize = CGSizeMake((SCREEN_WIDTH-130)/3, 90);//cell的大小
        _collectionView.collectionViewLayout = _collectLayout;
        
    }
    else
    {
        self.lettersView.hidden = YES;
        
        [_collectionView updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-10);
        }];
        _collectLayout.itemSize = CGSizeMake((SCREEN_WIDTH-100)/3, 90);//cell的大小
        _collectionView.collectionViewLayout = _collectLayout;
    }
}
- (YZGClassifyManager *)manager {
    if (!_manager) {
        _manager = [[YZGClassifyManager alloc]init];
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

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    self.tableView.dataArray = dataArray;
    
    YZGClassifylModel *firstModel = dataArray[0];
    
    self.collectionView.model = firstModel;
}
#pragma mark ************** 获取数据
- (void)getData
{
    ESWeakSelf;
   [self.manager getClassifyListWithTarget:self CallBack:^(NSArray *array) {
       __weakSelf.dataArray = array;
   }];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self.view addSubview:self.tableView];
   [self.view addSubview:self.collectionView];
   [self.view addSubview:self.lettersView];

  
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(@(80));
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.top.bottom.equalTo(self.view);
        make.left.equalTo(_tableView.right).offset(10);
    }];
    [_lettersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.view);
        make.width.equalTo(@30);
    }];
    
}
@end
